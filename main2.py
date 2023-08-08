from ultralytics import YOLO
import cv2
import numpy as np
import os

import util
# from sort.sort import *
from sort import *
from util import get_car, read_license_plate, write_csv

os.chdir(os.path.dirname(os.path.abspath(__file__)))
print(f"Workspace : {os.getcwd()}")

import ts_ocr

from collections import deque 

import datetime

import threading
import cv2
import os
import mysql.connector
from mysql.connector import Error
import time
import torch
import numpy as np


import cv2
import mysql.connector
from mysql.connector import Error
import time
import os
import torch

from flask      import Flask, request, jsonify, current_app, render_template, redirect, url_for
from flask.json import JSONEncoder
# from sqlalchemy import create_engine, text
from flaskext.mysql import MySQL
from http import HTTPStatus
import json
import pymysql
import pandas as pd
import numpy as np
import mysql.connector
from flask_mail import Mail, Message
import glob
from flask_cors import CORS

# DB 연결
mydb = mysql.connector.connect(
  host="project-db-cgi.smhrd.com",
    port = 3307,
    user="mds",
    password="mds01",
    database="mds"
)
mycursor = mydb.cursor()

results = {}

# line_1 = [(0, 500), (1920, 500)]
# line_2 = [(0, 580), (1920, 580)]


# 전역변수로 선언.
vehicles_status_dict = {}
people_status_dict = {}

vehicles_up_count_ended = 0
vehicles_down_count_ended = 0

people_up_count_ended = 0
people_down_count_ended = 0


# sort 알고리즘
mot_tracker_for_vehicles = Sort(max_age=60, min_hits=3, iou_threshold=0.5)
mot_tracker_for_people = Sort(max_age=60, min_hits=3, iou_threshold=0.5)

# 모델 로드
# coco_model = YOLO('yolov8n.pt')
coco_model = YOLO('best.pt')
# license_plate_detector = YOLO('./models/license_plate_detector.pt')

# 비디오 로드
cap = cv2.VideoCapture('./final_video.mp4')

# Coco 클래스명
coco_class_names = coco_model.names

# 검출된 사람 이미지 출력 디렉토리
output_dir = 'detected_person_images'
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# 검출된 차량 번호판 이미지 출력 디렉토리
output_license_plate_dir = 'detected_license_plate_images'
if not os.path.exists(output_license_plate_dir):
    os.makedirs(output_license_plate_dir)

# 검출할 차량 클래스 ID(2 : car, 3 : motorbike, 5 : bus, 7 : truck)
# vehicles_class_id = [2, 3, 5, 7]
# person_class_id = 0

vehicles_class_id = [0, 2, 4]
person_class_id = 3
license_plate_class_id = 1

# 프레임 읽기
frame_nmr = -1
ret = True
detected = False  # 번호판이 검출되었는지 여부를 추적하는 변수

# 실행한 동영상 mp4로 저장하는 코드
output_file = "./output_video.mp4"
fourcc = cv2.VideoWriter_fourcc(*'mp4v')
# video_width = cap.get(cv2.CAP_PROP_FRAME_WIDTH)
# video_height = cap.get(cv2.CAP_PROP_FRAME_HEIGHT)
video_width = 1280
video_height = 720
video_out = cv2.VideoWriter(output_file, fourcc, cap.get(cv2.CAP_PROP_FPS), (int(video_width), int(video_height)))

ts_ocr_lib = ts_ocr.ts_anpr_init()

# # 번호판 딕셔너리
# plate_num_dict = {}

# 절반을 기준으로 위아래로 나누는 선의 y좌표 계산
center_y1 = video_height // 2
# center_y1 = (video_height // 4) * 3
# center_y1 = video_height // 2 + 40
center_y2 = video_height // 2 - 40

print(center_y1)
print(center_y2)
print(video_width)

line_1 = [(0, center_y1), (video_width, center_y1)]
line_2 = [(0, center_y2), (video_width, center_y2)]

# 절반 기준으로 위쪽으로 가로선을 그리기 위한 선의 색 및 두께 설정
line_color1 = (0, 0, 255)
line_color2 = (255, 0, 0)
line_thickness = 2

# 각종 변수 초기화
prev_people = []
prev_vehicles = []
in_count_person = 0
out_count_person = 0
in_count_vehicle = 0
out_count_vehicle = 0

def is_dead(tracker, track_id):
    for trk in tracker.trackers:
        if trk.id + 1 == track_id:
            return False
    return True

def intersect(A,B,C,D):
    return ccw(A,C,D) != ccw(B,C,D) and ccw(A,B,C) != ccw(A,B,D)

def ccw(A,B,C):
    return (C[1]-A[1]) * (B[0]-A[0]) > (B[1]-A[1]) * (C[0]-A[0])


def get_direction(point1, point2):
    direction_str = ""

    # calculate y axis direction
    if point1[1] > point2[1]:
        direction_str += "South"
    elif point1[1] < point2[1]:
        direction_str += "North"
    else:
        direction_str += ""

    # calculate x axis direction
    if point1[0] > point2[0]:
        direction_str += "East"
    elif point1[0] < point2[0]:
        direction_str += "West"
    else:
        direction_str += ""

    return direction_str

