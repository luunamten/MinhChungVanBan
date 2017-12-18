<%@page import="model.TaiKhoan"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>



<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title">Quên mật khẩu</h3>
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

		<form action="QuenMatKhau" method="post" class="form-horizontal">
			<div class="form-group">
				<label class="control-label  col-md-3">Email: </label>
				<div class="col-md-7">
					<input type="email" name="email" placeholder="Email"
						class="form-control">
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-offset-3 col-md-3">
				</div>

				<div class="col-md-4">
					<button type="submit" class="btn btn-primary pull-right">Gửi</button>
				</div>
			</div>

		</form>
	</div>
</div>
<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>

