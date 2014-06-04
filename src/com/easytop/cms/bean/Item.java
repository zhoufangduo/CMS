package com.easytop.cms.bean;

public class Item {

	private String id;

	private String name;

	private String fileName;

	private String newFileName;

	private String downloadAddr;

	private String group;

	private String devTime;

	private String context;

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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getDownloadAddr() {
		return downloadAddr;
	}

	public void setDownloadAddr(String downloadAddr) {
		this.downloadAddr = downloadAddr;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getDevTime() {
		return devTime;
	}

	public void setDevTime(String devTime) {
		this.devTime = devTime;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getNewFileName() {
		return newFileName;
	}

	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

}
