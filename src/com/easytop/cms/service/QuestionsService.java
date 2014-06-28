package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easytop.cms.bean.Questions;
import com.easytop.cms.dao.QuestionsDao;

@Service
@Transactional
public class QuestionsService {
	
	@Autowired
	private QuestionsDao qstionsDao;

	public List<Questions> list(Map<String, String> params) {
		
		return qstionsDao.list(params);
	}

	public void add(Map<String, String> params) {
		qstionsDao.add(params);
	}

	public void deleteById(Map<String, String> params) {
		qstionsDao.deleteById(params);
	}

}
