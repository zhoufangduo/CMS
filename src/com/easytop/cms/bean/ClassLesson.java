package com.easytop.cms.bean;

public class ClassLesson {
	
	private String id;

	private String classId;

	private String lessonId;

	private String sort;

	public ClassLesson(String classId, String lessonId) {
		this.classId = classId;
		this.lessonId = lessonId;
	}
	
	public ClassLesson() {
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public String getLessonId() {
		return lessonId;
	}

	public void setLessonId(String lessonId) {
		this.lessonId = lessonId;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}
