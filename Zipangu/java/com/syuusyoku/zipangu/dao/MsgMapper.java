package com.syuusyoku.zipangu.dao;

import com.syuusyoku.zipangu.vo.List_MsgVO;

public interface MsgMapper {
	public void insert_list_msg(List_MsgVO vo);
	public int select_list_msg(List_MsgVO vo);
	public int count_list_msg(List_MsgVO vo);
	
}
