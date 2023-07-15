package kr.mds.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String singUp(User user) {
		mapper.signUp(user);
		
		return "signIn";
	}
	
	// 회원가입 아이디중복 체크
	@PostMapping("/idCheck.com")
	public @ResponseBody String idCheck(@RequestParam("u_id") String u_id) {
//		System.out.println(u_id);
		String res = "";
		if(mapper.idCheck(u_id) == null) res = "true";
		else res = "false";
		return res;
	}

	// 로그인
	@RequestMapping("/signIn.com")
	public String singIn() {
		return "signIn";
	}
	

	// 로그인 후 메인페이지로 이동
	@PostMapping("/")
	public String main(User user, Model model) {
		User result = mapper.signIn(user);
		model.addAttribute("result", result);
		
		if(result != null) {
			return "signIn";
		}else {
			return "main";
		}
	}
	
	
	
	
}
