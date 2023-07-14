package kr.mds.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {

	    // 회원 아이디 
	    private String u_id;

	    // 회원 비밀번호 
	    private String u_pw;

	    // 회원 이메일 
	    private String u_email;

	    // 회원 알림설정 
	    private String u_alarm;

	    // 회원 가입일자 
	    private Date u_joindate;

	    // 회원 유형 
	    private String u_type;
	    
	    // 회원 농장주소 
	    private String farm_zip_code;
	    private String farm_detailed_addr;
	    private String farm_addr;
	    private String farm_add_addr;

}