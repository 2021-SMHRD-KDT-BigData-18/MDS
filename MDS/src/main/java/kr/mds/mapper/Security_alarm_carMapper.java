package kr.mds.mapper;

import java.util.ArrayList;
import java.util.List;

import kr.mds.entity.tb_Security_alarm_car;

public interface Security_alarm_carMapper {
	
	// 출입기록 리스트 조회
	public ArrayList<tb_Security_alarm_car> entryLogList(String u_id);

	// 알림 읽었을 시 업데이트
	public int sac_numUpdate(long sac_num);

	// 알림 개수 카운트
	public int countSac(String u_id);

	// 캘린더 DB 연동
	public List<tb_Security_alarm_car> calendarSac(String u_id);


}
