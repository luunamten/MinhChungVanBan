<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<%
	for (Cookie cookie : request.getCookies()) {
		if (cookie.getName().equals("passUser")){
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		if (cookie.getName().equals("loginUser")){
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	}

	response.sendRedirect("index.jsp");
%>

<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

