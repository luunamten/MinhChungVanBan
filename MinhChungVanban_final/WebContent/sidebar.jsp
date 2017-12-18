<%@page import="model.ThongBao"%>
<%@page import="dao.ThongBaoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

</div>
<% ThongBaoDAO thongBaoDAO = new ThongBaoDAO(); %>

<div class="col-md-4">
	<div class="panel panel-primary">

		<div class="panel-heading">
			<h3 class="panel-title">Thông báo</h3>
		</div>

		<div class="panel-body sidebar-list" style="padding-bottom: 0px;">

			<%for (ThongBao tb : thongBaoDAO.GetListThongBao()) {	%>
			<div class="media">
				<div class="media-left">
					<img src="images/icon_notification.png" class="media-object"
						style="width: 60px">
				</div>
				<div class="media-body">
					<p class="media-heading" style="font-size: 15px"><strong><a href="chitietthongbao.jsp?id=<%=tb.getID() %>"><%=tb.getTieuDe() %></a></strong></p>
					<%
						if (tb.getNoiDung().length() > 70) {
					%>
						<p><%=tb.getNoiDung().substring(0, 65) + "..."%></p>
					<%
						} else {
					%>
						<p><%=tb.getNoiDung()%></p>
					<%
						}
					%>
					<small><i>Đăng tải ngày <%=tb.getThoiGianDang() %></i></small>
				</div>
			</div>
			<%}%>
		</div>

	</div>

	<div>
		<a href="http://qao.hcmute.edu.vn/ArticleId/6ae7c9ed-b524-4085-b290-4846be1426e5/sar-construction-engineering-technology"><img class="sidebar-img" src="images/link1.png"></a>
	</div>
	<div>
		<a href="http://qao.hcmute.edu.vn/ArticleId/84d025c2-3ea2-41e9-bb49-47a66373cfe0/aun-ckd"><img class="sidebar-img" src="images/link2.png"></a>
	</div>
	<div>
		<a href="http://qao.hcmute.edu.vn/ArticleId/4c247c61-eb7b-4272-a5ac-ac501f576d44/aun-ckm"><img class="sidebar-img" src="images/link3.png"></a>
	</div>
	<div>
		<a href="http://qao.hcmute.edu.vn/ArticleId/ff0aa370-4d0b-41bb-b3f1-cf87fde726c4/sar-electrical-and-electronics-engineering-technology"><img class="sidebar-img" src="images/link4.png"></a>
	</div>