package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TieuChuanDAO;
import dao.Util;
import model.TieuChuan;

@WebServlet("/admin/TieuChuanServlet")
public class TieuChuanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TieuChuanDAO tieuChuanDAO = new TieuChuanDAO();

	public TieuChuanServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		request.setCharacterEncoding("UTF-8");
		ArrayList<String> errors = new ArrayList<String>();
		String url = "tieuchuan.jsp";
		if (request.getParameter("command") != null && request.getParameter("id") != null) {
			String id = request.getParameter("id");
			switch (request.getParameter("command")) {
			case "delete":
				if(tieuChuanDAO.XoaTieuChuan(id) > 0) {
					response.sendRedirect(url);
				} else {
					errors.add("Có lỗi xảy ra!");
				}
				break;
			case "edit":
				request.getRequestDispatcher("suatieuchuan.jsp").forward(request, response);
				return;
			}
		} else {
			errors.add("Có lỗi xảy ra!");
		}

		if (errors.size() > 0) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher(url).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String cmd = request.getParameter("Func");
		if (cmd != null && !cmd.trim().isEmpty()) {
			if(cmd.equals("add")) {
				this.themTieuChuan(request, response);
			} else if(cmd.equals("edit")) {
				this.suaTieuChuan(request, response);
			}
		}
	}

	private void themTieuChuan(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tenTieuChuan = request.getParameter("TenTC");
		String idBoTieuChuan = request.getParameter("IDBoTieuChuan");
		if (tenTieuChuan == "" || idBoTieuChuan == null || idBoTieuChuan.trim().isEmpty()) {
			errors.add("Vui lòng điền đủ thông tin!");
		} else {
			if(!tieuChuanDAO.ThemTieuChuan(idBoTieuChuan, tenTieuChuan)) {
				errors.add("Có lỗi xảy ra!");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("tieuchuan.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("tieuchuan.jsp").forward(request, response);
		}
	}

	private void suaTieuChuan(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String maTieuChuan = request.getParameter("MaTC");
		String tenTieuChuan = request.getParameter("TenTC");
		String idBoTieuChuan = request.getParameter("IDBoTieuChuan");
		TieuChuan tc = new TieuChuan();
		tc.setMaBoTieuChuan(idBoTieuChuan);
		tc.setTenTieuChuan(tenTieuChuan);
		tc.setID(maTieuChuan);
		if (maTieuChuan == "" || tenTieuChuan == "" || idBoTieuChuan == null || idBoTieuChuan.trim().isEmpty()) {
			errors.add("Vui lòng điền đủ thông tin!");
		} else {
			if(tieuChuanDAO.SuaTieuChuan(maTieuChuan, idBoTieuChuan, tenTieuChuan) < 1) {
				errors.add("Có lỗi xảy ra!");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("tieuchuan.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("tc", tc);
			request.getRequestDispatcher("suatieuchuan.jsp").forward(request, response);
		}
	}
}
