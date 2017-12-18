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