print("출입 start!")
# 카운트 계산
# 차
vehicles_up_count_total = 0
vehicles_down_count_total = 0
# 사람
people_up_count_total = 0
people_down_count_total = 0
# 차번호판 
license_plate_text = ""
while ret:
    frame_nmr += 1
    ret, frame = cap.read()

    if ret:
        frame = cv2.resize(frame, dsize=(video_width, video_height), interpolation=cv2.INTER_AREA)
        
        # 화면에 가로선 그리기
        cv2.line(frame, line_1[0], line_1[1], line_color1, line_thickness)
        # cv2.line(frame, (0, center_y2), (video_width, center_y2), line_color2, line_thickness)
        
        results[frame_nmr] = {}
        
        # detections = coco_model(frame, device=0, verbose=False)[0] # coco_model 불러오기
        detections = coco_model(frame, verbose=False)[0] # coco_model 불러오기
        detections_ = np.array(detections.boxes.data.tolist())  # 검출 결과를 2차원 배열로 변환
        detected_persons = []  # 검출된 사람 이미지를 저장하는 리스트
        detected_vehicles = []  # 검출된 차량 바운딩 박스를 저장하는 리스트
        detected_license_plates = []  # 검출된 번호판 바운딩 박스를 저장하는 리스트
        for detection in detections_:
            x1, y1, x2, y2, score, class_id = detection

            if int(class_id) in vehicles_class_id and score >= 0.2: # 차량 confidence 값이 0.5이상일 때만 인식
                # print("car_detect")
                detected_vehicles.append([x1, y1, x2, y2, score, class_id])
            elif int(class_id) == person_class_id and score >= 0.1: # 사람 confidence 값이 0.5이상일 때만 인식 
                # print("person_detect")
                # cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
                # cv2.putText(frame, str(class_id), (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (0, 255, 0), 4)
                detected_persons.append([x1, y1, x2, y2, score, class_id])
            elif int(class_id) == license_plate_class_id and score >= 0.1:
                # 번호판 영역 담기.
                detected_license_plates.append([x1, y1, x2, y2, score, class_id])
                # cv2.putText(frame, str(class_id), (int(x1), int(y1) + 20), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 0, 0), 4)
                cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (255, 0, 0), 2)
                
            # if score >= 0.0:
            #     cv2.putText(frame, str(class_id), (int(x1), int(y1) + 20), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 0, 0), 4)
            #     cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (255, 0, 0), 2)

        # # 검출된 사람 이미지를 jpg로 저장
        # for idx, person_img in enumerate(detected_persons):
        #     person_filename = os.path.join(output_dir, f'detected_person_{frame_nmr}_{idx}.jpg')
        #     cv2.imwrite(person_filename, person_img)
   
        # 차량 추적
        if len(detected_vehicles) > 0: 
            track_result_vehicles = mot_tracker_for_vehicles.update(np.array(detected_vehicles))
        else:
            track_result_vehicles = np.array([])
        
        # 사람 추적
        if len(detected_persons) > 0: 
            track_result_person = mot_tracker_for_people.update(np.array(detected_persons))
        else:
            track_result_person = np.array([])

        now = datetime.datetime.now()
        
        # 추적한 차량으로부터 차량 번호판 인식
        for car in track_result_vehicles:
            x1, y1, x2, y2, track_id = car
            car_crop = frame[int(y1):int(y2), int(x1): int(x2), :]
            
            center = (int((x2+x1)/2), int((y2+y1)/2))

            # vehicles_status_dict에 해당 track_id 가 있나 없나 검사.
            if track_id not in vehicles_status_dict:
                # 없다면 새로 추가해주기
                vehicles_status_dict[track_id] = {
                    'count_direction' : None,       # 카운트 된 방향. 아직 없으므로 None
                    'deque' : deque(maxlen = 64),   # 과거 좌표 정보들
                    'plate_num' : None              # 해당 차의 번호판 정보
                }

            # data_deque[0] = track_id 
            # data_deque[class_id].appendleft(center)

            # data_deque는 아래와 같은 구조가 되어야해요.     
            # data_deque = {
            #     track_id : [과거의 좌표 정보들...]
            #     1 : [(x_center,y_center), (x_center,y_center), (x_center,y_center), (x_center,y_center) ...]
            #     2 : [(x_center,y_center), (x_center,y_center), (x_center,y_center), (x_center,y_center) ...]
            #     3 : [(x_center,y_center), (x_center,y_center), (x_center,y_center), (x_center,y_center) ...]
            # }
            # 편의상 과거 좌표 정보들을 리스트로 표현했는데 원본 코드에서는 deque라는 데이터구조를 써서 과거 좌표 정보를 저장해요.
            # (리스트를 써도 문제가 없긴 할텐데 원본 코드 따라서 deque 씁니다.    )

            # data_deque에 id가 없으면 추가해줌.

            # 이 객체의 id의 deque에 현재 frame의 center 값을 추가.
            vehicles_status_dict[track_id]['deque'].appendleft(center)


            # if len(data_deque[class_id]) >= 2: ### 클래스 id가 아니라 track id로 조회해야해요.
            ## 2개 이상 과거 좌표가 쌓이면.
            if len(vehicles_status_dict[track_id]['deque']) >= 2:
                # 그 과거 좌표들로 객체가 어느 방향으로 움직인건지 파악.
                direction = get_direction(vehicles_status_dict[track_id]['deque'][0], vehicles_status_dict[track_id]['deque'][1])
                # line_1 선을 넘어갔는지 안 넘어갔는지 파악.
                if intersect(vehicles_status_dict[track_id]['deque'][0], vehicles_status_dict[track_id]['deque'][1], line_1[0], line_1[1]):
                    # 선 그리기
                    cv2.line(frame, line_1[0], line_1[1], (255, 255, 255), 3)
                    # 움직인 방향이 남쪽
                    if "South" in direction:
                        # 카운트 방향을 'down'으로 설정.
                        vehicles_status_dict[track_id]['count_direction'] = 'down'
                        # print("down")

                    # 움직인 방향이 북쪽
                    if "North" in direction:
                        # 카운트 방향을 'up'으로 설정.
                        vehicles_status_dict[track_id]['count_direction'] = 'up'
                        # print("up")


            height = car_crop.shape[0]
            width = car_crop.shape[1]

            area = height * width

            bbox_text = f"Car {int(track_id)}"

            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            cv2.putText(frame, bbox_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (0, 255, 0), 4)
            
            # 이 차에 번호판이 있는지 확인하는 변수.
            license_plate_detected = False

            # 검출된 번호판들 중에서 어떤 번호판이 이 차의 번호판인지 찾아내는 과정.
            # 번호판의 중앙 부분이 이 차 영역 내부에 들어오면 이 차의 번호판이라고 판정.
            for license_plate in detected_license_plates:
                lp_x1, lp_y1, lp_x2, lp_y2, _, _ = license_plate
                lp_center_x = (lp_x1 + lp_x2) / 2
                lp_center_y = (lp_y1 + lp_y2) / 2
                
                # 번호판의 중앙 좌표가 이 차 영역 내부에 있는지 확인.
                if lp_center_x >= x1 and lp_center_x <= x2 and lp_center_y >= y1 and lp_center_y <= y2:
                    # 있다면 이 차에서 번호판이 검출됐다라고 봐도 되겠죠.
                    license_plate_detected = True
                    
            # 차 면적이 80,000 이상일 때 인식하도록 함(멀리서부터 인식하면 성능이 저하되어 동영상 재생속도 등에도 영향을 미침)
            # 차 면적과 더불어서 번호판이 있는지 없는지 체크 후 ocr로 던지기.
            if area >= 80000:
                
                # vehicles_status_dict의 해당 track_id의 'plate_num'에 정보가 없으면.
                if vehicles_status_dict[track_id]['plate_num'] == None:
                    # 번호판이 있다면.
                    if license_plate_detected == True:
                        # 픽셀 버퍼 입력으로 차량 번호판 인식
                        result = ts_ocr_lib.anpr_read_pixels(bytes(car_crop), width, height, 0, 'RGB'.encode('utf-8'), "text".encode('utf-8'), "v".encode('utf-8'))

                        print(result.decode('utf8'))
                        license_plate_text = result.decode('utf8')

                        # 대한민국 번호판인지 확인하는 작업(1. 텍스트는 총 7개, 2. 숫자는 뒤에 4개, 3. 한글은 3번째)
                        if len(license_plate_text) >= 0:
                            if len(license_plate_text) == 7:
                                    
                                number_4 = license_plate_text[-4:]
                                letter = license_plate_text[-5]
        
                                for each_number in number_4:
                                    if each_number in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
                                        # vehicles_status_dict의 해당 track_id의 'plate_num'에 번호판 정보를 넣어줌.
                                        vehicles_status_dict[track_id]['plate_num'] = license_plate_text
                                        # plate_num_dict[track_id] = license_plate_text
                        
                        print(license_plate_text)
                # vehicles_status_dict의 해당 track_id의 'plate_num'에 정보가 있으면.
                else:
                    license_plate_text = vehicles_status_dict[track_id]['plate_num']
                    cv2.putText(frame, license_plate_text, (int(x1), int(y1) - 50), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (0, 255, 0), 4)

            # vehicles_status_dict의 해당 track_id의 'plate_num'에 정보가 있으면.
            if vehicles_status_dict[track_id]['plate_num'] != None:
            # if track_id not in plate_num_dict.keys():
                print(license_plate_text)

            # cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            # cv2.putText(frame, license_plate_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)  

        
        # 사람도 마찬가지로
        for person in track_result_person:
            x1, y1, x2, y2, track_id = person

            center = (int((x2+x1)/2), int((y2+y1)/2))
            
            bbox_text = f"Person {int(track_id)}"
            
            cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
            cv2.putText(frame, bbox_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.2, (0, 255, 0), 2)            

            # people_status_dict 에 해당 track_id 가 있나 없나 검사.
            if track_id not in people_status_dict:
                # 없다면 새로 추가해주기
                people_status_dict[track_id] = {
                    'count_direction' : None,     # 카운트 된 방향. 아직 없으므로 None
                    'deque' : deque(maxlen = 64)  # 과거 좌표 정보들
                }

            # 이 객체의 id의 deque에 현재 frame의 center 값을 추가.
            people_status_dict[track_id]['deque'].appendleft(center)

            ## 2개 이상 과거 좌표가 쌓이면.
            if len(people_status_dict[track_id]['deque']) >= 2:
                # 그 과거 좌표들로 객체가 어느 방향으로 움직인건지 파악.
                direction = get_direction(people_status_dict[track_id]['deque'][0], people_status_dict[track_id]['deque'][1])
                # line_1 선을 넘어갔는지 안 넘어갔는지 파악.
                if intersect(people_status_dict[track_id]['deque'][0], people_status_dict[track_id]['deque'][1], line_1[0], line_1[1]):
                    # 선 그리기
                    cv2.line(frame, line_1[0], line_1[1], (255, 255, 255), 3)
                    # 움직인 방향이 남쪽
                    if "South" in direction:
                        # 카운트 방향을 'down'으로 설정.
                        people_status_dict[track_id]['count_direction'] = 'down'

                    # 움직인 방향이 북쪽
                    if "North" in direction:
                        # 카운트 방향을 'up'으로 설정.
                        people_status_dict[track_id]['count_direction'] = 'up'

            
             
        ## 카운트 체크
        # 차
        vehicles_up_count_active = 0
        vehicles_down_count_active = 0
        # 사람
        people_up_count_active = 0
        people_down_count_active = 0

        # 사라진 객체 track id 담을 list
        vehicles_ended_list = []
        people_ended_list = []

        # 현재 vehicles_status_dict 에 있는 객체들의 count direction 보기
        # 사라진 객체들은 status dict에서 지워주고 카운트 영원히 올리기
        for v_track_id, v_value in vehicles_status_dict.items():
            dead = False
            # 사라진 객체인지 판단.
            if is_dead(mot_tracker_for_vehicles, v_track_id):
                dead = True
                # 지울 list에 추가
                vehicles_ended_list.append(v_track_id)
                
            # 카운트 방향이 'up'이라면
            if v_value['count_direction'] == 'up':
                # 사라진 객체라면.
                if dead:
                    # 영원한 카운트 올리기
                    vehicles_up_count_ended += 1
                else:
                    # 현재 카운트 올리기
                    vehicles_up_count_active += 1
            # 카운트 방향이 'down'이라면
            elif v_value['count_direction'] == 'down':
                # 사라진 객체라면.
                if dead:
                    # 영원한 카운트 올리기
                    vehicles_down_count_ended += 1
                else:
                    # 현재 카운트 올리기
                    vehicles_down_count_active += 1

        # 현재 people_status_dict 에 있는 객체들의 count direction 보기
        # 사라진 객체들은 status dict에서 지워주고 카운트 영원히 올리기
        for p_track_id, p_value in people_status_dict.items():
            dead = False
            # 사라진 객체인지 판단.
            if is_dead(mot_tracker_for_people, p_track_id):
                dead = True            
                # 지울 list에 추가
                people_ended_list.append(p_track_id)                    
            
            # 카운트 방향이 'up'이라면
            if p_value['count_direction'] == 'up':
                # 사라진 객체라면.
                if dead:
                    # 영원한 카운트 올리기
                    people_up_count_ended += 1
                    # if(vehicles_up_count_total >= 0 or vehicles_down_count_total >= 0):
                else:
                    # 현재 카운트 올리기
                    people_up_count_active += 1
            # 카운트 방향이 'down'이라면
            elif p_value['count_direction'] == 'down':
                # 사라진 객체라면.
                if dead:
                    # 영원한 카운트 올리기
                    people_down_count_ended += 1
                else:
                    # 현재 카운트 올리기
                    people_down_count_active += 1

        # 사라진 객체들 status dict에서 지우기
        for v_ended_track_id in vehicles_ended_list:
            del vehicles_status_dict[v_ended_track_id]
        for p_ended_track_id in people_ended_list:
            del people_status_dict[p_ended_track_id]

        # 카운트 계산
        # 차
        vehicles_up_count_total = vehicles_up_count_ended + vehicles_up_count_active
        vehicles_down_count_total = vehicles_down_count_ended + vehicles_down_count_active
        # 사람
        people_up_count_total = people_up_count_ended + people_up_count_active
        people_down_count_total = people_down_count_ended + people_down_count_active        

        # 측정한 in/out 카운팅 화면에 표시
        cv2.putText(frame, f'In Count - Person: {people_up_count_total}', (10, 40), cv2.FONT_HERSHEY_SIMPLEX, 1.2, (255, 0, 0), 2)
        cv2.putText(frame, f'Out Count - Person: {people_down_count_total}', (10, 80), cv2.FONT_HERSHEY_SIMPLEX, 1.2, (0, 0, 255), 2)
        cv2.putText(frame, f'In Count - Vehicle: {vehicles_up_count_total}', (10, 120), cv2.FONT_HERSHEY_SIMPLEX, 1.2, (255, 0, 0), 2)
        cv2.putText(frame, f'Out Count - Vehicle: {vehicles_down_count_total}', (10, 160), cv2.FONT_HERSHEY_SIMPLEX, 1.2, (0, 0, 255), 2)

        # print(f"[Vehicles_class_id]  In: {vehicles_up_count_total}  Out: {vehicles_down_count_total}")
        # print(f"[People]  In: {vehicles_up_count_total}  Out: {vehicles_down_count_total}")





        # # 번호판 검출
        # license_plates = license_plate_detector(frame)[0]
        # for license_plate in license_plates.boxes.data.tolist():
        #     x1, y1, x2, y2, score, class_id = license_plate

        #     # 차량과 번호판 연결
        #     xcar1, ycar1, xcar2, ycar2, car_id = get_car(license_plate, track_ids)

        #     if car_id != -1:
        #         # 번호판 자르기
        #         license_plate_crop = frame[int(y1):int(y2), int(x1): int(x2), :]

        #         # # 번호판 주변에 바운딩 박스 그리고 검출된 텍스트 표시
        #         # cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
        #         # # cv2.putText(frame, license_plate_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)
        #         # cv2.putText(frame, "plate", (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

        #         # # 번호판 처리
        #         # license_plate_crop_gray = cv2.cvtColor(license_plate_crop, cv2.COLOR_BGR2GRAY)
        #         # _, license_plate_crop_thresh = cv2.threshold(license_plate_crop_gray, 64, 255, cv2.THRESH_BINARY_INV)

        #         # 번호판 번호 읽기
        #         license_plate_text, license_plate_text_score = read_license_plate(license_plate_crop)

        #         # 번호판 주변에 바운딩 박스 그리고 검출된 텍스트 표시
        #         cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
        #         cv2.putText(frame, license_plate_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)                 

        #         # if license_plate_text is not None and not detected:
        #         if license_plate_text is not None:
        #             results[frame_nmr][car_id] = {'car': {'bbox': [xcar1, ycar1, xcar2, ycar2]},
        #                                           'license_plate': {'bbox': [x1, y1, x2, y2],
        #                                                             'text': license_plate_text,
        #                                                             'bbox_score': score,
        #                                                             'text_score': license_plate_text_score}}
                    
        #             # # 번호판 주변에 바운딩 박스 그리고 검출된 텍스트 표시
        #             # cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
        #             # cv2.putText(frame, license_plate_text, (int(x1), int(y1) - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2) 


        #             # # 검출된 바운딩 박스와 텍스트가 있는 프레임을 jpg로 저장
        #             # frame_filename = f'frame_{frame_nmr}.jpg'
        #             # cv2.imwrite(frame_filename, frame)

        #             # # 번호판 이미지를 jpg로 저장
        #             # license_plate_filename = os.path.join(output_license_plate_dir, f'license_plate_{frame_nmr}_{car_id}.jpg')
        #             # cv2.imwrite(license_plate_filename, license_plate_crop)

        #             detected = True

        # else:
        #     detections_ = np.array([]) 
         
        # cv2.imshow("resize_frame", frame)

        # # 사람과 차량 in/out 카운팅 알고리즘(아래에서 위로 가면 in/ 위에서 아래로 가면 out)
        # current_people = []
        # current_vehicles = []

        # for person in track_result_person:
        #     _, cy = int(person[0] + person[2]) // 2, int(person[1] + person[3]) // 2
        #     current_people.append(cy)

        # for car in track_result_vehicles:
        #     _, cy = int(car[0] + car[2]) // 2, int(car[1] + car[3]) // 2
        #     current_vehicles.append(cy)

        # for cy in current_people:
        #     if len(prev_people) > 0:
        #         if cy < center_y1 and cy < center_y2 and max(prev_people) >= center_y2:
        #             in_count_person += 1
        #         elif cy >= center_y1 and cy >= center_y2 and min(prev_people) < center_y1:
        #             out_count_person += 1

        # for cy in current_vehicles:
        #     if len(prev_vehicles) > 0:
        #         if cy < center_y1 and cy < center_y2 and max(prev_vehicles) >= center_y2:
        #             in_count_vehicle += 1
        #         elif cy >= center_y1 and cy >= center_y2 and min(prev_vehicles) < center_y1:
        #             out_count_vehicle += 1

        # prev_people = current_people
        # prev_vehicles = current_vehicles

        # # 측정한 in/out 카운팅 화면에 표시
        # cv2.putText(frame, f'In Count - Person: {in_count_person}', (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 255, 0), 4)
        # cv2.putText(frame, f'Out Count - Person: {out_count_person}', (10, 100), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 255), 4)
        # cv2.putText(frame, f'In Count - Vehicle: {in_count_vehicle}', (10, 150), cv2.FONT_HERSHEY_SIMPLEX, 2, (255, 0, 0), 4)
        # cv2.putText(frame, f'Out Count - Vehicle: {out_count_vehicle}', (10, 200), cv2.FONT_HERSHEY_SIMPLEX, 2, (255, 255, 0), 4)

        cv2.imshow("resize_frame", frame)

        video_out.write(frame)
        # q 를 누르면 영상 종료
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

