<%@page import="java.util.List"%>
<%@page import="dao.MinhChungDAO"%>
<%@page import="model.MinhChung"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<%HoatDong hoatdong = hoatdong_dao.getHoatDongbyID(request.getParameter("idhd"));%>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title"><%=hoatdong.getTenHoatDong()%></h3>
	</div>
	<div class="panel-body">
	
	<div class="media">
				<div class="media-left">
					<img src="<%=(hoatdong.getAnh()==null || hoatdong.getAnh().trim().isEmpty())?"images/slideshow5.jpg":hoatdong.getAnh()%>" class="media-object"
						style="width: 280px; height: 210px; border-radius: 5px;">
				</div>
				<div class="media-body" style="text-align: justify;">
					<p><%=hoatdong.getMoTa()%></p>
				</div>
	</div>
	
	<br> <br>
	
<% if ((taiKhoan == null) || !taiKhoanDAO.login(taiKhoan)) { %>
	<div class="alert alert-danger">Vui lòng đăng nhập để xem các minh chứng của hoạt động này!</div>
<% } else {	
		MinhChungDAO minhchung_dao = new MinhChungDAO();
		List<Integer> years = minhchung_dao.GetDSNamDangMinhChungTheoHD(hoatdong.getID());
		if (years.size() > 0) { %>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Danh sách minh chứng theo từng năm</h3>
	</div>
	<div class="panel-body">
		<div class="list-group list-group-root well">
			<% for(Integer year : years) { %>
			<a href="#<%=year%>" class="list-group-item"
				data-toggle="collapse"> <i class="glyphicon glyphicon-chevron-right"></i>Năm <%=year%>
			</a>
			<div class="list-group collapse" id="<%=year%>">
				<% for (Integer month : minhchung_dao.GetDSThangDangMinhChungTheoHDVaNam(hoatdong.getID(), year)) {	%>
				<a href="result.jsp?findBy=hoatdong&maHD=<%=hoatdong.getID()%>&year=<%=year%>&month=<%=month%>"
					class="list-group-item">Tháng <%=month%></a>
				<% } %>
			</div>
			<% } %>
		</div>
	</div>
</div>

<% } else { %>
<div class="alert alert-info">Hoạt động này chưa có minh chứng nào đi kèm.</div>
<% } }%>

	</div>
</div>

<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>