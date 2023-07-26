package kr.mds.mapper;

import java.util.ArrayList;

import kr.mds.entity.tb_Security_alarm_car;

public interface Security_alarm_carMapper {
	
	// 출입기록 리스트 조회
	public ArrayList<tb_Security_alarm_car> entryLogList(String u_id);

}
