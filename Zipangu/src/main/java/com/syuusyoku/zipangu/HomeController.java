package com.syuusyoku.zipangu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header() {
		return "include/header";
	}
	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public String footer() {
		return "include/footer";
	}
	@RequestMapping(value = "/maintemp", method = RequestMethod.GET)
	public String main() {
		return "main";
	}
}