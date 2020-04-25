package com.syuusyoku.zipangu.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

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
	
	public String chatAnswer(String chatContent) {

		String url = "https://www.vorkers.com/company_list?field=&pref=&src_str="+chatContent+"&sort=1&ct=top";
		Document doc = null;
		
		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Elements element = doc.select("div.searchCompanyName");
		Element temp = element.get(0);
		
		//첫번째로 나오는 회사 url로 
		String url2 = "https://www.vorkers.com" + temp.select("h3 > a").attr("href");
		System.out.println(url2);
		Document doc2 = null;
		
		try {
			doc2 = Jsoup.connect(url2).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Elements element2 = doc2.select("div#mainTitle");
		String companyName = "会社名 : "+ element2.get(0).select("h2").text();
		System.out.println(companyName);
		
		
		Elements element3 = doc2.select("div.jsCompanyInfo > dl > dd"); 
		
		String businessType = "業種 : "+ element3.get(0).select("li > a").text();
		System.out.println(businessType);
		String companyURL = "URL : "+element3.get(1).select("a").text();
		System.out.println(companyURL);
		String companyLocation = "所在地 : "+element3.get(2).select("dd").text();
		System.out.println(companyLocation);
		String employeeNum = "社員数 : "+element3.get(3).select("dd").text();
		System.out.println(employeeNum);
		String yearofEstablishment = "設立年 : "+element3.get(4).select("dd").text();
		System.out.println(yearofEstablishment);
		String companyCapital = "資本金 : "+element3.get(5).select("dd").text();
		System.out.println(companyCapital);
		String companyRepresentative = "代表者 : " +element3.get(6).select("dd").text();
		System.out.println(companyRepresentative);
		String answer= companyName+", "+businessType+", "+companyURL+", "+companyLocation+", "+employeeNum+", "+yearofEstablishment+", "+companyCapital+", "+companyRepresentative;
		return answer;
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
	
	public ArrayList<List_MsgVO> who_user_msg_to(String userID) {
		ArrayList<List_MsgVO> list = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			list = mapper.who_user_msg_to(userID);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
	

	public ArrayList<List_MsgVO> select_lis_msg_mentor(HashMap<String, String> map) {
		ArrayList<List_MsgVO> list = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			list = mapper.select_lis_msg_mentor(map);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
			
	public ArrayList<List_MsgVO> select_list_msg_mentee(HashMap<String, String> map) {
		ArrayList<List_MsgVO> list = null;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			list = mapper.select_list_msg_mentee(map);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}

}

