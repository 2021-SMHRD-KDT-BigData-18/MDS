package kr.mds.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.mds.entity.tb_Security_alarm_car;
import kr.mds.entity.tb_User;
import kr.mds.mapper.Security_alarm_carMapper;
import kr.mds.mapper.UserMapper;

@RestController
public class mainRestController {
	
	@Autowired
	private UserMapper mapper;
	
	@Autowired
	private Security_alarm_carMapper sacmapper;
	
	
	@PostMapping("/getEntryLog")
	public ArrayList<tb_Security_alarm_car> entryList(@RequestParam("u_id") String u_id) {
		
//		System.out.println(u_id);
		ArrayList<tb_Security_alarm_car> entryList= sacmapper.entryLogList(u_id);
//		System.out.println(entryList);
		
		return entryList;
	}
	
	
	
}
