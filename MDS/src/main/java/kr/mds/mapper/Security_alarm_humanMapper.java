package kr.mds.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.mds.entity.tb_Security_alarm_human;

public interface Security_alarm_humanMapper {

	// 알림 읽었을 시 업데이트
	public int sah_numUpdate(long sah_num);

	// 알람 카운트
	public int countSah(String u_id);

	// 캘린더 DB연동
	public ArrayList<tb_Security_alarm_human> calendarSah(String u_id);
	
}
