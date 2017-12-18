package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TieuChiDAO;
import dao.Util;
import model.TieuChi;

@WebServlet("/admin/TieuChiServlet")
public class TieuChiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TieuChiDAO tieuChiDAO = new TieuChiDAO();

	public TieuChiServlet() {
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
		String url = "tieuchi.jsp";
		if (request.getParameter("command") != null && request.getParameter("id") != null) {
			String maTieuChi = request.getParameter("id");
			switch (request.getParameter("command")) {
			case "delete":
				if(tieuChiDAO.XoaTieuChi(maTieuChi) > 0) {
					response.sendRedirect(url);
				} else {
					errors.add("Có lỗi xảy ra!");
				}
				break;
			case "edit":
				request.getRequestDispatcher("suatieuchi.jsp").forward(request, response);
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
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		request.setCharacterEncoding("UTF-8");
		String cmd = request.getParameter("Func");
		if (cmd != null && !cmd.trim().isEmpty()) {
			if(cmd.equals("add")) {
				this.themTieuChi(request, response);
			} else if(cmd.equals("edit")) {
				this.suaTieuChi(request, response);
			}
		}
	}

	private void themTieuChi(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String url = "tieuchi.jsp";
		String maTieuChuan = request.getParameter("MaTieuChuan");
		String tenTieuChi = request.getParameter("TenTieuChi");
		if (maTieuChuan == null || maTieuChuan.trim().isEmpty() 
				|| tenTieuChi == null || tenTieuChi.trim().isEmpty()) {
			errors.add("Vui lòng điền đầy đủ các trường!");
		} else {
			if(!tieuChiDAO.ThemTieuChi(maTieuChuan, tenTieuChi)) {
				errors.add("Có lỗi xảy ra!");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect(url);
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher(url).forward(request, response);
		}
	}

	private void suaTieuChi(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String maTieuChuan = request.getParameter("MaTieuChuan");
		String maTieuChi = request.getParameter("MaTieuChi");
		String tenTieuChi = request.getParameter("TenTieuChi");
		TieuChi tch = new TieuChi();
		tch.setID(maTieuChi);
		tch.setMaTieuChuan(maTieuChuan);
		tch.setTenTieuChi(tenTieuChi);
		if (maTieuChuan == null || maTieuChuan.trim().isEmpty() || 
				maTieuChi == null || maTieuChi.trim().isEmpty() || 
				tenTieuChi == null || tenTieuChi.trim().isEmpty()) {
			errors.add("Vui lòng điền đầy đủ các trường!");
		} else {
			if(tieuChiDAO.SuaTieuChi(tch) < 0) {
				errors.add("Có lỗi xảy ra!");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("tieuchi.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("tch", tch);
			request.getRequestDispatcher("suatieuchi.jsp").forward(request, response);
		}
	}
}