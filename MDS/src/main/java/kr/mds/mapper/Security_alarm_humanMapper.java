package kr.mds.mapper;

public interface Security_alarm_humanMapper {

	// 알림 읽었을 시 업데이트
	public int sah_numUpdate(long sah_num);

	// 알람 카운트
	public int countSah(String u_id);

	// 캘린더 DB연동
	public String calenderrSah(String u_id);
	
}
