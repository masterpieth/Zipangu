package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.syuusyoku.zipangu.vo.ScheduleVO;

public interface ScheduleMapper {

	ArrayList<ScheduleVO> scheduleList(HashMap<String, Object> map);

	int updateSchedule(ScheduleVO schedule);

	void deleteSchedule(HashMap<String, String> map);

	int insertSchedule(ScheduleVO schedule);

	String getMentorID(ScheduleVO schedule);
}