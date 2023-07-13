package kr.mds.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import kr.mds.mapper.UserMapper;

@RestController
public class mainRestController {
	
	@Autowired
	private UserMapper mapper;
}
