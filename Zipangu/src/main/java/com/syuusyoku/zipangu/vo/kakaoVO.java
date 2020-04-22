package com.syuusyoku.zipangu.vo;

public class kakaoVO {
	private String kakaoContent;
	private String kakaoName;
	
	public kakaoVO() {
	}

	public kakaoVO(String kakaoContent, String kakaoName) {
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
		return "kakaoVO [kakaoContent=" + kakaoContent + ", kakaoName=" + kakaoName + "]";
	}
	
}
