package com.syuusyoku.zipangu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.syuusyoku.zipangu.dao.MemberDAO;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO dao;
}