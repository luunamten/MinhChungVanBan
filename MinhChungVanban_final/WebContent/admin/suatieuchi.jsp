<%@page import="model.BoTieuChuan"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="model.TieuChuan"%>
<%@page import="dao.TieuChuanDAO"%>
<%@page import="model.TieuChi"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TieuChiDAO"%>
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

<title>Quản lý tiêu chí</title>

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
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">
	$(document).ready(function() {
		var x_timer;
		$("#BoTieuChuan").change(function(e) {
			clearTimeout(x_timer);
			var idBoTieuChuan = $("option:selected", this).val();
			x_timer = setTimeout(function() {
				update_data(idBoTieuChuan);
			}, 100);
		});

		function update_data(idBoTieuChuan) {
			$.post('GetOptionHTMLServlet', {
				'Type' : "TieuChuan",
				'ID' : idBoTieuChuan
			}, function(data) {
				$("#TieuChuan").html(data);
			});
		}
	});
</script>
</head>

<%
	TieuChiDAO tieuChiDAO = new TieuChiDAO();
	TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();

	String idTieuChi;

	TieuChi tieuChi = new TieuChi();
	if (request.getParameter("id") != null) {
		idTieuChi = request.getParameter("id");
		tieuChi = tieuChiDAO.GetTieuChiByID(idTieuChi);
	} else if((tieuChi = (TieuChi)request.getAttribute("tch")) == null) {
		tieuChi = new TieuChi();
	}
	if (tieuChi == null) {
		request.getRequestDispatcher("404.jsp").forward(request, response);
	}
%>
<body>

	<div id="wrapper">

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý tiêu chí</h1>
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
						<div class="panel-heading">Sửa tiêu chí</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<form action="TieuChiServlet" method="post"
										class="form-horizontal" role="form">
										<div class="form-group">
											<label class="control-label col-sm-3" for="maTC">Mã
												tiêu chí:</label>
											<div class="col-sm-9">
												<input type="text" name="MaTieuChi" class="form-control"
													placeholder="Mã tiêu chuẩn..."
													value="<%=tieuChi.getID()%>" readonly>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-3" for="tenTC">Tên
												tiêu chí:</label>
											<div class="col-sm-9">
												<input type="text" name="TenTieuChi" class="form-control"
													placeholder="Tên tiêu chuẩn..."
													value="<%=tieuChi.getTenTieuChi()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-3" for="IDBoTieuChuan">Chọn
												bộ tiêu chuẩn:</label>
											<div class="col-sm-9">
												<select class="form-control" id="BoTieuChuan"
													name="IDBoTieuChuan">
													<%
														String idBoTieuChuan = tieuChuanDAO.GetTieuChuanByID(tieuChi.getMaTieuChuan()).getMaBoTieuChuan();
														for (BoTieuChuan btc : boTieuChuanDAO.getListBoTieuChuan()) {
															String maBTC = btc.getID();
													%>
													<option
														<%if (maBTC.equals(idBoTieuChuan)) {%>
													selected<%}%>
														value="<%=maBTC%>"><%=btc.getTenBoTieuChuan()%></option>
													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-3" for="maTieuChuan">Chọn
												tiêu chuẩn:</label>
											<div class="col-sm-9">
												<select class="form-control" id="TieuChuan"
													name="MaTieuChuan">
													<%
														for (TieuChuan tieuChuan : tieuChuanDAO.getListTieuChuanByBoTieuChuan(idBoTieuChuan)) {
															String maTieuChuan = tieuChuan.getID();
													%>
													<option
														<%if (maTieuChuan.equals(tieuChi.getMaTieuChuan())) {%>
														selected<%}%>
														value="<%=maTieuChuan%>"><%=tieuChuan.getTenTieuChuan()%></option>

													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-3 col-sm-9">
												<input type="hidden" name="IDTieuChi"
													value="<%=tieuChi.getID()%>"> <input type="hidden"
													name="Func" value="edit">
												<button type="submit" class="btn btn-primary">Sửa
													tiêu chí</button>
												<a href="tieuchi.jsp" class="btn btn-default">Hủy</a>
											</div>
										</div>

									</form>
								</div>

							</div>
							<!-- /.row (nested) -->
						</div>
						<!-- /.panel-body -->
					</div>
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
