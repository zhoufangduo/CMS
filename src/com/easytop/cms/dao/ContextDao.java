package com.easytop.cms.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.stereotype.Repository;

import com.easytop.cms.bean.Context;
import com.easytop.cms.web.QueryMapUtils;
import com.ibatis.sqlmap.client.SqlMapExecutor;

@SuppressWarnings("deprecation")
@Repository
public class ContextDao extends BaseDaoSupport{

	public void add(Map<String, String> params) {
		insert("easytop.cms.context.add", params);
	}

	public List<Context> list(Map<String, String> params) {
		
		return list("easytop.cms.context.list", QueryMapUtils.getCastParams(params));
	}

	public void deleteById(Map<String, String> params) {
		deleteById("easytop.cms.context.deleteById", params);
	}

	public Context viewByTechId(Map<String, String> params) {
		
		return getById("easytop.cms.context.viewByTechId", params);
	}

	public Context viewById(Map<String, String> params) {
		
		return getById("easytop.cms.context.viewByTechId", params);
	}

	public void update(Map<String, String> params) {
		update("easytop.cms.context.update", params);
	}

	public void hidden(Map<String, String> params) {
		update("easytop.cms.context.update", params);
	}

	@SuppressWarnings({"unchecked", "rawtypes" })
	public void updateSort(final Map<String, String> params) {
		
		final Iterator<String> iterator =  params.keySet().iterator();
		 getSqlMapClientTemplate().execute(new SqlMapClientCallback() {  
			 public Object doInSqlMapClient(SqlMapExecutor executor)  
			 throws SQLException {  
			     executor.startBatch();  
			     while (iterator.hasNext()) {
					String key = (String) iterator.next();
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", key);
					map.put("sort", params.get(key));
					update("easytop.cms.context.update",map);
				 }
			     executor.executeBatch();  
			     return null;  
			 } 
		});
	}

	public int getMaxSort(Map<String, String> params) {
		return (Integer) ObjectUtils.defaultIfNull(getTotal("easytop.cms.context.getMaxSort", params), 0);
	}

	public int getTotal(Map<String, String> params) {
		return getTotal("easytop.cms.context.getTotal", params);
	}
}
