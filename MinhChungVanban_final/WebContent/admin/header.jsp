<%@page import="model.TaiKhoan"%>
<%@page import="dao.TaiKhoanDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();
	TaiKhoan taiKhoan = (TaiKhoan) session.getAttribute("login");
	if ((taiKhoan == null) || !taiKhoanDAO.login(taiKhoan)) 
		request.getRequestDispatcher("403.jsp").forward(request, response);
	else if (taiKhoan.getUserLevel() < 2)
		request.getRequestDispatcher("403.jsp").forward(request, response);
%>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation"
	style="margin-bottom: 0">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="index.jsp">Control Panel</a>
	</div>
	<!-- /.navbar-header -->

	<ul class="nav navbar-top-links navbar-right">

		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
				<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="../profile.jsp"><i class="fa fa-user fa-fw"></i>
						Thông tin tài khoản</a></li>
				<li class="divider"></li>
				<li><a href="../"><i class="fa fa-sign-out fa-fw"></i>
						Trở về trang chính</a></li>
			</ul> <!-- /.dropdown-user --></li>
		<!-- /.dropdown -->
	</ul>
	<!-- /.navbar-top-links -->

	<div class="navbar-default sidebar" role="navigation">
		<div class="sidebar-nav navbar-collapse">
			<ul class="nav" id="side-menu">
				<li><a href="index.jsp"><i class="fa fa-dashboard fa-fw"></i>
						Trang chủ</a></li>
				<%if(taiKhoan.getUserLevel() != 2) {%>
				<li><a href="BoTieuChuan"><i class="fa fa-table fa-fw"></i>
						Quản lý bộ tiêu chuẩn</a></li>

				<li><a href="tieuchuan.jsp"><i class="fa fa-table fa-fw"></i>
						Quản lý tiêu chuẩn</a></li>

				<li><a href="tieuchi.jsp"><i class="fa fa-table fa-fw"></i>
						Quản lý tiêu chí</a></li>
				<%}%>

				<li><a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>
						Quản lý minh chứng<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="minhchung.jsp">Danh sách minh chứng</a></li>
						<li><a href="themminhchung.jsp">Thêm minh chứng</a></li>
						<li><a href="noibanhanh.jsp">Quản lý nơi ban hành</a></li>
					</ul></li>

				<%if(taiKhoan.getUserLevel() != 2) {%>
				<li><a href="#"><i class="fa fa-comments fa-fw"></i> Quản
						lý thông báo<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="thongbao.jsp">Danh sách thông báo</a></li>
						<li><a href="themthongbao.jsp">Thêm thông báo</a></li>
					</ul></li>

				<li><a href="#"><i class="fa fa-user fa-fw"></i> Quản lý
						tài khoản<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="taikhoan.jsp">Danh sách tài khoản</a></li>
						<li><a href="themtaikhoan.jsp">Thêm tài khoản</a></li>
					</ul></li>
				<li><a href="#"><i class="fa fa-cogs fa-fw"></i> Quản lý hoạt động
				<span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="hoatdong.jsp">Danh sách hoạt động</a></li>
						<li><a href="themhoatdong.jsp">Thêm hoạt động</a></li>
					</ul></li>
				<%}%>
			</ul>
		</div>
		<!-- /.sidebar-collapse -->
	</div>
	<!-- /.navbar-static-side -->
</nav>