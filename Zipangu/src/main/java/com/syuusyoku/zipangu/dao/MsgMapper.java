package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.List_MsgVO;
import com.syuusyoku.zipangu.vo.MemberVO;

public interface MsgMapper {
	public void insert_list_msg(List_MsgVO vo);
	public List_MsgVO select_list_msg(List_MsgVO vo);
	
	public int count_list_msg(List_MsgVO vo);
	public ArrayList<List_MsgVO> select_mentee_list(String mentor_id);
	public ArrayList<List_MsgVO> who_user_msg_to(String userID);
	public int withdraw(MemberVO member); //탈퇴로 인한 정보삭제
}