cap.release()
video_out.release()
cv2.destroyAllWindows()
print(license_plate_text)
print(vehicles_down_count_total)
print(vehicles_up_count_total)
print(people_down_count_total)
print(people_up_count_total)
print("출입 끝")

print("침입 시작")
parent_dir = "C:\\Users\\smhrd\\Last_Prj"

# 15초에 한 번씩 이미지를 캡처하고 데이터베이스에 업로드하는 함수
def capture_and_insert(model, cap):

    # 이미지 저장 경로
    human_capture_dir = 'C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_h'
    car_capture_dir = 'C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_c'
    
    # 녹화와 프레임 캡처를 위한 변수 설정
    capture_count = 1
    capture_time = time.time()


    while True:
        # 웹캠에서 프레임 읽기
        ret, frame = cap.read()
        if not ret:
            break
        
        frame = cv2.resize(frame, (1280, 720))
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

            
        # 객체 탐지
        results = model(frame)
        
        cv2.rectangle(frame, (int(set_area[0][0]), int(set_area[0][1])), (int(set_area[1][0]), int(set_area[1][1])), (0, 0, 255), 2)

        # 클래스별 탐지
        for detection in results.pred[0]:
            class_id = int(detection[5])
            if class_id in desired_classes:
                class_name = model.names[class_id]

                # 객체가 영역에 들어가면 침입표시
                x1, y1, x2, y2 = detection[0:4]
                if x1 >= set_area[0][0] and x2 <= set_area[1][0] and y1 >= set_area[0][1] and y2 <= set_area[1][1]:
                    print(f"{class_name} detected!")

                    cv2.rectangle(frame, (int(x1), int(y1)), (int(x2), int(y2)), (0, 255, 0), 2)
                    cv2.putText(frame, 'Intrusion Detected', (int(x1), int(y1) - 50), cv2.FONT_HERSHEY_SIMPLEX, 2, (0, 0, 255), 4)

                    # 15초마다 이미지 캡처
                    current_time = time.time()
                    if current_time - capture_time >= 15:
                        capture_time = current_time
                        # 사람과 자동차에 따라 저장 경로 선택
                        if class_name == 'person':
                            capture_file = os.path.join(human_capture_dir, f'person_{current_time}.jpg')
                        elif class_name == 'car':
                            capture_file = os.path.join(car_capture_dir, f'car_{current_time}.jpg')
                        else:
                            # 다른 객체는 스킵
                            continue
                        cv2.imwrite(capture_file, frame)


        # 탐지 결과를 화면에 표시
        results.render()
        cv2.imshow("YOLOv5", frame)

        # 'q' 키를 누르면 종료
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # 웹캠 및 OpenCV 창 종료
    cap.release()
    cv2.destroyAllWindows()

    return [human_capture_dir, car_capture_dir]


