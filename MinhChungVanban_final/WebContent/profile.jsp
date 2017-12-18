<%@page import="dao.Util"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.TaiKhoanDAO"%>
<%@page import="model.TaiKhoan"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>

<%
	if ((taiKhoan == null) || !taiKhoanDAO.login(taiKhoan)) {
		ArrayList<String> errors = new ArrayList<String>();
		errors.add("Vui lòng đăng nhập để truy cập vào trang này!");
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("403.jsp").forward(request, response);
	}
%>

<div class="panel panel-primary">

	<div class="panel-heading">
		<h3 class="panel-title">Thông tin Tài khoản</h3>
	</div>
	<div class="panel-body">

		<div class="col-md-4">

			<img
				src="<%=(taiKhoan.getAnhDaiDien() == null || taiKhoan.getAnhDaiDien().isEmpty())? "images/default-avatar.png" : taiKhoan.getAnhDaiDien()%>"
				class="img-thumbnail">

		</div>
		<div class="col-md-8">
			<table class="table table-striped">

				<tbody>
					<%
						if (taiKhoan != null) {
					%>
					<tr>

						<td>Họ và tên:</td>
						<td><%=taiKhoan.getHoTen()%></td>
					</tr>
					<tr>

						<td>Giới tính:</td>
						<td><%=taiKhoan.isNu() ? "Nữ" : "Nam"%></td>
					</tr>
					<tr>
						<td>Ngày sinh:</td>
						<td><%=taiKhoan.getNgaySinh()%></td>
					</tr>
					<tr>
						<td>Nơi công tác:</td>
						<td><%=taiKhoan.getNoiCongTac()%></td>
					</tr>
					<tr>
						<td>Chức vụ:</td>
						<td><%=taiKhoan.getChucVu()%></td>
					</tr>
					<tr>
						<td>Số điện thoại:</td>
						<td><%=taiKhoan.getSoDienThoai()%></td>
					</tr>
					<tr>
						<td>E-mail:</td>
						<td><%=taiKhoan.getEmail()%></td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>
			<a href="capnhattaikhoan.jsp" class="btn btn-primary center-block">Cập nhật</a>
			<br />
			<a href="doimatkhau.jsp" class="btn btn-danger center-block">Đổi mật khẩu</a>
		</div>
	</div>
</div>



<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

