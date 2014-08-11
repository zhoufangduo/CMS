package com.easytop.cms.web;

import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;

public class Page {

	private int pageSize = 20;

	private int pageNo = 1;

	private int pageTotal;

	private int start;

	private int total;

	public Page(int total, String currentNo, String currentSize) {

		initPage(total, currentSize, currentNo);

		this.pageTotal = total % this.pageSize == 0 ? (total / this.pageSize)
				: (total / this.pageSize + 1);

		if (this.pageNo > pageTotal) {
			this.pageNo = pageTotal;
		}
		
		if (pageNo  <= 0) {
			pageNo = 1;	
		}

		this.start = (this.pageNo - 1) * this.pageSize ;
	}

	public Page(int total, Map<String, String> params) {
		
		this(total, params.get("page.pageNo"), params.get("page.pageSize"));
		
		params.put("start", String.valueOf(this.start));
		params.put("pageSize", String.valueOf(this.pageSize));
	}

	private void initPage(int total, String currentSize, String currentNo) {
		this.total = total;
		this.pageNo = NumberUtils.toInt(currentNo, this.pageNo);
		this.pageSize = NumberUtils.toInt(currentSize, this.pageSize);
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageTotal() {
		return pageTotal;
	}

	public void setPageTotal(int pageTotal) {
		this.pageTotal = pageTotal;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

}
