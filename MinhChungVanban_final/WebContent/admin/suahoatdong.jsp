<%@page import="java.util.ArrayList"%>
<%@page import="model.LoaiTaiKhoan"%>
<%@page import="dao.LoaiTaiKhoanDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script src="js/jquery.min.js"></script>
<link rel="stylesheet prefetch" href="css/datepicker.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<style>
#datepicker>span:hover {
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#datepicker").datepicker({
			autoclose : true,
			todayHighlight : true
		}).datepicker('update', new Date());
	});
</script>

<body>
	<c:set var="hd" value="${requestScope.hoatDong }" />
	<div id="wrapper">

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý hoạt động</h1>
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
						<div class="panel-heading">Sửa hoạt động</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<form action="HoatDong" method="post"
										enctype="multipart/form-data" class="form-horizontal"
										role="form">
										<div class="form-group">
											<label class="control-label col-sm-2" for="MaHD">Mã
												hoạt động:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" value="${hd.ID }"
													name="MaHD" readonly />
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="TenHD">Tên
												hoạt động:</label>
											<div class="col-sm-10">
												<input type="text" value="${hd.tenHoatDong }"
													class="form-control" name="TenHD"
													placeholder="Tên hoạt động...">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="MoTa">Mô
												tả:</label>
											<div class="col-sm-10">
												<textarea class="form-control" name="MoTa"
													placeholder="Mô tả..." rows="10">${hd.moTa }</textarea>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="Avatar">Ảnh
												minh họa:</label>
											<c:choose>
												<c:when
													test="${not empty hd.anh && !hd.anh.trim().isEmpty() }">
													<div id="attachment" class="col-sm-6">
														<div class="alert alert-info taptin">
															<a href="/MinhChungVanban/${hd.anh}"><strong>${hd.anh}</strong></a>
														</div>
													</div>
													<input type="hidden" value="${hd.anh }" name="AnhMH" />
													<div class="col-sm-1">
														<button type="submit"
															class="btn btn-danger glyphicon glyphicon-trash"
															style="height: 52px" name="deleteBut"></button>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-sm-10">
														<input type="file" class="form-control" name="img"
															accept="image/*">
													</div>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<input type="hidden" name="Func" value="edit" /> <input
													type="submit" class="btn btn-primary" name="changeBut"
													value="Lưu thay đổi" />
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
	<script src="js/bootstrap-datepicker.js"></script>
</body>
</html>
