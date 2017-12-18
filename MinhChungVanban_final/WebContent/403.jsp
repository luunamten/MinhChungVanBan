<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<%
	ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
%>
<div class="alert alert-danger">
	<%
		if (errors != null) {
			for (String error : errors) {
				out.println(error);
				out.println("<div class=\"clearfix\"></div>");
			}
		}
		else
		{
			out.println("Bạn không có quyền truy cập vào trang này!");
			out.println("<div class=\"clearfix\"></div>");	
		}
	%>
</div>
<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

