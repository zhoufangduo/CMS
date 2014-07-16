package com.easytop.cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Questions;


@Repository
public class QuestionsDao  extends BaseDaoSupport{

	public List<Questions> list(Map<String, String> params) {
		return list("easytop.cms.questions.list", params);
	}

	public void add(Map<String, String> params) {
		insert("easytop.cms.questions.add", params);
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.questions.deleteById", params);
	}

	public void addUserAnswer(List<Map<String, String>> list) {
		insert("easytop.cms.questions.batchAdd", list);
	}

	public void addUserScoreTotal(Map<String, String> params) {
		insert("easytop.cms.questions.addAnswerTotal", params);
	}

}
