package kr.mds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class mainController {
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/signIn.com")
	public String singIn() {
		return "signIn";
	}
	
	@RequestMapping("/signUp.com")
	public String singUp() {
		return "signUp";
	}
}
