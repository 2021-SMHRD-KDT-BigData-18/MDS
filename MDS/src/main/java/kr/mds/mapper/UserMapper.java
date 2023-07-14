package kr.mds.mapper;

import org.apache.ibatis.annotations.Select;

import kr.mds.entity.User;

public interface UserMapper {
	
	// 회원가입
	public void singUp(User user);

	// 로그인, 아이디 중복체크
	@Select("SELECT * FROM user WHERE USER_ID=#{user_id}")
	public User signIn(String user_id);

	
	

}


