package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Lesson;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class LessonDao extends BaseDaoSupport {

	public void add(Map<String, String> params) {
		insert("easytop.cms.lesson.add", params);
	}

	public int getTotal(Map<String, String> params) {
		return getTotal("easytop.cms.lesson.getTotal", params);
	}

	public List<Lesson> list(Map<String, String> params) {
		return list("easytop.cms.lesson.list", QueryMapUtils.getCastParams(params));
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.lesson.deleteById", params);
	}

	public Lesson view(Map<String, String> params) {
		return getById("easytop.cms.lesson.view", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.lesson.update", params);
	}

	public void updateState(Map<String, String> params) {
		update("easytop.cms.lesson.updateState", params);
	}
}
