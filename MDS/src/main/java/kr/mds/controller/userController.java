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

	// 로그인 후 메인페이지로 이동
	@PostMapping("/")
	public String main(String user_id, Model model) {
		User result = mapper.singIn(user_id);
		model.addAttribute("result", result);

		return "main";
	}

	// 회원가입
	@RequestMapping("/signUp.com")
		public String singUp(String user_id) {
			// 회원가입할 때 아이디 중복 체크
//			System.out.println(id);
			String res = "";
			
			if(user_id == null) {
				res = "true";
			}else {
				res = "false";
			}

			return "signUp";
		}

	// 회원가입 후 로그인 페이지로 이동
	@PostMapping("/signIn.com")
	public String singIn(User user) {
		mapper.singUp(user);
		return "signIn";
	}

	// 로그인
	@RequestMapping("/signIn.com")
	public String singIn() {
		return "signIn";
	}
}
