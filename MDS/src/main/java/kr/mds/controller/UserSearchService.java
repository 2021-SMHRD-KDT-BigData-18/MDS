package kr.mds.controller;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class UserSearchService {

    @Autowired
    private JavaMailSender mailSender;

    // 이메일 보내는 메소드
    public void sendEmail(String setFrom, String toMail, String title, String content) {
        MimeMessage message = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // 이메일 보내기
    public String joinEmail(String email, String u_id, String u_pw) {
        String setFrom = ".com"; // 이메일 보내는 사람 이메일 주소
        String toMail = email;
        String title = "ID/PW 찾기 이메일"; // 이메일 제목
        String content = "홈페이지를 방문해주셔서 감사합니다.<br><br>" + "아이디: " + u_id + "<br>" + "패스워드: " + u_pw; // 이메일 내용

        sendEmail(setFrom, toMail, title, content);
        return "이메일이 전송되었습니다.";
    }
}
