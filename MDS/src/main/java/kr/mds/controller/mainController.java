package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mds.entity.User;
import kr.mds.mapper.UserMapper;

@Controller
public class mainController {
	
	@Autowired
	private UserMapper mapper;
	
	// 메인페이지
	@RequestMapping("/")
	public String main(String user_id, Model model) {
		
		// 로그인 후 메인페이지로 이동
		User result = mapper.singIn(user_id);
		model.addAttribute("result", result);
		
		return "main";
	}
	
	// 로그인
	@RequestMapping("/signIn.com")
	public String singIn(User user) {
		
		// 회원가입 후 로그인 페이지로 이동
		mapper.singUp(user);
		
		return "signIn";
	}
	
	// 회원가입
	@RequestMapping("/signUp.com")
	public String singUp() {
		
		return "signUp";
	}
}
