package kr.mds.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.mysql.cj.xdevapi.JsonArray;

import kr.mds.entity.tb_Security_alarm_car;
import kr.mds.entity.tb_Security_alarm_human;
import kr.mds.entity.tb_User;
import kr.mds.mapper.Security_alarm_carMapper;
import kr.mds.mapper.Security_alarm_humanMapper;
import kr.mds.mapper.UserMapper;

@RestController
public class mainRestController {
	
	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private Security_alarm_carMapper sacmapper;
	
	@Autowired
	private Security_alarm_humanMapper sahmapper;
	
	
	@PostMapping("/getEntryLog")
	public ArrayList<tb_Security_alarm_car> entryList(@RequestParam("u_id") String u_id) {
		
//		System.out.println(u_id);
		ArrayList<tb_Security_alarm_car> entryList= sacmapper.entryLogList(u_id);
		System.out.println(entryList);
		
		return entryList;
	}
	
	
	// 이미지 JSP에 보이게 하는 비동기 기능
	@GetMapping("/showImage.com")
	public ResponseEntity<byte[]>view(String fileName) throws Exception {
		
		//파일객체를 만들어 이미지를 접근하는 경로와 파라미터로 받은 파일이름을 넣어줘서 객체선언 
        File file= new File(fileName);
		
        //응답을 보낼때 http부분을 커스텀 마이징 해서 보내기 위하여 byte타입의 ResponseEntity 선언
		ResponseEntity<byte[]> result = null;
		
		try {
			//HttpHeaders 선언
			HttpHeaders header = new HttpHeaders();
			
            //HttpHeaders의 Content-type는 클라이언트에게 보낼 문서가 어떤종류의 문서인지 문서종류에 대한 정의
            //probeContentType()은 파일의 확장자를 이용하여 MIME타입을 알려줌
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
            //FileCopyUtils.copyToByteArray 는 대상 파일을 복사하여 Byte 배열로 반환해주는 클래스임.
            //HttpStatus.OK는 이작업이 잘 완료 되었다면 200 ok 사인을 보내라!
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
        //마지막에 http정의 해준 부분을 넣어줌
		return result;
	}
	
	
	// 알람 읽었을 때 'Y'로 업데이트
	@PostMapping("/sac_numUpdate.com")
	public int sac_numUpdate(@RequestParam("sac_num") long sac_num) {
//		System.out.println("sac_num "+sac_num);
		int result = sacmapper.sac_numUpdate(sac_num);
//		System.out.println("sac_num 업데이트 결과 "+result);
		
		return result;
		
	}
	
	@PostMapping("/sah_numUpdate.com")
	public int sah_numUpdate(@RequestParam("sah_num") long sah_num) {
//		 System.out.println("sah_num " + sah_num);
		 int result = sahmapper.sah_numUpdate(sah_num);
//		 System.out.println("sah_num 업데이트 결과 "+result);
		return result;
	}
	
	// 알림 개수 카운트
	@PostMapping("/countAlarm.com")
	public String countAlarm(@RequestParam("u_id") String u_id) {
		int count_sah = sahmapper.countSah(u_id);
		int count_sac = sacmapper.countSac(u_id);
		int result = count_sac + count_sah;
		/*System.out.println(count_sac);
		System.out.println(count_sah);
		System.out.println(result);*/
		return String.valueOf(result);
	}
	
	
	// 캘린더 DB연동
	@GetMapping("/calendarDB.com")
	public ResponseEntity<String> calendarDB(@RequestParam("u_id") String u_id, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		
		Map<String, List<?>> result = new HashMap<>();
		
//		System.out.println(u_id);
		List<tb_Security_alarm_human> sah = sahmapper.calendarSah(u_id);
		result.put("sah", sah);
		List<tb_Security_alarm_car> sac = sacmapper.calendarSac(u_id);
		result.put("sac", sac);
//		System.out.println(result);
		
		// List 배열을 json으로 데이터변환
		String json = new Gson().toJson(result);
		System.out.println(json);
		
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

	    return new ResponseEntity<>(json, headers, HttpStatus.OK);

	}	
	
	
	
	
}
