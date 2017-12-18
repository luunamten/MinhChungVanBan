<%@page import="model.ThongBao"%>
<%@page import="dao.ThongBaoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>


<% ThongBaoDAO thongbao_dao = new ThongBaoDAO(); %>

<div class="panel panel-primary">

	<div class="panel-heading">
		<h3 class="panel-title">Chi tiết Thông báo</h3>
	</div>
	<div class="panel-body">
			<% ThongBao thongbao = thongbao_dao.GetThongBaoByID(request.getParameter("id")); %>
			
			<p class="media-heading" style="font-size: 17px"><strong><%=thongbao.getTieuDe()%></strong></p>
			<i>Đăng tải ngày <%=thongbao.getThoiGianDang() %></i>
			<br><br>
			<p style="text-indent: 20px; font-size: 16px"><%=thongbao.getNoiDung()%></p>
	</div>
</div>

<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

