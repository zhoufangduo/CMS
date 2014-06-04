package com.easytop.cms.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

@SuppressWarnings("deprecation")
public class BaseDaoSupport extends SqlMapClientDaoSupport {
	
	@Autowired
	public void setSqlSessionMapClient(SqlMapClient sqlMapClient){
		this.setSqlMapClient(sqlMapClient);
	}
	
	@SuppressWarnings("unchecked")
	protected <T> T insert(String sqlId, final Object params){
		return (T) getSqlMapClientTemplate().insert(sqlId, params);
	}
	
	@SuppressWarnings("unchecked")
	protected <T> List<T> list(String sqlId, final Object params){
		return getSqlMapClientTemplate().queryForList(sqlId, params);
	}
	
	protected int deleteById(String sqlId, final Object params){
		return getSqlMapClientTemplate().delete(sqlId, params);
	}
	
	protected int deleteById(String sqlId, final String id){
		return getSqlMapClientTemplate().delete(sqlId, id);
	}
	
	@SuppressWarnings("unchecked")
	protected <T> T getById(String sqlId, final String id){
		return (T) getSqlMapClientTemplate().queryForObject(sqlId, id);
	}
	
	@SuppressWarnings("unchecked")
	protected <T> T getById(String sqlId, final Object params){
		return (T) getSqlMapClientTemplate().queryForObject(sqlId, params);
	}
	
	protected Integer getTotal(String sqlId, final Object params){
		return (Integer) getSqlMapClientTemplate().queryForObject(sqlId, params);
	}
	
	protected int update(String sqlId, final Object params){
		return getSqlMapClientTemplate().update(sqlId, params);
	}
	
}