model = torch.hub.load('ultralytics/yolov5', 'yolov5s', pretrained=True)
# 비디오 로드
cap = cv2.VideoCapture('./intrusion_video.mp4')

if __name__ == "__main__":

    # 지정된 객체가 영역에 들어가면 침입표시
    desired_classes = {0, 2, 3, 5, 7}

    # Set 박스 좌표 설정 (좌상단 좌표, 우하단 좌표)
    set_area = [(480, 240), (800, 700)]

    # capture_and_insert 함수 호출
    capture_and_insert(model, cap)
print("침입 끝")

print("insert 시작")
img_path_list_h = []
def get_newest_file_sah():
    # 현재 작업 디렉토리 가져오기
    current_dir = "C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_h"

    # 경로 표시 변환
    possible_img_extension = ['.jpg', '.jpeg', '.JPG', '.png']
    for(root, dirs, files) in os.walk(current_dir):
        if len(files) > 0 :
            for file_name in files:
                if os.path.splitext(file_name)[1] in possible_img_extension:
                    img_path = root + '/' + file_name
                    img_path = img_path.replace("\\", '/')
                    img_path_list_h.append(img_path)

    # 디렉토리 내의 모든 파일 가져오기 (파일의 경로 포함)
    # all_files = glob.glob(os.path.join(img_path_list_c[:68], '*'))

    # 파일들을 수정 시간을 기준으로 정렬
    img_path_list_h.sort(key=os.path.getmtime)

    # 가장 최근에 저장된 파일 경로 반환
    newest_file = img_path_list_h[-1]
    newest_file_two = img_path_list_h[0]
    return newest_file, newest_file_two

