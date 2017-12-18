<%@page import="dao.ChangePass"%>
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
	ChangePass _cpass = (ChangePass) request.getAttribute("cpass");
	if (_cpass == null) {
		_cpass = new ChangePass();
		_cpass.setNewPass("");
		_cpass.setReNewPass("");
		_cpass.setOldPass("");
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
		<h3 class="panel-title">Đổi mật khẩu</h3>
	</div>
	<div class="panel-body">

		<div class="col-md-8 col-md-offset-2">
			<form role="form" action="TaiKhoan" method="post"
				enctype="multipart/form-data">

					<div class="form-group">
						<label>Nhập mật khẩu cũ</label> <input type="password"
							class="form-control" name="oldPass" value="<%=_cpass.getOldPass() %>" />
					</div>
					<div class="form-group">
						<label>Nhập mật khẩu mới</label> <input type="password"
							class="form-control" name="newPass" value="<%=_cpass.getNewPass() %>" />
					</div>
					<div class="form-group">
						<label>Nhập lại mật khẩu mới</label> <input type="password"
							class="form-control" name="reNewPass" value="<%=_cpass.getReNewPass() %>" />
					</div>
					<input type="hidden" name="Func" value="pedit" /> 
					<button type="submit" class="btn btn-primary col-md-12">Lưu
						thay đổi</button>
			</form>
		</div>
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

