package com.syuusyoku.zipangu.vo;

public class TimelineVO {
	private int timeline_Num;
	
	private String userID;
	private String traits_Selected;
	
	private String episode_Title;
	private String episode_Content;
	
	private String start_Date;
	private String finish_Date;
	public TimelineVO() {
	}
	public TimelineVO(int timeline_Num, String userID, String traits_Selected, String episode_Title,
			String episode_Content, String start_Date, String finish_Date) {
		this.timeline_Num = timeline_Num;
		this.userID = userID;
		this.traits_Selected = traits_Selected;
		this.episode_Title = episode_Title;
		this.episode_Content = episode_Content;
		this.start_Date = start_Date;
		this.finish_Date = finish_Date;
	}
	public int getTimeline_Num() {
		return timeline_Num;
	}
	public void setTimeline_Num(int timeline_Num) {
		this.timeline_Num = timeline_Num;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTraits_Selected() {
		return traits_Selected;
	}
	public void setTraits_Selected(String traits_Selected) {
		this.traits_Selected = traits_Selected;
	}
	public String getEpisode_Title() {
		return episode_Title;
	}
	public void setEpisode_Title(String episode_Title) {
		this.episode_Title = episode_Title;
	}
	public String getEpisode_Content() {
		return episode_Content;
	}
	public void setEpisode_Content(String episode_Content) {
		this.episode_Content = episode_Content;
	}
	public String getStart_Date() {
		return start_Date;
	}
	public void setStart_Date(String start_Date) {
		this.start_Date = start_Date;
	}
	public String getFinish_Date() {
		return finish_Date;
	}
	public void setFinish_Date(String finish_Date) {
		this.finish_Date = finish_Date;
	}
	@Override
	public String toString() {
		return "TimelineVO [timeline_Num=" + timeline_Num + ", userID=" + userID + ", traits_Selected="
				+ traits_Selected + ", episode_Title=" + episode_Title + ", episode_Content=" + episode_Content
				+ ", start_Date=" + start_Date + ", finish_Date=" + finish_Date + "]";
	}
	
}
