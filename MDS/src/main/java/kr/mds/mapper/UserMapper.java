package kr.mds.mapper;

import kr.mds.entity.User;

public interface UserMapper {
	
	// 회원가입
	public int signUp(User user);

	// 로그인
	public User signIn(User user);

	// 아이디 중복 체크
	public User idCheck(String u_id);

	// 회원정보 수정
	public int Updateuser(User user);

	public User userSearch(String email);

	
	
	

}


