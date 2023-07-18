package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.mds.entity.CCTV;
import kr.mds.entity.User;
import kr.mds.mapper.CCTVMapper;
import kr.mds.mapper.UserMapper;

@Controller
public class userController {

	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private CCTVMapper cctvmapper;

	// 이메일 인증 의존성 주입
	@Autowired
	private MailSendService mailService;

	// 비밀번호 암호화 의존성 주입
	@Autowired
	private SHA256Util pwEncoder;

	// 회원가입
	@RequestMapping("/signUp.com")
	public String singUp() {
		return "signUp";
	}

	// 회원가입 후 로그인 페이지로 이동
	@PostMapping("/signUp.com")
	public String singUp(User user) {
		// 비밀번호 암호화
		System.out.println("첫번째:" + user.getU_pw());
		System.out.println("첫번째:" + user.getU_pw_confirm());
		// 비밀번호 암호화 (sha256)
		String u_pw = pwEncoder.encrypt(user.getU_pw());
		String u_pw_confirm = pwEncoder.encrypt(user.getU_pw_confirm());
		user.setU_pw(u_pw);
		user.setU_pw_confirm(u_pw_confirm);
		System.out.println("두번째:" + user.getU_pw());
		System.out.println("두번째:" + user.getU_pw_confirm());
		// 회원가입 메서드
		int result = mapper.signUp(user);

		if (result > 0)
			return "redirect:/signIn.com";
		else
			return "signUp";
	}

	// 회원가입 아이디중복 체크
	@PostMapping("/idCheck.com")
	public @ResponseBody String idCheck(@RequestParam("u_id") String u_id) {
//		System.out.println(u_id);
		String res = "";
		if (mapper.idCheck(u_id) == null)
			res = "true";
		else
			res = "false";
		return res;
	}

	// 회원가입 이메일 인증
	@RequestMapping("/checkEmail.com")
	public @ResponseBody String checkEmail(String u_email) {
		System.out.println(u_email);
		return mailService.joinEmail(u_email);
	}

	// 로그인
	@RequestMapping("/signIn.com")
	public String singIn() {
		return "signIn";
	}

	// 로그인 후 메인페이지로 이동
	@PostMapping("/")
	public String main(User user, Model model) {
		
		// 암호화된 비밀번호로 로그인
		System.out.println("첫번째:" + user.getU_pw());
		String u_pw = pwEncoder.encrypt(user.getU_pw());
		user.setU_pw(u_pw);
		System.out.println("두번째:" + user.getU_pw());

		User result = mapper.signIn(user);
		model.addAttribute("result", result);
		
		// 메인페이지에서 아이디에 맞게 rtsp 영상 송신
		CCTV list = cctvmapper.listSelect(user.getU_id());
		model.addAttribute("list", list);

		if (result != null)
			return "main";
		else
			return "redirect:/signIn.com";

	}

	// 로그아웃
	@GetMapping("/logout.com")
	public String logout() {

		return "main";
	}

	// 회원정보수정 페이지 이동
	@RequestMapping("/checkUser.com")
	public String checkUser() {

		return "checkUser";
	}

	// 회원정보 수정
	@PostMapping("/updateuUser")
	public String updateUser(User user, Model model) {

		int result = mapper.Updateuser(user);

		return "redirect:/updateUser.com";

	}

}
