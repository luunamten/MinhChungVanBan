<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.TaiKhoan"%>
<%@page import="dao.TaiKhoanDAO"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.LoaiTaiKhoan"%>
<%@page import="dao.LoaiTaiKhoanDAO"%>
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
		});
	});
</script>


<body>

	<div id="wrapper">

		<%
			String idTaiKhoan;
			TaiKhoan _taiKhoan = new TaiKhoan();
			if (request.getParameter("email") != null) {
				idTaiKhoan = request.getParameter("email");
				_taiKhoan = taiKhoanDAO.GetTaiKhoanByID(idTaiKhoan);
			} else {
				_taiKhoan = (TaiKhoan) request.getAttribute("account");
			}
			if (_taiKhoan == null) {
				request.getRequestDispatcher("404.jsp").forward(request, response);
			}
		%>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Quản lý tài khoản</h1>
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
						<div class="panel-heading">Cập nhật thông tin tài khoản</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-12">
									<form action="TaiKhoan" method="post"
										enctype="multipart/form-data" class="form-horizontal"
										role="form">
										<div class="form-group">
											<label class="control-label col-sm-2" for="HoTen">Họ
												tên:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="HoTen"
													placeholder="Họ và tên..."
													value="<%=_taiKhoan.getHoTen()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="NgaySinh">Ngày
												Sinh:</label>
											<div class="col-sm-10">
												<div id="datepicker" class="input-group date"
													data-date-format="dd-mm-yyyy">
													<input class="form-control" name="NgaySinh" type="text"
														placeholder="DD-MM-YYYY"
														value="<%=_taiKhoan.getNgaySinh()%>"> <span
														class="input-group-addon"><i
														class="glyphicon glyphicon-calendar"></i></span>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="GioiTinh">Giới
												tính:</label>
											<div class="col-sm-10">
												<label class="radio-inline"> <input name="GioiTinh"
													id="optionsRadiosInline1" value="Nam"
													<%=_taiKhoan.isNu() ? "" : "checked"%> type="radio">Nam
												</label> <label class="radio-inline"> <input name="GioiTinh"
													id="optionsRadiosInline2" value="Nu"
													<%=_taiKhoan.isNu() ? "checked" : ""%> type="radio">Nữ
												</label>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="DiaChi">Địa
												chỉ:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="DiaChi"
													placeholder="Địa chỉ..." value="<%=_taiKhoan.getDiaChi()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="NoiCongTac">Nơi
												công tác:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="NoiCongTac"
													placeholder="Nơi công tác..."
													value="<%=_taiKhoan.getNoiCongTac()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="ChucVu">Chức
												vụ:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="ChucVu"
													placeholder="Chức vụ..." value="<%=_taiKhoan.getChucVu()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="SoDienThoai">Số
												điện thoại:</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="SoDienThoai"
													placeholder="Số điện thoại..."
													value="<%=_taiKhoan.getSoDienThoai()%>">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="LoaiTaiKhoan">Loại
												tài khoản:</label>
											<div class="col-sm-10">
												<select class="form-control" name="IDLoaiTaiKhoan">
													<%
														LoaiTaiKhoanDAO loaiTaiKhoanDAO = new LoaiTaiKhoanDAO();
														for (LoaiTaiKhoan ltk : loaiTaiKhoanDAO.GetListLoaiTaiKhoan()) {
													%>
													<option value="<%=ltk.getID()%>"
														<%if (_taiKhoan.getUserLevel() == ltk.getID()) {%> selected
														<%}%>><%=ltk.getTenLoaiTaiKhoan()%></option>
													<%
														}
													%>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-sm-2" for="Avatar">Ảnh
												đại diện:</label>
											<div class="col-sm-10">
												<input type="file" name="Avatar" accept="image/*">
											</div>
										</div>
										<%
											String anh = _taiKhoan.getAnhDaiDien();
											if (anh != null && !anh.trim().isEmpty()) {
												String dirUrl = request.getServletContext().getRealPath("") + File.separator + "uploads";
												String fileImg = dirUrl + File.separator + _taiKhoan.getAnhDaiDien();
										%>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<img src="/MinhChungVanban/<%=_taiKhoan.getAnhDaiDien()%>"
													height="100" width="100" />
											</div>
											<input type="hidden" name="oldimg"
												value="<%=_taiKhoan.getAnhDaiDien()%>" />
										</div>
										<%
											}
										%>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<input type="hidden" name="Func" value="edit" /> <input
													type="hidden" name="oldEmail"
													value="<%=_taiKhoan.getEmail()%>" />
												<button type="submit" class="btn btn-primary">Lưu
													thay đổi</button>
												<a href="taikhoan.jsp" class="btn btn-default">Hủy</a>
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
