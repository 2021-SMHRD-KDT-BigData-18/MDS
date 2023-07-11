package kr.mds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	
	@RequestMapping("/")
	public String singUp() {
		return "signUp";
	}
}
