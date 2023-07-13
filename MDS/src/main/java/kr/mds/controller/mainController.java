package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mds.entity.User;
import kr.mds.mapper.UserMapper;

@Controller
public class mainController {

	

	// 메인페이지
	@RequestMapping("/")
	public String main() {
		return "main";
	}

	

}
