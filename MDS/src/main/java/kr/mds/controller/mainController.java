package kr.mds.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.mds.entity.tb_CCTV1;
import kr.mds.entity.tb_User;
import kr.mds.mapper.CCTVMapper;
import kr.mds.mapper.UserMapper;

@Controller
public class mainController {

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private CCTVMapper cctvmapper;

	// 비밀번호 암호화 의존성 주입
	@Autowired
	private SHA256Util pwEncoder;
	
	// 시작페이지
	@RequestMapping("/")
	public String start() {
		return "start";
	}
	// 메인페이지
	@RequestMapping("/main.com")
	public String main() {
		return "main";
	}

	// 로그인 후 메인페이지로 이동
	@PostMapping("/main.com")
	public String main(tb_User user, Model model) {

		// 암호화된 비밀번호로 로그인
		System.out.println("첫번째:" + user.getU_pw());
		String u_pw = pwEncoder.encrypt(user.getU_pw());
		user.setU_pw(u_pw);
		System.out.println("두번째:" + user.getU_pw());

		tb_User result = mapper.signIn(user);
		model.addAttribute("result", result);

		// 메인페이지에서 아이디에 맞게 rtsp 영상 송신
		tb_CCTV1 list = cctvmapper.listSelect(user.getU_id());
		model.addAttribute("list", list);

		if (result != null)
			return "main";
		else
			return "redirect:/";

	}
	
	// 웹에서의 실시간 알림
	

}
