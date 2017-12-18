<%@page import="model.MinhChung"%>
<%@page import="dao.HoatDongDAO"%>
<%@page import="model.HoatDong"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="model.BoTieuChuan"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.NoiBanHanh"%>
<%@page import="dao.NoiBanHanhDAO"%>
<%@page import="model.TieuChuan"%>
<%@page import="dao.TieuChiDAO"%>
<%@page import="dao.TieuChuanDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Thêm minh chứng</title>

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
<%
	TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
	TieuChiDAO tieuChiDAO = new TieuChiDAO();
	HoatDongDAO hoatDongDAO = new HoatDongDAO();
	NoiBanHanhDAO noiBanHanhDAO = new NoiBanHanhDAO();
	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();
	MinhChung mc = (MinhChung)request.getAttribute("mc");
	if(mc == null) {
		mc = new MinhChung();
	}
%>
<body>

	<div id="wrapper">

		<%@include file="header.jsp"%>

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý minh chứng</h1>
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
						<div class="panel-heading">Thêm minh chứng</div>
						<div class="panel-body">
							<div class="row">
								<form role="form" action="MinhChungServlet" method="post"
									enctype="multipart/form-data">
									<div class="col-lg-6">
										<div class="form-group">
											<label>Tên minh chứng</label> <input type="text"
												class="form-control" name="TenMinhChung" value="<%=mc.getTenMinhChung() %>">
										</div>
										<div class="form-group">
											<label>Mô tả (không bắt buộc)</label>
											<textarea class="form-control" name="MoTa" rows="3"><%=mc.getMoTa() %></textarea>
										</div>
										<div class="form-group">
											<label>Số hiệu</label> <input type="text"
												class="form-control" name="SoHieu" value="<%=mc.getSoHieu() %>">
										</div>
										<div class="form-group">
											<label>Ngày ban hành</label>
											<div id="datepicker" class="input-group date"
												data-date-format="dd-mm-yyyy">
												<input class="form-control" name="NgayBanHanh" type="text" value="<%=mc.getNgayBanhanh() %>">
												<span class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span>
											</div>
										</div>
										<div class="form-group">
											<label>Chọn hoạt động</label> <select name="MaHoatDong"
												class="form-control">
												<%
													String selectedHD = mc.getMaHoatDong();
													for (HoatDong hoatDong : hoatDongDAO.getCacHoatDong()) {%>
													<option value="<%=hoatDong.getID()%>" <%if(hoatDong.getID().equals(selectedHD)){%>selected<%}%>>
													<%=hoatDong.getTenHoatDong()%></option>
												<%	}
												%>
											</select>
										</div>
									</div>
									<!-- /.col-lg-6 (nested) -->
									
									<div class="col-lg-6">
																				
										<div class="form-group">
											<label>Chọn bộ tiêu chuẩn</label> <select id="BoTieuChuan"
												name="IDBoTieuChuan" class="form-control">
												<option selected disabled hidden="hidden"
													style="display: none" value=""></option>
												<%
													for (BoTieuChuan boTieuChuan : boTieuChuanDAO.getListBoTieuChuan()) {
														out.println("<option value=\"" + boTieuChuan.getID() + "\">" + boTieuChuan.getTenBoTieuChuan()
																+ "</option>");
													}
												%>
												<option value="null" id="optBTC" selected>Vui lòng chọn bộ tiêu chuẩn</option>
											</select>
										</div>
										<div class="form-group">
											<label>Chọn tiêu chuẩn</label> <select id="TieuChuan"
												name="IDTieuChuan" class="form-control">
											</select>
										</div>
										
										<div class="form-group">
											<label>Chọn tiêu chí</label> <select id="TieuChi"
												name="IDTieuChi" class="form-control">
											</select>

										</div>
										<div class="form-group">
											<label>Chọn nơi ban hành</label> <select name="IDNoiBanHanh"
												class="form-control">
												<%
													String selectedNBH = mc.getMaNoiBanHanh();
													for (NoiBanHanh noiBanHanh : noiBanHanhDAO.getListNoiBanHanh()) {%>
														<option value="<%=noiBanHanh.getMaNoiBanHanh()%>" 
														<%if(noiBanHanh.getMaNoiBanHanh().equals(selectedNBH)){%>selected<%}%>>
														<%=noiBanHanh.getTenNoiBanHanh()%></option>
													<%	}
													%>
											</select>
										</div>
										<div class="form-group">
										<label>Thêm tập đính kèm</label>
											<input type="file" class="form-control" name="attach" accept=".PDF">
										</div>
									</div>
									<!-- /.col-lg-6 (nested) -->
									<div class="clearfix"></div>
									<br>
										<input type="hidden" name="Func" value="add"/>
										<div class="col-lg-6"><button type="reset" class="btn btn-danger col-lg-12">Nhập lại</button></div>
										<div class="col-lg-6"><button type="submit" class="btn btn-primary col-lg-12">Đăng tải</button></div>	
								</form>
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
	
	<!-- JavaScript -->
	<script src="js/selects-add-proof.js"></script>
	<script src="js/datepicker.js"></script>

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