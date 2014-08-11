package com.easytop.cms.web.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import com.easytop.cms.web.Page;

public class PaginableTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private int pageNo;

	private int pageSize;
	
	private int total;

	private String url;

	private String params;
	
	private String formId;

	private Page page;

	@Override
	public int doEndTag() throws JspException {

		StringBuffer buffer = new StringBuffer();

		buffer.append(getSubmitFun());
		
		buffer.append("总共").append(page.getTotal()).append("条记录,总").append(total).append("页&nbsp;");
		
		buffer.append("<div class=\"pagination\"><ul>");
		
		initProPageHtml(buffer);
		
		if (page.getPageTotal() > 1) {
			buffer.append("<li class=\"active\"><a>"+pageNo+"</a></li>");
		}
		
		initNextPageHtml(buffer);
		
		buffer.append("</ul></div>");

		try {
			pageContext.getOut().print(buffer.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return SKIP_BODY;
	}

	private void initNextPageHtml(StringBuffer buffer) {
		if (pageNo + 5 <= total) {
			getNextPage(pageNo + 4);
		}else{
			
			for(int i = pageNo + 1; i <= total; i ++ ){
				buffer.append("<li><a href=\"javascript:toPage("+i+")\">"+i+"</a></li>");
			}
		}
		
		if (pageNo < total) {
			buffer.append("<li><a href=\"javascript:toPage("+ (pageNo + 1) +")\" class=\"fui-arrow-right\"></a></li>");
		}
	}

	private void initProPageHtml(StringBuffer buffer) {
		
		if (page.getTotal()  >  pageSize) {
			if (pageNo > 1) {
				buffer.append("<li><a href=\"javascript:toPage("+ (pageNo -1) +")\" class=\"fui-arrow-left\"></a></li>");
			}
			
			if (pageNo > 5) {
				buffer.append(getProPage(pageNo));
			}else {
				for(int i = 1; i < pageNo; i ++ ){
					buffer.append("<li><a href=\"javascript:toPage("+i+")\">"+i+"</a></li>");
				}
			}
		}
	}

	private String getProPage(int end) {
		
		StringBuffer buffer = new StringBuffer();
		
		buffer.append("<li><a href=\"javascript:toPage(1)\">首页</a></li>");
		
		for(int i = (end - 4); i < end; i ++ ){
			buffer.append("<li><a href=\"javascript:toPage("+i+")\">"+i+"</a></li>");
		}
		
		return buffer.toString();
	}
	
	
	private String getNextPage(int end) {
		
		StringBuffer buffer = new StringBuffer();
		
		for(int i = (end - 4); i < end; i ++ ){
			buffer.append("<li><a href=\"javascript:toPage("+i+")\">"+i+"</a></li>");
		}
		
		buffer.append("<li><a href=\"javascript:toPage("+total+")\">末页</a></li>");
		
		return buffer.toString();
	}

	private String getSubmitFun() {
		StringBuffer buffer = new StringBuffer();
		
		addFormPage(buffer);	
		
		buffer.append("<script type=\"text/javascript\">\n");
		buffer.append("function toPage(pageNo) {\n");
		
		if (StringUtils.isNotEmpty(formId)) {
			addForm(buffer);
		}else {
			
			buffer.append(" var action ;\n ");
			
			addURL(buffer);
			
			buffer.append("action += '?page.pageNo='+pageNo;\n");
			buffer.append("action += '&page.pageSize=").append(pageSize).append("'\n");
			if (StringUtils.isNotEmpty(params)) {
				buffer.append("action += '&").append(params).append("'\n");
			}
			
			buffer.append("window.location = action;\n");
		} 
		
		buffer.append("}\n</script>\n");
		
		return buffer.toString();
	}

	private void addFormPage(StringBuffer buffer) {
		buffer.append("<input type='hidden' id=\"pageNo\" name='page.pageNo'/>\n");
		buffer.append("<input type='hidden' id=\"pageSize\" name='page.pageSize'/>\n");
		buffer.append("<input type='hidden' id=\"params\" name='params'/>\n");
	}

	private void addURL(StringBuffer buffer) {
		if (StringUtils.isNotEmpty(url)) {
			buffer.append("action = '").append(url).append("'\n");
		}else {
			String oldURL = (String) this.pageContext.getRequest()
					.getAttribute("javax.servlet.forward.request_uri");
			buffer.append("action = '").append(oldURL).append("'\n");
		}
	}

	private void addForm(StringBuffer buffer) {
		buffer.append("$(\"#pageNo\").val(").append("pageNo);\n");
		buffer.append("$(\"#pageSize\").val(").append(pageSize).append(");\n");
		if (StringUtils.isNotEmpty(params)) {
			buffer.append("$(\"#params\").val('").append(params).append("';\n");
		}
		buffer.append("if($('#"+formId+"') != undefined){$('#"+formId+"').submit();}\n");
	}
	
	
	@Override
	public int doStartTag() throws JspException {

		return SKIP_BODY;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.pageNo = page.getPageNo();
		this.pageSize = page.getPageSize();
		this.total = page.getPageTotal();
		this.page = page;
	}

	public String getFormId() {
		return formId;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

}