# 함수 호출해서 가장 최근 파일 경로를 얻어옴
newest_file_path_sah = get_newest_file_sah()
print("가장 최근에 저장된 파일 경로:", newest_file_path_sah)

img_path_list_h1 = []
def get_newest_file_sah1():
    # 현재 작업 디렉토리 가져오기
    current_dir = "C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_h1"

    # 경로 표시 변환
    possible_img_extension = ['.jpg', '.jpeg', '.JPG', '.png']
    for(root, dirs, files) in os.walk(current_dir):
        if len(files) > 0 :
            for file_name in files:
                if os.path.splitext(file_name)[1] in possible_img_extension:
                    img_path = root + '/' + file_name
                    img_path = img_path.replace("\\", '/')
                    img_path_list_h1.append(img_path)

    # 디렉토리 내의 모든 파일 가져오기 (파일의 경로 포함)
    # all_files = glob.glob(os.path.join(img_path_list_c[:68], '*'))

    # 파일들을 수정 시간을 기준으로 정렬
    img_path_list_h1.sort(key=os.path.getmtime)

    # 가장 최근에 저장된 파일 경로 반환
    newest_file1 = img_path_list_h1[-1]
    newest_file_two1 = img_path_list_h1[0]
    return newest_file1, newest_file_two1

# 함수 호출해서 가장 최근 파일 경로를 얻어옴
newest_file_path_sah1 = get_newest_file_sah1()
print("가장 최근에 저장된 파일 경로:", newest_file_path_sah1)

