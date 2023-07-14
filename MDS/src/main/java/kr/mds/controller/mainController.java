package kr.mds.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class mainController {

	

	// 메인페이지
	@RequestMapping("/")
	public String main() {
		return "main";
	}

	

}
