package com.easytop.cms.web.tag;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

import com.easytop.cms.bean.Menu;
import com.easytop.cms.bean.User;


public class MenuTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private String contextPath;

	@Override
	public int doEndTag() throws JspException {
		contextPath = ((HttpServletRequest) pageContext.getRequest()).getContextPath();

		try {
			String menuBody = getMenuBody();
			pageContext.getOut().print(menuBody);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return SKIP_BODY;
	}

	@SuppressWarnings("unchecked")
	private String getMenuBody() {
		List<Menu> menus = (List<Menu>) pageContext.getSession().getAttribute("userPower");
		if (menus == null) {
			return "";
		}

		return buildMenuBody(new StringBuffer(""), getSortMenus(menus, "0"));
	}

	private List<MenuItem> getSortMenus(List<Menu> menus, String pid) {
		List<MenuItem> items = new LinkedList<MenuItem>();
		for (Menu menu : menus) {
			if (menu.getPid().equals(pid)) {
				MenuItem item = new MenuItem(menu, getSortMenus(menus,menu.getId()));
				items.add(item);
			}
		}

		return items;
	}

	private String buildMenuBody(StringBuffer buffer, List<MenuItem> menus) {
		addWindowFunction(buffer);
		initNavbarHead(buffer);

		addMenuBody(buffer, menus);

		initNavbarEnd(buffer);
		return buffer.toString();
	}

	private void addMenuBody(StringBuffer buffer, List<MenuItem> menus) {
		for (MenuItem item : menus) {
			Menu menu = item.getMenu();
			String mainUrl = menu.getMainUrl();
			String leftUrl = menu.getLeftUrl();
			if (StringUtils.isEmpty(leftUrl)) {
				leftUrl = "";
			}

			if (StringUtils.isNotEmpty(mainUrl)) {
				buffer.append("<li>\n<a href=\"javascript:forward('").append(
						leftUrl);
				buffer.append("', '").append(mainUrl).append("')\">");
			} else {
				buffer.append("<li>\n<a href=\"javascript:forward('").append(
						leftUrl);
				buffer.append("', ''").append(")\">");
			}

			String ico = menu.getIcoClass();
			if (StringUtils.isNotEmpty(ico)) {
				buffer.append("<span class='").append(ico)
						.append("'></span>&nbsp;&nbsp;");
			}

			buffer.append(menu.getName());
			if ("消息".equals(menu.getName())) {
				buffer.append("<span class='navbar-unread'>1</span>");
			}
			buffer.append("</a>\n");

			List<MenuItem> subMenus = item.getSubMenus();
			if (subMenus.size() > 0) {
				buffer.append("<ul>\n");
				addMenuBody(buffer, subMenus);
				buffer.append("</ul>\n");
			}
			buffer.append("</li>\n");
		}
	}

	private void initNavbarEnd(StringBuffer buffer) {
		buffer.append("<li><a href='").append(contextPath)
				.append("/login/logout' >").append("<img src='");
		buffer.append(contextPath)
				.append("/resource/images/control-power.png'>&nbsp;注销 </a></li></ul>\n</div>\n</div>\n</div>");
	}

	private void initNavbarHead(StringBuffer buffer) {
		User user = (User) pageContext.getSession().getAttribute("user");
		buffer.append("<div class='fixed_top'>\n<div class='navbar navbar-inverse'>\n<div class='navbar-header'>\n");
		buffer.append("<button type='button' class='btn btn-navbar' data-toggle='collapse' data-target='.navbar-collapse-01'></button></div>\n");
		buffer.append("<div class='navbar-collapse collapse navbar-collapse-01'>\n<ul class='nav navbar-nav navbar-left'>\n");
		buffer.append("<li><a href='#'>Welcome ").append(user.getName())
				.append(" ! </a></li>\n");
	}

	private void addWindowFunction(StringBuffer buffer) {
		buffer.append("<script type=\"text/javascript\">\n");
		buffer.append("function forward(leftUrl,mainUrl){$('#mainFrame').attr('src',mainUrl);\n");
		buffer.append("if(leftUrl == '' || leftUrl == 'null' || leftUrl == null){hideMenu();\n"); 
		buffer.append("$('#menuFrame').attr('src','../resource/blank_menu.jsp');}\n");
		buffer.append("else{$('#menuFrame').attr('src',leftUrl);}}");
		buffer.append("\n</script>\n");
	}

	@Override
	public int doStartTag() throws JspException {
		return SKIP_BODY;
	}
}
