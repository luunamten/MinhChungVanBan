<%@page import="model.HoatDong"%>
<%@page import="dao.HoatDongDAO"%>
<%@page import="model.TapTin"%>
<%@page import="dao.TapTinDAO"%>
<%@page import="model.TieuChi"%>
<%@page import="dao.MinhChungDAO"%>
<%@page import="model.MinhChung"%>
<%@page import="dao.BoTieuChuanDAO"%>
<%@page import="model.BoTieuChuan"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.NoiBanHanh"%>
<%@page import="dao.NoiBanHanhDAO"%>
<%@page import="model.TieuChuan"%>
<%@page import="dao.TieuChiDAO"%>
<%@page import="dao.TieuChuanDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
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

<title>Sửa minh chứng</title>

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

<style>
#datepicker>span:hover {
	cursor: pointer;
}
</style>

</head>

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
				TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
				TieuChiDAO tieuChiDAO = new TieuChiDAO();
				NoiBanHanhDAO noiBanHanhDAO = new NoiBanHanhDAO();
				BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();
				MinhChungDAO minhChungDAO = new MinhChungDAO();
				HoatDongDAO hoatDongDAO = new HoatDongDAO();
				TapTinDAO tapTinDAO = new TapTinDAO();

				String idMinhChung;
				MinhChung minhChung = null;
				if (request.getParameter("id") != null) {
					idMinhChung = request.getParameter("id");
					minhChung = minhChungDAO.getMinhChungByID(idMinhChung, taiKhoan);
					
				} else if((minhChung = (MinhChung)request.getAttribute("mc")) == null) {
					minhChung = new MinhChung();
				}
				if (minhChung == null) {
					request.getRequestDispatcher("404.jsp").forward(request, response);
				}
			%>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">Sửa minh chứng</div>
						<div class="panel-body">
							<div class="row">
								<form role="form" action="MinhChungServlet" method="post"
									enctype="multipart/form-data">
									<div class="col-lg-6">
										<div class="form-group">
											<label>Mã minh chứng</label> <input type="text"
												class="form-control" name="MaMinhChung"
												value="<%=minhChung.getID()%>" readonly>
										</div>
										<div class="form-group">
											<label>Tên minh chứng</label> <input type="text"
												class="form-control" name="TenMinhChung"
												value="<%=minhChung.getTenMinhChung()%>">
										</div>
										<div class="form-group">
											<label>Mô tả (không bắt buộc)</label>
											<textarea class="form-control" name="MoTa" rows="3"><%=minhChung.getMoTa()%></textarea>
										</div>
										<div class="form-group">
											<label>Số hiệu</label> <input type="text"
												class="form-control" name="SoHieu"
												value="<%=minhChung.getSoHieu()%>">
										</div>
										<div class="form-group">
											<label>Ngày ban hành</label>
											<div id="datepicker" class="input-group date"
												data-date-format="dd-mm-yyyy">
												<input class="form-control" name="NgayBanHanh" type="text"
													value=<%=minhChung.getNgayBanhanh()%>> <span
													class="input-group-addon"><i
													class="glyphicon glyphicon-calendar"></i></span>
											</div>
										</div>
										<div class="form-group">
											<label>Chọn hoạt động</label> <select name="MaHoatDong"
												class="form-control">
												<%
													String selectedHD = minhChung.getMaHoatDong();
													for (HoatDong hoatDong : hoatDongDAO.getCacHoatDong()) {
														String maHD = hoatDong.getID();
														if (maHD.equals(selectedHD)) {
															out.println("<option value='" + maHD + "' selected>" + hoatDong.getTenHoatDong()
																	+ "</option>");
														} else {
															out.println("<option value='" + maHD + "'>" + hoatDong.getTenHoatDong()
															+ "</option>");
														}
													}
												%>
											</select>
										</div>
									</div>
									<!-- /.col-lg-6 (nested) -->
									<%
										TapTin tt = tapTinDAO.GetTapTinByMinhChung(minhChung.getID());
									%>
									<script>
										function XoaTapTin(){
								            if(confirm("Bạn có muốn xóa tệp tin đính kèm của minh chứng?") == true){
								            	$("div.taptin").remove();
								            	$("#attachment").html('<div class="form-group"><input type="file" name="attach" accept=".PDF"></div>');
								            	window.location="TapTinServlet?command=delete&id=<%=minhChung.getID()%>";
											}
										}
									</script>

									<div class="col-lg-6">
										<div class="form-group">
											<label>Chọn bộ tiêu chuẩn</label> <select id="BoTieuChuan"
												name="IDBoTieuChuan" class="form-control">
												<option selected disabled hidden="hidden"
													style="display: none" value=""></option>
												<%
													String selectedBoTieuChuan = tieuChuanDAO
															.GetTieuChuanByID(tieuChiDAO.GetTieuChiByID(minhChung.getMaTieuChi()).getMaTieuChuan())
															.getMaBoTieuChuan();
													for (BoTieuChuan btc : boTieuChuanDAO.getListBoTieuChuan()) {
														String maBTC = btc.getID();
												%>
												<option value="<%=maBTC%>"
													<%=maBTC.equals(selectedBoTieuChuan) ? "selected" : ""%>><%=btc.getTenBoTieuChuan()%>	</option>
												<%
													}
												%>
											</select>
										</div>
										<div class="form-group">
											<label>Chọn tiêu chuẩn</label> <select id="TieuChuan"
												name="IDTieuChuan" class="form-control">
												<%
													String selectedTieuChuan = tieuChiDAO.GetTieuChiByID(minhChung.getMaTieuChi()).getMaTieuChuan();
													for (TieuChuan tc : tieuChuanDAO.getListTieuChuanByBoTieuChuan(selectedBoTieuChuan)) {
														String maTC = tc.getID();
												%>
												<option value="<%=maTC%>"
													<%=maTC.equals(selectedTieuChuan) ? "selected" : ""%>><%=tc.getTenTieuChuan()%>	</option>

												<%
													}
												%>

											</select>
										</div>
										<div class="form-group">
											<label>Chọn tiêu chí</label> <select id="TieuChi"
												name="IDTieuChi" class="form-control">
												<%
													String selectedTieuChi = minhChung.getMaTieuChi();
													for (TieuChi tc : tieuChiDAO.getListTieuChiByTieuChuan(selectedTieuChuan)) {
														String maTieuChi = tc.getID();
												%>
												<option value="<%=maTieuChi%>"
													<%=maTieuChi.equals(selectedTieuChi) ? "selected" : ""%>><%=tc.getTenTieuChi()%>	</option>

												<%
													}
												%>
											</select>

										</div>
										<div class="form-group">
											<label>Chọn nơi ban hành</label> <select name="IDNoiBanHanh"
												class="form-control">
												<%
													String selectedNBH = minhChung.getMaNoiBanHanh();
													for (NoiBanHanh noiBanHanh : noiBanHanhDAO.getListNoiBanHanh()) {
														String maNBH = noiBanHanh.getMaNoiBanHanh();
														if(maNBH.equals(selectedNBH)) {
															out.println("<option value='" + maNBH + "' selected>" + noiBanHanh.getTenNoiBanHanh()
																+ "</option>");
														} else {
															out.println("<option value='" + maNBH + "'>" + noiBanHanh.getTenNoiBanHanh()
															+ "</option>");
														}
													}
												%>
											</select>
										</div>

										<div class="form-group">
											<label>Tập tin đính kèm</label>
											<%
												if (tt.getFilePath() != null) {
											%>
											<div id="attachment">
												<div class="alert alert-info taptin col-md-10">
													<a href="/MinhChungVanban/<%=tt.getFilePath()%>"><strong><%=tt.getFilePath()%></strong></a>
												</div>
												<button type="button"
													class="btn btn-danger glyphicon glyphicon-trash col-md-offset-1 col-md-1"
													style="height: 52px" onclick="XoaTapTin()"></button>
											</div>

											<%
												} else {
											%>
											<div class="form-group">
												<input type="file" class="form-control" name="attach" accept=".PDF">
											</div>
											<%
												}
											%>
										</div>
									</div>
									<!-- /.col-lg-6 (nested) -->
									<div class="clearfix"></div>
									<br> <input type="hidden" name="IDMinhChung"
										value="<%=minhChung.getID()%>" /> <input type="hidden"
										name="Func" value="edit" />
									<div class="col-lg-6">
										<a href="minhchung.jsp" class="btn btn-danger col-lg-12">Hủy</a>
									</div>
									<div class="col-lg-6">
										<button type="submit" class="btn btn-primary col-lg-12">Lưu
											thay đổi</button>
									</div>
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
	<%--<script src="js/selects-edit-criteria.js"></script>--%>
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
