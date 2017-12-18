<%@page import="model.SoMinhChung"%>
<%@page import="model.BoTieuChuan"%>
<%@page import="dao.ThongKeDAO"%>
<%@page import="dao.ThongBaoDAO"%>
<%@page import="java.util.ArrayList"%>
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

<title>Admin control panel</title>


<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!-- Custom CSS -->
<link href="css/pnam.css" rel="stylesheet">
<!-- Bootstrap core JavaScript -->
<!-- Chart -->
<!-- Bootstrap core CSS -->
<!-- Material Design Bootstrap -->
<!-- Your custom styles (optional) -->
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
	<%
		ThongKeDAO thongKeDAO = new ThongKeDAO();
		ArrayList<String> years = thongKeDAO.getYears();
		ArrayList<BoTieuChuan> btcs = new ArrayList<BoTieuChuan>();
		ArrayList<Integer> numPerMonth = new ArrayList<Integer>();
		int max = 0;
		int total = 0;
		String selectedYear = request.getParameter("year");
		String selectedBTC = request.getParameter("btc");
		String selectType = request.getParameter("type");
		if (selectType == null) {
			selectType = "year";
		}

		if (selectedYear == null) {
			if (years.size() > 0 && selectType.equals("year")) {
				selectedYear = years.get(0);
			} else {
				selectedYear = "";
			}
		}

		if (selectType.equals("criteria")) {
			btcs = thongKeDAO.getBTCS();
		}

		if (selectedBTC == null) {
			selectedBTC = "";
		}
	%>
	<div id="wrapper">

		<%@include file="header.jsp"%>

		<div id="page-wrapper">

			<%
				int ulevel = taiKhoan.getUserLevel();
				if (ulevel == 2) {
			%>
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Trang chủ</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<div class="alert alert-info"
				style="text-align: center; color: blue;">
				<h4>Thời gian hiện tại</h4>
				<h4 id="clock"></h4>
			</div>
			<%
				} else if (ulevel == 3) {
					
				%>
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Thống kê minh chứng</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<div class="row">
				<form method="get" action="ThongKe">
					<div class="form-group col-md-3">
						<select name="selectType1" class="form-control">
							<option value="year" <%if (selectType.equals("year")) {%>
								selected <%}%>>
							Năm</option>
							<option value="criteria" <%if (selectType.equals("criteria")) {%>
								selected <%}%>>
							Bộ tiêu chuẩn</option>
						</select>
					</div>
					<div class="form-group col-md-4">
						<select name="selectType2" class="form-control">
							<%
								if (selectType.equals("year")) {
										for (String year : years) {
							%>
							<option value="<%=year%>" <%if (selectedYear.equals(year)) {%>
								selected <%}%>><%=year%></option>
							<%
								}
									} else if (selectType.equals("criteria")) {
										for (BoTieuChuan btc : btcs) {
							%>
							<option value="<%=btc.getID()%>"
								<%if (selectedBTC.equals(btc.getID())) {%> selected <%}%>><%=btc.getTenBoTieuChuan()%></option>

							<%
								}
									}
							%>
						</select>
					</div>
					<div class="form-group col-md-2">
						<input type="submit" class="form-control btn btn-primary"
							name="submit" value="Xem" />
					</div>
				</form>
			</div>
			<%if (selectType.equals("year")) {
							for (int month = 1; month < 13; month++) {
								int num = thongKeDAO.getNumPerMonth(selectedYear, String.valueOf(month));
								total += num;
								if (max < num) {
									max = num;
								}
								numPerMonth.add(num);
							}
			%>
			<div class="panel panel-default">
				<div class="panel-heading">
					Biểu đồ số minh chứng qua các tháng trong năm 
					<%=String.format("%s - Tổng số %s",selectedYear, total)%></div>
				<div class="panel-body">
					<canvas id="barChart"></canvas>
				</div>
			</div>
			<%
				} else if (selectType.equals("criteria")) {
					BoTieuChuan btc = new BoTieuChuan();
					btc.setID(selectedBTC);
					ArrayList<SoMinhChung> smcs = thongKeDAO.getSoMinhChung(btc);
					for (SoMinhChung smc : smcs) {
						int numMC = smc.getSoMinhChung();
						total += numMC;
						if (max < numMC) {
							max = numMC;
						}
					}
			%>
			<!-- Bang Thong ke theo so tieu chuan -->
			<div class="panel panel-default">
				<div class="panel-heading">Số lượng minh chứng theo từng tiêu
					chuẩn - Tổng số <%=total %> </div>
				<div class="panel-body">
					<%
								for (SoMinhChung smc : smcs) {
									int numMC = smc.getSoMinhChung();
									float percent = numMC * 100.f / max;
					%>
					<div>
						<div class="panel box-sd">
							<div class="panel-heading">
								<%=String.format("%s - %s", smc.getTieuChuan().getID(),
								smc.getTieuChuan().getTenTieuChuan())%>
							</div>
							<div class="panel-body">
								<div style="margin: 0;" class="progress">
									<div
										class="progress-bar progress-bar-info progress-bar-striped active"
										role="progressbar" aria-valuenow="<%=percent%>"
										aria-valuemin="0" aria-valuemax="100"
										style="width:<%=percent%>%;color:black;font-weight:bold;">
										<%=numMC%>
									</div>
								</div>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
				<%
					}
					}
				%>
			</div>
		</div>
	</div>
		<!-- jQuery -->
		<script src="vendor/jquery/jquery.min.js"></script>
		<!-- Bootstrap Core JavaScript -->
		<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
		<!-- Metis Menu Plugin JavaScript -->
		<script src="vendor/metisMenu/metisMenu.min.js"></script>
		<!-- Custom Theme JavaScript -->
		<script src="dist/js/sb-admin-2.js"></script>
		<!-- MDB core JavaScript -->
		<!-- Custom JS -->
		<script src="js/send.js"></script>
		<%
			if (ulevel == 3 && selectType.equals("year")) {
		%>
		<!-- Chart -->
		<script type="text/javascript" src="chart/js/mdb.min.js"></script>
		<!-- Bootstrap tooltips -->
		<script>
			var ctxB = document.getElementById("barChart").getContext('2d');
			var myBarChart = new Chart(
					ctxB,
					{
						type : 'bar',
						data : {
							labels : [ "Tháng 1", "2", "3", "4", "5", "6", "7",
									"8", "9", "10", "11", "12" ],
							datasets : [ {
								label : 'số minh chứng',
								data : [
		<%=thongKeDAO.getNumPerMonth(selectedYear, "1")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "2")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "3")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "4")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "5")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "6")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "7")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "8")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "9")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "10")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "11")%>
			,
		<%=thongKeDAO.getNumPerMonth(selectedYear, "12")%>
			, ],
								backgroundColor : [ 'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)',
										'rgba(255, 0, 0, 1)', ]
							} ]
						},
						optionss : {
							scales : {
								yAxes : [ {
									ticks : {
										beginAtZero : true
									}
								} ]
							}
						}
					});
		</script>
		<%
			}
		%>
	
</body>
<%
	if (ulevel == 2) {
%>
<script>
	setInterval(displayTime, 1000);
	function displayTime() {
		var d = new Date();
		document.getElementById("clock").innerHTML = d.toLocaleString();
	}
</script>
<%} %>
</html>