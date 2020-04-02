package com.syuusyoku.zipangu.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.List_MsgVO;

@Repository
public class MsgDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insert_list_msg(List_MsgVO vo) {
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			mapper.insert_list_msg(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int select_list_msg(List_MsgVO vo) {
		int msg_num = 0;
		try {
			MsgMapper mapper = sqlSession.getMapper(MsgMapper.class);
			msg_num = mapper.select_list_msg(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} return msg_num;
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
}

