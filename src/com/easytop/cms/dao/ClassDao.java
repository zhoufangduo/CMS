package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.ClassLesson;
import com.easytop.cms.bean.Clazz;
import com.easytop.cms.web.QueryMapUtils;

@Repository
public class ClassDao extends BaseDaoSupport{

	public String add(Map<String, String> params) {
		String id = insert("easytop.cms.class.add", params);
		return id;
	}
	
	public Integer getTotal(Map<String, String> params) {
		return getTotal("easytop.cms.class.getTotal", params);
	}

	public List<Clazz> list(Map<String, String> params) {
		return list("easytop.cms.class.list", QueryMapUtils.getCastParams(params));
	}
	
	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.class.deleteById", params);
	}

	public Clazz view(Map<String, String> params) {
		return getById("easytop.cms.class.view", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.class.update", params);
	}

	public void addLesson(ClassLesson classLesson) {
		insert("easytop.cms.class.addLesson", classLesson);
	}

	public void deleteLesson(String id) {
		deleteById("easytop.cms.class.deleteLesson", id);
	}

	public List<String> getClassLesson(String classId) {
		return list("easytop.cms.class.getClassLesson", classId);
	}

}
