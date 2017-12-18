<%@page import="dao.Util"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.TaiKhoanDAO"%>
<%@page import="model.TaiKhoan"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<script src="admin/js/jquery.min.js"></script>
<link rel="stylesheet prefetch" href="admin/css/datepicker.css">

<style>
#datepicker>span:hover {
	cursor: pointer;
}
</style>

<%
	
	if (taiKhoan == null) {
		ArrayList<String> errors = new ArrayList<String>();
		errors.add("Vui lòng đăng nhập để truy cập vào trang này!");
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("403.jsp").forward(request, response);
	}
	TaiKhoan _taiKhoan = (TaiKhoan)request.getAttribute("account"); 
	if(_taiKhoan == null) {
		_taiKhoan = taiKhoan;
	}
%>
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
<div class="panel panel-primary">

	<div class="panel-heading">
		<h3 class="panel-title">Thông tin tài khoản</h3>
	</div>
	<div class="panel-body">

		<div class="col-md-4">
			<img
				src="<%=(_taiKhoan.getAnhDaiDien() == null || _taiKhoan.getAnhDaiDien().isEmpty())?"images/default-avatar.png" : _taiKhoan.getAnhDaiDien()%>"
				class="img-thumbnail">
		</div>


		<form role="form" action="TaiKhoan" method="post" enctype="multipart/form-data">
			<div class="col-md-8">
				<div class="form-group">

					<label>Tên tài khoản</label>
					<input type="text" class="form-control" name="HoTen" value="<%=_taiKhoan.getHoTen()%>"></input>

				</div>

				<div class="form-group">
					<label class="control-label" for="GioiTinh">Giới tính:</label>
					<label class="radio-inline"> <input name="GioiTinh"
						id="optionsRadiosInline1" value="Nam"
						<%=_taiKhoan.isNu() ? "" : "checked"%> type="radio">Nam
					</label> <label class="radio-inline"> <input name="GioiTinh"
						id="optionsRadiosInline2" value="Nu"
						<%=_taiKhoan.isNu() ? "checked" : ""%> type="radio">Nữ
					</label>
				</div>

				<div class="form-group">
					<label>Ngày sinh</label>
					<div id="datepicker" class="input-group date"
						data-date-format="dd-mm-yyyy">
						<input class="form-control" name="NgaySinh" type="text" value=<%=_taiKhoan.getNgaySinh() %>>
						<span class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</div>
				<div class="form-group">
					<label>Nơi công tác</label> <input type="text" class="form-control"
						name="NoiCongTac" value="<%=_taiKhoan.getNoiCongTac()%>">
				</div>

				<div class="form-group">
					<label>Chức vụ</label> <input type="text" class="form-control"
						name="ChucVu" value="<%=_taiKhoan.getChucVu()%>">
				</div>
				
				<div class="form-group">
					<label>Địa chỉ</label> <input type="text"
						class="form-control" name="DiaChi"
						value="<%=_taiKhoan.getDiaChi()%>">
				</div>

				<div class="form-group">
					<label>Số điện thoại</label> <input type="text"
						class="form-control" name="SoDienThoai"
						value="<%=_taiKhoan.getSoDienThoai()%>">
				</div>
				
				<div class="form-group">
					<label class="control-label" for="Avatar">Ảnh đại diện:</label>
					<input type="file" name="Avatar" accept="image/*">
				</div>
				<input type="hidden" name="Func" value="uedit" /> <input
					type="hidden" name="Email" value="<%=_taiKhoan.getEmail()%>" />
					<input type="hidden" name="oldimg" value="<%=_taiKhoan.getAnhDaiDien()%>" />
				<button type="submit" class="btn btn-primary col-md-12">Lưu thay đổi</button>
			</div>
		</form>
	</div>
</div>


<script type="text/javascript">
		$(document).ready(function() {
			$("#datepicker").datepicker({
				autoclose : true,
				todayHighlight : true
			});
		});
</script>

<!-- Custom Theme JavaScript -->
<script src="admin/js/bootstrap-datepicker.js"></script>



<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

