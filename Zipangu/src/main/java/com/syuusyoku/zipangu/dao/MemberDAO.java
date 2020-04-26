package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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

	public void sendSimpleMessage(String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(text);
		mailSender.send(message);
	}

	public boolean login(MemberVO member, HttpSession session) {
		int result = 0;
		try {
			MemberMapper mapper = this.session.getMapper(MemberMapper.class);
			if (mapper.login(member) > 0) {
				member = mapper.getMember(member.getUserID());
				result = mapper.login(member);
				if (result > 0) {
					member = getMember(member.getUserID());
					session.setAttribute("userID", member.getUserID());
					session.setAttribute("authority", member.getAuthority());
					session.setAttribute("userName", member.getUserName());
					return true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public void uploadKakaoText(String userID,String textFileName) {
		MemberVO vo = new MemberVO();
		vo.setUserID(userID);
		vo.setTextFileName(textFileName);
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			mapper.uploadKakaoText(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public MemberVO getMember(String userID) {
		MemberVO result = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.getMember(userID);
		} catch (Exception e) {
			e.printStackTrace();
		} return result;
	}
	
	public ArrayList<MemberVO> mentorList() {
		ArrayList<MemberVO> list = null;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			list = mapper.mentorList();
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}

	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Transactional(rollbackFor = Exception.class)
	public boolean withdraw(MemberVO member) {
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			if (member.getAuthority() == 2)
				mapper.menteeWithdraw(member);
			mapper.withdraw(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	public boolean update(MemberVO member) {
		int result = 0;
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			result = mapper.update(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}
}