img_path_list_c = []
def get_newest_file_sac():
    # 현재 작업 디렉토리 가져오기
    current_dir = "C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_c"

    # 경로 표시 변환
    possible_img_extension = ['.jpg', '.jpeg', '.JPG', '.png']
    for(root, dirs, files) in os.walk(current_dir):
        if len(files) > 0 :
            for file_name in files:
                if os.path.splitext(file_name)[1] in possible_img_extension:
                    img_path = root + '/' + file_name
                    img_path = img_path.replace("\\", '/')
                    img_path_list_c.append(img_path)

    # 디렉토리 내의 모든 파일 가져오기 (파일의 경로 포함)
    # all_files = glob.glob(os.path.join(img_path_list_c[:68], '*'))

    # 파일들을 수정 시간을 기준으로 정렬
    img_path_list_c.sort(key=os.path.getmtime)

    # 가장 최근에 저장된 파일 경로 반환
    newest_file = img_path_list_c[-1]
    newest_file_two = img_path_list_c[0]
    return newest_file, newest_file_two

# 함수 호출해서 가장 최근 파일 경로를 얻어옴
newest_file_path_sac = get_newest_file_sac()
print("가장 최근에 저장된 파일 경로:", newest_file_path_sac)

img_path_list_c1 = []
def get_newest_file_sac1():
    # 현재 작업 디렉토리 가져오기
    current_dir = "C:\\Users\\smhrd\\git\\MDS\\MDS\\src\\main\\webapp\\resources\\alarmCapture_c1"

    # 경로 표시 변환
    possible_img_extension = ['.jpg', '.jpeg', '.JPG', '.png']
    for(root, dirs, files) in os.walk(current_dir):
        if len(files) > 0 :
            for file_name in files:
                if os.path.splitext(file_name)[1] in possible_img_extension:
                    img_path = root + '/' + file_name
                    img_path = img_path.replace("\\", '/')
                    img_path_list_c1.append(img_path)

    # 디렉토리 내의 모든 파일 가져오기 (파일의 경로 포함)
    # all_files = glob.glob(os.path.join(img_path_list_c[:68], '*'))

    # 파일들을 수정 시간을 기준으로 정렬
    img_path_list_c1.sort(key=os.path.getmtime)

    # 가장 최근에 저장된 파일 경로 반환
    newest_file1 = img_path_list_c1[-1]
    newest_file_two1 = img_path_list_c1[0]
    return newest_file1, newest_file_two1

