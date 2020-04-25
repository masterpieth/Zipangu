package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.syuusyoku.zipangu.vo.List_MsgVO;

public interface MsgMapper {
	public void insert_list_msg(List_MsgVO vo);
	public List_MsgVO select_list_msg(List_MsgVO vo);
	public ArrayList<List_MsgVO> select_lis_msg_mentor(HashMap<String, String> map);
	public ArrayList<List_MsgVO> select_list_msg_mentee(HashMap<String, String> map);
	public int count_list_msg(List_MsgVO vo);
	public ArrayList<List_MsgVO> who_user_msg_to(String userID);
}
