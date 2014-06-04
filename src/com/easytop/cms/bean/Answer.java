package com.easytop.cms.bean;

public class Answer {

	private String id;

	private String username;

	private String questionsId;

	private String answer;

	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getQuestionsId() {
		return questionsId;
	}

	public void setQuestionsId(String questionsId) {
		this.questionsId = questionsId;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
