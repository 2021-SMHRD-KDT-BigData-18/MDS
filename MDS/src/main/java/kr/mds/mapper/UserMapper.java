package kr.mds.mapper;

import kr.mds.entity.tb_User;

public interface UserMapper {
	
	// 회원가입
	public int signUp(tb_User user);

	// 로그인
	public tb_User signIn(tb_User user);

	// 아이디 중복 체크
	public tb_User idCheck(String u_id);

	// 회원정보 수정
	public int Updateuser(tb_User user);

	public tb_User userSearch(String email);

	
	
	

}


