<%@page import="model.TaiKhoan"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>



<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Đăng nhập</h3>
	</div>
	<div class="panel-body">
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

		<form action="LoginServlet" method="post" class="form-horizontal">
			<div class="form-group">
				<label class="control-label  col-md-3">Tài khoản: </label>
				<div class="col-md-7">
					<input type="email" name="email" placeholder="Email"
						class="form-control">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label  col-md-3">Mật khẩu: </label>
				<div class="col-md-7">
					<input type="password" name="password" placeholder="Mật khẩu"
						class="form-control">
				</div>
			</div>

			<div class="form-group">
			<div class="col-md-offset-3 col-md-3">
				<a href="caplaimatkhau.jsp" style="text-decoration: none;">Quên mật khẩu</a>
				</div> 

				<div class="col-md-4">
					<button type="submit" class="btn btn-primary pull-right">Đăng
						Nhập</button>
				</div>
			</div>

		</form>
	</div>
</div>
<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