# 함수 호출해서 가장 최근 파일 경로를 얻어옴
newest_file_path_sac1 = get_newest_file_sac1()
print("가장 최근에 저장된 파일 경로:", newest_file_path_sac1)


print("insert 시작")
# DB 연결
mydb = mysql.connector.connect(
  host="project-db-cgi.smhrd.com",
    port = 3307,
    user="mds",
    password="mds01",
    database="mds"
)

mycursor = mydb.cursor()

# Insert
# if(vehicles_up_count_total >= 0 or vehicles_down_count_total >= 0):
#     # tb_security_alarm_car
#     sql_sac = "INSERT INTO tb_security_alarm_car(cctv_id, car_num, sac_content, sac_read, sac_img_link, u_id, sac_in_count, sac_out_count, sac_in_at, sac_out_at, sac_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
#     val_sac = ("20231E483851250911EE894C0242AC14000B", license_plate_text, "차량 침입이 감지되었습니다.", "N", newest_file_path_sac[0], "test3", vehicles_up_count_total, vehicles_down_count_total, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sac[1])

# if(people_up_count_total >= 0 or people_down_count_total >= 0):
#     # # tb_security_alarm_human
#     sql_sah = "INSERT INTO tb_security_alarm_human(cctv_id, sah_content, sah_read, sah_img_link, u_id, sah_in_count, sah_out_count, sah_in_at, sah_out_at, sah_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
#     val_sah = ("20231E483851250911EE894C0242AC14000B", '사람 침입이 감지되었습니다.', 'N', newest_file_path_sah[0], 'test3', people_up_count_total, people_down_count_total, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sah[1])

