package kr.mds.mapper;

import kr.mds.entity.CCTV;

public interface CCTVMapper {
	
	// CCTV 정보 조회
	public CCTV listSelect(String u_id);

}
