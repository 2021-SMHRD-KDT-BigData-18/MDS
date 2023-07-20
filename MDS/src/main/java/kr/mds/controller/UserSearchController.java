package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.mds.entity.tb_User;
import kr.mds.mapper.UserMapper;

@Controller
public class UserSearchController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserSearchService userSearchService;

    @GetMapping("/userSearch")
    public String userSearchPage() {
        return "userSearch"; 
    }

    @PostMapping("/userSearch")
    @ResponseBody
    public String searchIdAndPassword(@RequestParam("u_email") String email) {
        tb_User user = userMapper.userSearch(email);
        if (user != null) {
            String u_id = user.getU_id();
            String u_pw = user.getU_pw();
            String result = userSearchService.joinEmail(email, u_id, u_pw);
            return "아이디와 비밀번호가 이메일로 전송되었습니다.";
        } else {
            return "해당 이메일에 해당하는 사용자가 없습니다.";
        }
    }
}
