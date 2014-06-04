package com.easytop.cms.bean;

public class Paper {

	private String id;

	private String name;

	private String introduce;

	private String time;

	private String createTime;

	private String creator;

	private String qstionsTotal;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getQstionsTotal() {
		return qstionsTotal;
	}

	public void setQstionsTotal(String qstionsTotal) {
		this.qstionsTotal = qstionsTotal;
	}

}
