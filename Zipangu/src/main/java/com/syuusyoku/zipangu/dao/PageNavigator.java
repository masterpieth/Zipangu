package com.syuusyoku.zipangu.dao;

import lombok.Data;

@Data
public class PageNavigator {
	private int countPerPage;
	private int pagePerGroup;
	private int currentPage;
	private int totalRecordsCount;
	private int totalPageCount;
	private int currentGroup;
	private int startPageGroup;
	private int endPageGroup;
	private int startRecord;

	public PageNavigator(int countPerPage, int pagePerGroup, int currentPage, int totalRecordsCount) {
		this.countPerPage = countPerPage;
		this.pagePerGroup = pagePerGroup;
		this.totalRecordsCount = totalRecordsCount;
		totalPageCount = (totalRecordsCount + countPerPage - 1) / countPerPage;
		if (currentPage < 1)
			currentPage = 1;
		if (currentPage > totalPageCount)
			currentPage = totalPageCount;
		this.currentPage = currentPage;
		currentGroup = (currentPage - 1) / pagePerGroup;
		startPageGroup = currentGroup * pagePerGroup + 1;
		endPageGroup = startPageGroup + pagePerGroup - 1;
		endPageGroup = endPageGroup > totalPageCount ? totalPageCount : endPageGroup;
		startRecord = (currentPage - 1) * countPerPage;
	}
}