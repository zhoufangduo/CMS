package com.easytop.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.User;
import com.easytop.cms.dao.LoginDao;
import com.easytop.cms.dao.UserDao;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private LoginDao loginDao;

	public User view(Map<String, String> params) {

		return userDao.view(params);
	}

	public void add(Map<String, String> params) {
		this.userDao.add(params);
	}

	public void deleteById(Map<String, String> params) {
		this.userDao.deleteById(params);
	}

	public void update(Map<String, String> params) {
		this.userDao.update(params);
	}

	public int getTotal(Map<String, String> params) {

		return userDao.getTotal(params);
	}

	public List<User> list(Map<String, String> params) {
		List<User> users = userDao.list(params);
		
		if (users == null) {
			return new ArrayList<User>();
		}
		
		return users;
	}

	public void updatePwd(Map<String, String> params) {
		userDao.updatePwd(params);
	}

	public boolean validatePwd(String password, String username) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("username", username);
		params.put("password", password);
		
		User user = loginDao.login(params);
		if (user == null) {
			return true;
		}
		
		return false;
	}

	public void batchDelete(String[] ids) {
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < ids.length; i++) {
			list.add(ids[i]);
		}
		userDao.batchDelete(list);
	}

}
