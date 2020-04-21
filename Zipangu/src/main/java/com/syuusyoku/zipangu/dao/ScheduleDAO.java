package com.syuusyoku.zipangu.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.syuusyoku.zipangu.vo.ScheduleVO;

@Repository
public class ScheduleDAO {
	@Autowired
	private SqlSession session;

	public ArrayList<ScheduleVO> scheduleList(HttpSession session) {
		ArrayList<ScheduleVO> scheduleList = null;
		HashMap<String, Object> map = new HashMap<>();
		map.put("userID", (String) session.getAttribute("userID"));
		map.put("authority", (int) session.getAttribute("authority"));
		String date = new SimpleDateFormat("yyyy-MM-01").format(new Date());
		session.setAttribute("date", date);
		map.put("date", date);
		try {
			ScheduleMapper mapper = this.session.getMapper(ScheduleMapper.class);
			scheduleList = mapper.scheduleList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scheduleList;
	}

	@Transactional
	public boolean updateSchedule(HttpSession session, String scheduleList) {
		int result = 0;
		int scheduleListSize = 0;
		try {
			ScheduleMapper mapper = this.session.getMapper(ScheduleMapper.class);
			ScheduleVO[] schedules = new ObjectMapper().readValue(scheduleList, ScheduleVO[].class);
			int authority = (int) session.getAttribute("authority");
			if (authority < 2)
				mapper.deleteSchedule(schedules[0].getMentorID(), (String) session.getAttribute("date"));
			for (ScheduleVO schedule : schedules) {
				if (authority > 1)
					result += mapper.updateSchedule(schedule);
				else
					result += mapper.insertSchedule(schedule);
			}
			scheduleListSize = schedules.length;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result == scheduleListSize;
	}

	public String getMentorID(String menteeID) {
		String mentorID = null;
		ScheduleVO schedule = new ScheduleVO();
		schedule.setMenteeID(menteeID);
		schedule.setReserveDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		try {
			ScheduleMapper mapper = session.getMapper(ScheduleMapper.class);
			mentorID = mapper.getMentorID(schedule);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mentorID;
	}
}