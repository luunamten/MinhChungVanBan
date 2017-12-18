<%@page import="model.TieuChi"%>
<%@page import="model.TieuChuan"%>
<%@page import="model.BoTieuChuan"%>
<%@page import="dao.TieuChiDAO"%>
<%@page import="dao.TieuChuanDAO"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<%
	if ((taiKhoan == null) || !taiKhoanDAO.login(taiKhoan)) {
		ArrayList<String> errors = new ArrayList<String>();
		errors.add("Vui lòng đăng nhập để truy cập vào trang này!");
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("403.jsp").forward(request, response);
	}
%>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Tra cứu minh chứng</h3>
	</div>
	<div class="panel-body">
		<form action="result.jsp" method="get" class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-md-2">Từ khóa: </label>
				<div class="col-md-8">
					<input type="text" name="keyword" placeholder="Tên minh chứng"
						class="form-control">
				</div>
				<button type="submit" class="btn btn-primary"
					class="col-md-offset-2 col-md-2">Tìm kiếm</button>
				<input type="hidden" name="findBy" value="name" />
			</div>
		</form>
	</div>
</div>
<%
	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();
	TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
	TieuChiDAO tieuChiDAO = new TieuChiDAO();
%>


<%
	for (BoTieuChuan boTieuChuan : boTieuChuanDAO.getListBoTieuChuan()) {
		List<TieuChuan> listTieuChuan = tieuChuanDAO.getListTieuChuanByBoTieuChuan(boTieuChuan.getID() );
		if (listTieuChuan.size() > 0) {
%>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title"><%=boTieuChuan.getTenBoTieuChuan()%></h3>
	</div>
	<div class="panel-body">
		<div class="list-group list-group-root well">
			<%
				for (TieuChuan tieuChuan : tieuChuanDAO.getListTieuChuanByBoTieuChuan(boTieuChuan.getID())) {
			%>

			<a href="#<%=tieuChuan.getID()%>" class="list-group-item"
				data-toggle="collapse"> <i
				class="glyphicon glyphicon-chevron-right"></i><%=tieuChuan.getTenTieuChuan()%>
			</a>
			<div class="list-group collapse" id="<%=tieuChuan.getID()%>">
				<%
					for (TieuChi tieuChi : tieuChiDAO.getListTieuChiByTieuChuan(tieuChuan.getID())) {
				%>
				<a href="result.jsp?findBy=tieuchi&maTieuChi=<%=tieuChi.getID()%>"
					class="list-group-item"><%=tieuChi.getTenTieuChi()%></a>
				<%
					}
				%>
			</div>
			<%
				}
			%>
		</div>
	</div>
</div>
<%
	}
}
%>


<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

