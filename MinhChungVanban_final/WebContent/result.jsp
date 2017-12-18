<%@page import="model.TieuChi"%>
<%@page import="model.TieuChuan"%>
<%@page import="dao.TieuChiDAO"%>
<%@page import="dao.TieuChuanDAO"%>
<%@page import="model.MinhChung"%>
<%@page import="dao.MinhChungDAO"%>
<%@page import="model.TapTin"%>
<%@page import="dao.TapTinDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

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
		<h3 class="panel-title">Danh sách minh chứng</h3>
	</div>
	<div class="panel-body">
		<%
					MinhChungDAO minhChungDAO = new MinhChungDAO();
					List<MinhChung> listminhchung = null;
					switch (request.getParameter("findBy")) {
						case "name":
							listminhchung = minhChungDAO.getListMinhChungByName(request.getParameter("keyword"));
							break;
						case "tieuchi":
							listminhchung = minhChungDAO.getListMinhChungByMaTieuChi(request.getParameter("maTieuChi"));
							break;
						case "hoatdong":
							listminhchung = minhChungDAO.getListMinhChungByHDVaNgayDT(request.getParameter("maHD"),
																					Integer.valueOf(request.getParameter("year")),
																					Integer.valueOf(request.getParameter("month")));
							break;
					}
					if(listminhchung.size() > 0) {
	%>
		<table width="100%"
			class="table table-striped table-bordered table-hover"
			id="dataTables-example">
			<thead>
				<tr>
					<th class="col-md-1">Mã MC</th>
					<th class="col-md-10">Tên minh chứng</th>
					<th class="col-md-1">Tệp</th>

				</tr>
			</thead>
			<tbody>
				<%for (MinhChung minhChung : listminhchung) {%>
				<tr class="odd gradeX">
					<td><%=minhChung.getID()%></td>
					<td>
					<%
						if (minhChung.getTenMinhChung().length() > 70) {
					%>
						<p><%=minhChung.getTenMinhChung().substring(0, 65) + "..."%></p>
					<%
						} else {
					%>
						<p><%=minhChung.getTenMinhChung()%></p>
					<%
						}
					%>
					</td>
					<td>
						<%
							TapTinDAO tapTinDAO = new TapTinDAO();
							for (TapTin tt : tapTinDAO.GetListTapTinByMinhChung(minhChung.getID())) {
						%> <a href="/MinhChungVanban/<%=tt.getFilePath()%>"><i>Xem</i></a>
						<%
					}
				}%>
					</td>
				</tr>
			</tbody>
		</table>
		<%} else {%>
		<div class="alert alert-info">Không có minh chứng nào.</div>
		<%}%>
	</div>
</div>


<%@ include file="sidebar.jsp"%>
<%@ include file="footer.jsp"%>