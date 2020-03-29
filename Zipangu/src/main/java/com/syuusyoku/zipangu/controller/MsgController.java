package com.syuusyoku.zipangu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MsgController {
	
	@RequestMapping(value = "msg/msg_main", method = RequestMethod.GET)
	public String msg_main() {
		return "msg/msg_main";
	}
}
