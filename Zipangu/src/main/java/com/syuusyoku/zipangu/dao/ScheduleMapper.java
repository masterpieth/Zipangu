package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.syuusyoku.zipangu.vo.ScheduleVO;

public interface ScheduleMapper {

	ArrayList<ScheduleVO> scheduleList(HashMap<String, Object> map);

	int updateSchedule(ScheduleVO schedule);

	int deleteSchedule(String mentorID, String date);

	int insertSchedule(ScheduleVO schedule);

	String getMentorID(ScheduleVO schedule);
}