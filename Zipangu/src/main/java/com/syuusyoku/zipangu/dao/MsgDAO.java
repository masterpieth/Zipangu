package com.syuusyoku.zipangu.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.List_MsgVO;

@Repository
public class MsgDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public String chatBot(String chatContent) {

		String url = "https://job.mynavi.jp/21/pc/corpinfo/searchCorpListByGenCond/index?actionMode=searchFw&srchWord="+chatContent+"&q="+chatContent+"&SC=corp";
		System.out.println("주소"+url);
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 주요 뉴스로 나오는 태그를 찾아서 가져오도록 한다.
		Elements element = doc.select("div.boxSearchresultEach.corp.label");
		
		// 1. 헤더 부분의 제목을 가져온다.
		String title = element.select("h3").text().substring(0, 4);	//substring(0, 4)

		System.out.println("============================================================");
		System.out.println(title);
		chatContent = title;
		System.out.println("============================================================");
		
//		for(Element el : element.select("li")) {	// 하위 뉴스 기사들을 for문 돌면서 출력
//			chatContent +=el.text();
//			System.out.println(el.text());
//		}
		
		System.out.println("============================================================");
		return chatContent;
	}

	public void insert_list_msg(List_MsgVO vo) {
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			mapper.insert_list_msg(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List_MsgVO select_list_msg(List_MsgVO vo) {
		List_MsgVO result = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			result = mapper.select_list_msg(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} return result;
	}
	
	public int count_list_msg(List_MsgVO vo) {
		int result = 0;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			result = mapper.count_list_msg(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} return result;
	}
	
	public ArrayList<List_MsgVO> select_mentee_list(String mentor_id) {
		ArrayList<List_MsgVO> list = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			list = mapper.select_mentee_list(mentor_id);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
	
	public ArrayList<List_MsgVO> who_user_msg_to(String userID) {
		ArrayList<List_MsgVO> list = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			list = mapper.who_user_msg_to(userID);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}

}

