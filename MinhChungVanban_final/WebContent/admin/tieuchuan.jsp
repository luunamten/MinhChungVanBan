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

<title>Quản lý tiêu chuẩn</title>
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
	TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();
%>
<body>

	<div id="wrapper">

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý tiêu chuẩn</h1>
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
						<div class="panel-heading">Thêm tiêu chuẩn</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<form action="TieuChuanServlet" method="post"
										class="form-horizontal" role="form">
										<div class="form-group">
											<label class="control-label col-sm-2" for="TenTC">Tên
												tiêu chuẩn:</label>
											<div class="col-sm-10">
												<input type="text" name="TenTC" class="form-control"
													placeholder="Tên tiêu chuẩn...">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="IDBoTieuChuan">Chọn
												bộ tiêu chuẩn:</label>
											<div class="col-sm-10">
												<select class="form-control" name="IDBoTieuChuan">
													<%
														for (BoTieuChuan btc : boTieuChuanDAO.getListBoTieuChuan()) {
													%>
													<option value="<%=btc.getID()%>"><%=btc.getTenBoTieuChuan()%></option>
													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<input type="hidden" name="Func" value="add">
												<button type="submit" class="btn btn-primary">Thêm
													tiêu chuẩn</button>
											</div>
										</div>

									</form>
								</div>

							</div>
							<!-- /.row (nested) -->
						</div>
						<!-- /.panel-body -->
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">Danh sách tiêu chuẩn</div>
						<!-- /.panel-heading -->
						<%
							ArrayList<TieuChuan> listTC = tieuChuanDAO.getListTieuChuan();
						%>

						<div class="panel-body">
							<table width="100%"
								class="table table-striped table-bordered table-hover"
								id="dataTables-example">
								<thead>
									<tr>
										<th>Bộ tiêu chuẩn</th>
										<th>Mã tiêu chuẩn</th>
										<th>Tên tiêu chuẩn</th>
										<th></th>
										<th></th>

									</tr>
								</thead>
								<tbody>
									<%
										for (TieuChuan tc : listTC) {
									%>
									<tr class="odd gradeX">
										<td><%=boTieuChuanDAO.GetBoTieuChuanByID(tc.getMaBoTieuChuan()).getTenBoTieuChuan()%></td>
										<td><%=tc.getID()%></td>
										<td><%=tc.getTenTieuChuan()%></td>
										<td class="text-center"><a
											href="TieuChuanServlet?command=edit&id=<%=tc.getID()%>">Sửa</a></td>
										<td class="text-center"><a
											href="TieuChuanServlet?command=delete&id=<%=tc.getID()%>"
											onclick="return confirm('Bạn có chắc chắn xóa tiêu chuẩn này không?')">Xóa</a></td>
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
