package com.easytop.cms.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easytop.cms.bean.ClassLesson;
import com.easytop.cms.bean.Clazz;
import com.easytop.cms.dao.ClassDao;

@Service
@Transactional
public class ClassService {

	@Autowired
	private ClassDao classDao;

	public String add(Map<String, String> params) {
		return classDao.add(params);
	}

	public int getTotal(Map<String, String> params) {

		return classDao.getTotal(params);
	}

	public List<Clazz> list(Map<String, String> params) {

		List<Clazz> clazzs = classDao.list(params);
		if (clazzs == null) {
			return new ArrayList<Clazz>();
		}

		return clazzs;
	}

	public void deleteById(Map<String, String> params) {

		classDao.deleteById(params);
	}

	public Clazz view(Map<String, String> params) {

		return classDao.view(params);
	}

	public void update(Map<String, String> params) {
		classDao.update(params);
	}

	public void addLesson(String classId, String lesson) {
		
		if (StringUtils.isEmpty(lesson)) {
			return ;
		}
		
		String[] lessons = lesson.split(";");
		for(String lessonId : lessons){
			if (StringUtils.isNotEmpty(lessonId)) {
				classDao.addLesson(new ClassLesson(classId,lessonId));
			}
		}
	}

	public void deleteLesson(String id) {
		classDao.deleteLesson(id);
		
	}

	public List<String> getClassLessons(String classId) {
		
		return classDao.getClassLesson(classId);
	}
	
}
