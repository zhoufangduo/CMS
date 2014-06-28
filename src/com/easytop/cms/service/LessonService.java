package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easytop.cms.bean.Lesson;
import com.easytop.cms.dao.LessonDao;

@Service
@Transactional
public class LessonService {
	
	@Autowired
	private LessonDao lessonDao;

	public void add(Map<String, String> params) {
		lessonDao.add(params);
	}

	public int getTotal(Map<String, String> params) {
		return lessonDao.getTotal(params);
	}

	public List<Lesson> list(Map<String, String> params) {
		return lessonDao.list(params);
	}

	public void deleteById(Map<String, String> params) {
		lessonDao.deleteById(params);
	}

	public Lesson view(Map<String, String> params) {
		return lessonDao.view(params);
	}

	public void update(Map<String, String> params) {
		lessonDao.update(params);
	}

}
