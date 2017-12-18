	$(document).ready(function() {
		var x_timer;
		$("#BoTieuChuan").change(function(e) {
			clearTimeout(x_timer);
			var idBoTieuChuan = $("option:selected", this).val();
			x_timer = setTimeout(function() {
				update_tieuchuan_data(idBoTieuChuan);
				update_tieuchi_data(-1);
			}, 100);
		});

		$("#TieuChuan").change(function(e) {
			clearTimeout(x_timer);
			var idTieuChuan = $("option:selected", this).val();
			x_timer = setTimeout(function() {
				update_tieuchi_data(idTieuChuan);
			}, 100);
		});

		$("#aadd-attachment").click(function() {
			alert('aaaaa');
			var str = $("#attachment").html();
			str += '<div class="form-group"><input type="file"></div>';
			$("#attachment").html(str);
		});

		function update_tieuchuan_data(idBoTieuChuan) {
			$.post('GetOptionHTMLServlet', {
				'Type' : "TieuChuan",
				'ID' : idBoTieuChuan
			}, function(data) {
				$("#TieuChuan").html(data);
			});
		}

		function update_tieuchi_data(idTieuChuan) {
			$.post('GetOptionHTMLServlet', {
				'Type' : "TieuChi",
				'ID' : idTieuChuan
			}, function(data) {
				$("#TieuChi").html(data);
			});
		}

	});
	
	$(document).ready(function() {
		var x_timer;
		$("#BoTieuChuan").change(function(e) {
			clearTimeout(x_timer);
			$("#optBTC").remove();
			var idBoTieuChuan = $("option:selected", this).val();
			x_timer = setTimeout(function() {
				update_data(idBoTieuChuan);
			}, 100);
		});

		function update_data(idBoTieuChuan) {
			$.post('GetOptionHTMLServlet', {
				'Type' : "TieuChuan",
				'ID' : idBoTieuChuan
			}, function(data) {
				$("#TieuChuan").html(data);
			});
		}
	});