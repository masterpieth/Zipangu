package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CompanyVO {

	private int company_num;
	private String userID;
	private String coname;
	private String type;
	private String location;
	private String contact;
	private int count;
}
