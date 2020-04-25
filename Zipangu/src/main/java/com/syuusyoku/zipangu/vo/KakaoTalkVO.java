package com.syuusyoku.zipangu.vo;

public class KakaoTalkVO {
	private String kakaoContent;
	private String kakaoName;
	public KakaoTalkVO() {
		// TODO Auto-generated constructor stub
	}
	public KakaoTalkVO(String kakaoContent, String kakaoName) {
		super();
		this.kakaoContent = kakaoContent;
		this.kakaoName = kakaoName;
	}
	public String getKakaoContent() {
		return kakaoContent;
	}
	public void setKakaoContent(String kakaoContent) {
		this.kakaoContent = kakaoContent;
	}
	public String getKakaoName() {
		return kakaoName;
	}
	public void setKakaoName(String kakaoName) {
		this.kakaoName = kakaoName;
	}
	@Override
	public String toString() {
		return "KakaoVO [kakaoContent=" + kakaoContent + ", kakaoName=" + kakaoName + "]";
	}
}
