package kr.mds.mapper;

import java.util.ArrayList;

import kr.mds.entity.tb_CCTV1;

public interface CCTVMapper {
	
	// CCTV 정보 조회
	public tb_CCTV1 listSelect(String u_id);

}
