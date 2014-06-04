package com.easytop.cms.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easytop.cms.bean.Menu;
import com.easytop.cms.bean.User;
import com.easytop.cms.dao.LoginDao;

@Service
public class LoginServcie {

	@Autowired
	private LoginDao loginDao;

	public User login(Map<String, String> params) {
		return loginDao.login(params);
	}
	
	public List<Menu> getLoginUserPower(String roleType) {
		
		return loginDao.getLoginUserPower(roleType);
	}

	public LoginDao getLoginDao() {
		return loginDao;
	}

	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}

}
