<%@page import="java.util.ArrayList"%>
<%@page import="dao.LoaiTaiKhoanDAO"%>
<%@page import="dao.TaiKhoanDAO"%>
<%@page import="model.TaiKhoan"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="header.jsp"%>
<%
	if (taiKhoan.getUserLevel() < 3)
		request.getRequestDispatcher("403.jsp").forward(request, response);
%>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Quản lý tài khoản</title>

<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<%
	LoaiTaiKhoanDAO loaiTaiKhoanDAO = new LoaiTaiKhoanDAO();
%>
<body>

	<div id="wrapper">

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý tài khoản</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<%
						ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
						if (errors != null) {
					%>
					<div class="alert alert-danger">
						<%
							for (String error : errors) {
									out.println(error);
									out.println("<div class=\"clearfix\"></div>");
								}
						%>

					</div>
					<%
						}
					%>
					<div class="panel panel-default">
						<div class="panel-heading">Danh sách tài khoản</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<table width="100%"
								class="table table-striped table-bordered table-hover"
								id="dataTables-example">
								<thead>
									<tr>
										<th>Họ và tên</th>
										<th>Email</th>
										<th>Phân quyền</th>
										<th></th>
										<th></th>

									</tr>
								</thead>
								<tbody>
									<%
										for (TaiKhoan tk : taiKhoanDAO.getListTaiKhoan()) {
									%>
									<tr class="odd gradeX">
										<td><%=tk.getHoTen()%></td>
										<td><%=tk.getEmail()%></td>
										<td><%=loaiTaiKhoanDAO.GetLoaiTaiKhoanByID(tk.getUserLevel()).getTenLoaiTaiKhoan()%></td>
										<td class="text-center"><a
											href="TaiKhoan?command=edit&email=<%=tk.getEmail()%>">Sửa</a></td>
										<td class="text-center"><a
											href="TaiKhoan?command=delete&email=<%=tk.getEmail()%>"
											onclick="return confirm('Bạn có chắc chắn xóa tài khoản này không?')">Xóa</a></td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
							<!-- /.table-responsive -->

						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script src="vendor/raphael/raphael.min.js"></script>
	<script src="vendor/morrisjs/morris.min.js"></script>
	<script src="data/morris-data.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="dist/js/sb-admin-2.js"></script>

</body>

</html>
