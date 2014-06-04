package com.easytop.cms.bean;

import java.io.Serializable;


public class Menu implements Serializable{

	private static final long serialVersionUID = 1L;

	private String id;

	private String name;

	private String pid;

	private String mainUrl;

	private String leftUrl;

	private String icoClass;

	private String icoImage;

	private String isUserPower;

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

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getMainUrl() {
		return mainUrl;
	}

	public void setMainUrl(String mainUrl) {
		this.mainUrl = mainUrl;
	}

	public String getLeftUrl() {
		return leftUrl;
	}

	public void setLeftUrl(String leftUrl) {
		this.leftUrl = leftUrl;
	}

	public String getIcoClass() {
		return icoClass;
	}

	public void setIcoClass(String icoClass) {
		this.icoClass = icoClass;
	}

	public String getIcoImage() {
		return icoImage;
	}

	public void setIcoImage(String icoImage) {
		this.icoImage = icoImage;
	}

	public String getIsUserPower() {
		return isUserPower;
	}

	public void setIsUserPower(String isUserPower) {
		this.isUserPower = isUserPower;
	}

}
