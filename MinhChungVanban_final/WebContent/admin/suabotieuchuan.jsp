<%@page import="model.BoTieuChuan"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="model.TieuChuan"%>
<%@page import="dao.TieuChuanDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@include file="header.jsp"%>
<%if (taiKhoan.getUserLevel() < 3) request.getRequestDispatcher("403.jsp").forward(request, response);%>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Quản lý bộ tiêu chuẩn</title>



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
	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();
	String idBoTieuChuan;
	BoTieuChuan boTieuChuan = null;
	if (request.getParameter("id") != null) {
		idBoTieuChuan = request.getParameter("id");
		boTieuChuan = boTieuChuanDAO.GetBoTieuChuanByID(idBoTieuChuan);
	}
	if (boTieuChuan == null) {
		request.getRequestDispatcher("404.jsp").forward(request, response);
	}
%>
<body>

	<div id="wrapper">

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý bộ tiêu chuẩn</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
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
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">Thêm bộ tiêu chuẩn</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<form action="BoTieuChuan" method="post"
										class="form-horizontal" role="form">
										<div class="form-group">
											<label class="control-label col-sm-2" for="MaBTC">Mã
												bộ tiêu chuẩn:</label>
											<div class="col-sm-10">
												<input type="text" name="MaBTC" class="form-control"
													placeholder="Mã bộ tiêu chuẩn..."
													value="<%=boTieuChuan.getID()%>" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="TenBTC">Tên
												bộ tiêu chuẩn:</label>
											<div class="col-sm-10">
												<input type="text" name="TenBTC" class="form-control"
													placeholder="Tên bộ tiêu chuẩn..."
													value="<%=boTieuChuan.getTenBoTieuChuan()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="MoTa">Mô
												tả:</label>
											<div class="col-sm-10">
												<input type="text" name="MoTa" class="form-control"
													placeholder="Mô tả..." value="<%=boTieuChuan.getMoTa()%>">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<input
													type="hidden" name="Func" value="edit">
												<button type="submit" class="btn btn-primary">Sửa
													bộ tiêu chuẩn</button>
												<a href="BoTieuChuan" class="btn btn-default">Hủy</a>
											</div>
										</div>

									</form>
								</div>

							</div>
							<!-- /.row (nested) -->
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
