package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ThongKeDAO;
import dao.TieuChiDAO;
import dao.TieuChuanDAO;
import model.BoTieuChuan;
import model.TieuChi;
import model.TieuChuan;

@WebServlet("/admin/GetOptionHTMLServlet")
public class GetOptionHTMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();
	TieuChiDAO tieuChiDAO = new TieuChiDAO();
	ThongKeDAO thongKeDAO = new ThongKeDAO();
	public GetOptionHTMLServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("ID");
		String result = "<option selected disabled hidden style=\"display: none\" value=\"\"></option>";
		String type = request.getParameter("Type");
		try {
			if(type.equals("BoTieuChuan")) {
			}
			else if(type.equals("TieuChuan")) {
				for (TieuChuan tieuChuan : tieuChuanDAO.getListTieuChuanByBoTieuChuan(id)) {
					result += "<option value=\"" + tieuChuan.getID() + "\">" + tieuChuan.getTenTieuChuan()
					+ "</option>";
				}
			} else if(type.equals("TieuChi")) {
				for (TieuChi tieuChi : tieuChiDAO.getListTieuChiByTieuChuan(id)) {
					result += "<option value=\"" + tieuChi.getID() + "\">" + tieuChi.getTenTieuChi() + "</option>";
				}
			}
			else if(type.equals("year")) {
				result ="";
				for (String year : thongKeDAO.getYears()) {
					result += "<option value=\"" + year + "\">" + year + "</option>";
				}
			} else if(type.equals("criteria")) {
				result = "";
				for(BoTieuChuan btc : thongKeDAO.getBTCS()) {
					result += "<option value='" + btc.getID() + "'>" + btc.getTenBoTieuChuan() + "</option>";
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(result);
	}
}
