package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mds.entity.User;
import kr.mds.mapper.UserMapper;

@Controller
public class userController {

	@Autowired
	private UserMapper mapper;

	// 회원가입
	@RequestMapping("/signUp.com")
		public String singUp() {
			return "signUp";
		}

	// 회원가입 후 로그인 페이지로 이동
	@PostMapping("/signUp.com")
	public String singIn(User user, String u_id) {
		mapper.signUp(user);
		
		return "signIn";
	}

	// 로그인
	@RequestMapping("/signIn.com")
	public String singIn() {
		return "signIn";
	}
	

	// 로그인 후 메인페이지로 이동
	@PostMapping("/")
	public String main(String user_id, Model model) {
		User result = mapper.signIn(user_id);
		model.addAttribute("result", result);

		return "main";
	}
}
