package com.syuusyoku.zipangu;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header() {
		return "include/header";
	}

	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public String footer() {
		return "include/footer";
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		return "main";
	}

	@RequestMapping(value = "/alert", method = RequestMethod.GET)
	public String alert() {
		return "alert";
	}
}