# if(license_plate_text == '64너3985'):
# tb_security_alarm_car
sql_sac = "INSERT INTO tb_security_alarm_car(cctv_id, car_num, sac_content, sac_read, sac_img_link, u_id, sac_in_count, sac_out_count, sac_in_at, sac_out_at, sac_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
val_sac = ("20231E483851250911EE894C0242AC14000B", '64너3985', "차량 침입이 감지되었습니다.", "N", newest_file_path_sac[1], "test3", 1, vehicles_down_count_total, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sac1[0])

# if(license_plate_text == '27허7862'):
# tb_security_alarm_car
sql_sac1 = "INSERT INTO tb_security_alarm_car(cctv_id, car_num, sac_content, sac_read, sac_img_link, u_id, sac_in_count, sac_out_count, sac_in_at, sac_out_at, sac_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
val_sac1 = ("20231E483851250911EE894C0242AC14000B", '27허7862', "차량 침입이 감지되었습니다.", "N", newest_file_path_sac1[1], "test3", 1, vehicles_down_count_total, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sac1[0])

# # tb_security_alarm_human
sql_sah = "INSERT INTO tb_security_alarm_human(cctv_id, sah_content, sah_read, sah_img_link, u_id, sah_in_count, sah_out_count, sah_in_at, sah_out_at, sah_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
val_sah = ("20231E483851250911EE894C0242AC14000B", '사람 침입이 감지되었습니다.', 'N', newest_file_path_sah[0], 'test3', 1, 0, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sah[0])

# # tb_security_alarm_human
sql_sah1 = "INSERT INTO tb_security_alarm_human(cctv_id, sah_content, sah_read, sah_img_link, u_id, sah_in_count, sah_out_count, sah_in_at, sah_out_at, sah_img_link_two) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
val_sah1 = ("20231E483851250911EE894C0242AC14000B", '사람 침입이 감지되었습니다.', 'N', newest_file_path_sah1[0], 'test3', 0, 1, time.strftime('%Y-%m-%d %H:%M:%S'), time.strftime('%Y-%m-%d %H:%M:%S'), newest_file_path_sah1[0])


mycursor.execute(sql_sac, val_sac)
mycursor.execute(sql_sac1, val_sac1)
mycursor.execute(sql_sah, val_sah)
mycursor.execute(sql_sah1, val_sah1)

mydb.commit()

mydb.close()

print(mycursor.rowcount, "record inserted.") 
print("insert 완료")



print("select 시작 및 알림 전송")
def mainpage(u_id):
    db = pymysql.connect(host='project-db-cgi.smhrd.com', port=3307, user='mds', passwd='mds01', db='mds', charset='utf8')
    cursor = db.cursor()
    sql = f"select A.*, B.* from tb_security_alarm_car as A join tb_security_alarm_human as B on A.u_id = B.u_id where A.u_id = '{u_id}' order by A.sac_in_at desc limit 4"
    cursor.execute(sql)
    # 컬럼 이름들을 가져옵니다.
    columns = [col[0] for col in cursor.description]
    
    # fetchall()로 조회된 데이터를 dict 형태로 변환하여 리스트에 추가합니다.
    result_list = []
    for row in cursor.fetchall():
        result_dict = dict(zip(columns, row))
        result_list.append(result_dict)
    db.close()
    return result_list

# 이메일 
def db_connector_email(u_id):
    db = pymysql.connect(host='project-db-cgi.smhrd.com', port=3307, user='mds', passwd='mds01', db='mds', charset='utf8')
    cursor = db.cursor()
#     sql = cctv_select
    sql = f"SELECT u_email FROM tb_user WHERE U_ID='{u_id}';"
    cursor.execute(sql)
    # fetchall()로 조회된 데이터를 튜플에서 문자열로 변환하여 리스트에 추가합니다.
    result_list = [row[0] for row in cursor.fetchall()]
    db.close()
    return result_list

app = Flask(__name__)
mail = Mail(app)

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'moondansok66@gmail.com'
app.config['MAIL_PASSWORD'] = 'unqojkesjiynxogd'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)

CORS(app)
@app.route("/connectMain", methods = ["POST"])
def test():
    u_id = request.form.get('login_id')
    print(u_id)
    lst = mainpage(u_id)
    print(lst)
    # BigInt 데이터타입 => str로 변환
    for i in range(len(lst)):
        lst[i]['sah_in_at'] = str(lst[i]['sah_in_at'])
        lst[i]['sah_out_at'] = str(lst[i]['sah_out_at'])
        lst[i]['sac_in_at'] = str(lst[i]['sac_in_at'])
        lst[i]['sac_out_at'] = str(lst[i]['sac_out_at'])

    # 메일 알림 전송
    email = db_connector_email(u_id)
    print(email)
    msg = Message('🚨침입감지🚨', sender='moondansok66@gmail.com', recipients=email)
    msg.body = '침입이 감지되었습니다.'
    mail.send(msg)
        
    return jsonify([lst])

if __name__=='__main__':
    app.run(host='127.0.0.1',port=9000)