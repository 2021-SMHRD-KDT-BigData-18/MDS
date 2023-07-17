package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mds.mapper.CCTVMapper;


@Controller
public class mainController {

	

	// 메인페이지
	@RequestMapping("/")
	public String main() {
		return "main";
	}

	

}
