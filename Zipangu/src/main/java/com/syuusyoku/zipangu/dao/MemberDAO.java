package com.syuusyoku.zipangu.dao;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.MemberVO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSession session;
	@Autowired
	private JavaMailSender mailSender;

	public boolean checkID(String userID) {
		int result = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.checkID(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public boolean signup(MemberVO member) {
		int result = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.signup(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public void sendSimpleMessage(String address, String title, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(address);
		message.setSubject(title);
		message.setText(text);
		mailSender.send(message);
	}

	public boolean login(MemberVO member, HttpSession session) {
		member = getMember(member);
		try {
			if (member.getUserID().length() > 0) {
				session.setAttribute("userID", member.getUserID());
				session.setAttribute("userPwd", member.getUserPwd());
				session.setAttribute("authority", member.getAuthority());
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public MemberVO getMember(MemberVO member) {
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.getMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}

	public void logout(HttpSession session) {
		session.invalidate();
	}
}