package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.Paper;
import com.easytop.cms.dao.PaperDao;

@Service
public class PaperService {

	@Autowired
	private PaperDao paperDao;

	public int getTotal(Map<String, String> params) {

		return paperDao.getTotal(params);
	}

	public List<Paper> list(Map<String, String> params) {

		return paperDao.list(params);
	}

	public void deleteById(Map<String, String> params) {
		paperDao.deleteById(params);
	}

	public Paper view(String id) {
		return paperDao.view(id);
	}

	public void add(Map<String, String> params) {
		paperDao.add(params);
	}

	public void update(Map<String, String> params) {
		paperDao.update(params);
	}
	
}
