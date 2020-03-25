package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.Collections;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewDAO {

	@Autowired
	private SqlSession session;

	public ArrayList<QuestionVO> selectList(){
		ArrayList<QuestionVO> list = null;
		
		try {
			InterviewMapper mapper = session.getMapper(InterviewMapper.class);
			list = mapper.selectList();
			
			Collections.shuffle(list);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
}
