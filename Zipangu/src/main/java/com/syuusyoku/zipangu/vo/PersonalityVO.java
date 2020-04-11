package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PersonalityVO {
	private String userID;
	private String trait;
	private double rate;
	public PersonalityVO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
