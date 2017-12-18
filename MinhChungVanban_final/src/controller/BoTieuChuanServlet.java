package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoTieuChuanDAO;
import dao.Util;
import model.BoTieuChuan;

@WebServlet("/admin/BoTieuChuan")
public class BoTieuChuanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	BoTieuChuanDAO boTieuChuanDAO = new BoTieuChuanDAO();

	public BoTieuChuanServlet() {
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
		String cmd = request.getParameter("command");
		if (cmd != null && !cmd.trim().isEmpty()) {
			switch (cmd) {
			case "delete":
				this.xoaBoTieuChuan(request, response);
				return;
			case "edit":
				request.getRequestDispatcher("suabotieuchuan.jsp").forward(request, response);
				return;
			}
		}
		this.searchBoTieuChuan(request, response);
		this.forwardToMainPage(request, response);
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
				this.themBTC(request, response);
			} else if(cmd.equals("edit")) {
				this.suaBTC(request, response);
			}
		}
	}

	private void xoaBoTieuChuan(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String id = request.getParameter("id");
		ArrayList<String> errors = new ArrayList<String>();
		if(id != null && !id.trim().isEmpty()) {
			if(boTieuChuanDAO.XoaBoTieuChuan(id) > 0) {
				response.sendRedirect("BoTieuChuan");
			} else {
				errors.add("Có lỗi xảy ra!");
			}
		} else {
			errors.add("Không xác định được tiêu chuẩn cần xóa!");
		}
		if(errors.size() > 0) {
			request.setAttribute("errors", errors);
			this.forwardToMainPage(request, response);
		}
	}

	private void searchBoTieuChuan(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		if(request.getParameter("searchBut") != null) {
			ArrayList<String> errors = (ArrayList<String>)request.getAttribute("errors");
			if(errors == null) {
				errors = new ArrayList<String>();
				request.setAttribute("errors", errors);
			}
			String keyword = request.getParameter("keyword");
			ArrayList<BoTieuChuan> btcs = boTieuChuanDAO.searchBoTieuChuan(keyword);
			request.setAttribute("btcs", btcs);
		}
	}

	private void forwardToMainPage(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ArrayList<String> errors = (ArrayList<String>)request.getAttribute("errors");
		ArrayList<BoTieuChuan> btcs = (ArrayList<BoTieuChuan>) request.getAttribute("btcs");
		if(errors == null) {
			errors = new ArrayList<String>();
			request.setAttribute("errors", errors);
		}
		if(btcs == null) {
			btcs = boTieuChuanDAO.searchBoTieuChuan("");
			request.setAttribute("btcs", btcs);
		}
		request.getRequestDispatcher("botieuchuan.jsp").forward(request, response);
	}

	private void themBTC(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tenBoTieuChuan = request.getParameter("TenBTC");
		String moTa = request.getParameter("MoTa");
		if (tenBoTieuChuan != "") {
			if(!boTieuChuanDAO.ThemBoTieuChuan(tenBoTieuChuan, moTa)) {
				errors.add("Có lỗi xảy ra!");
			}
		} else {
			errors.add("Vui lòng điền đầy đủ thông tin các trường bắt buộc!");
		}
		if (errors.size() == 0) {
			response.sendRedirect("BoTieuChuan");
		} else {
			request.setAttribute("errors", errors);
			this.forwardToMainPage(request, response);
		}
	}
	private void suaBTC(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String maBoTieuChuan = request.getParameter("MaBTC");
		String tenBoTieuChuan = request.getParameter("TenBTC");
		String moTa = request.getParameter("MoTa");
		if (maBoTieuChuan != "" && tenBoTieuChuan != "") {
			if(boTieuChuanDAO.SuaBoTieuChuan(maBoTieuChuan, tenBoTieuChuan, moTa) < 1) {
				errors.add("Có lỗi xảy ra!");
			}
		} else {
			errors.add("Vui lòng điền đầy đủ thông tin các trường bắt buộc!");
		}

		if (errors.size() == 0) {
			response.sendRedirect("BoTieuChuan");
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("suabotieuchuan.jsp?command=edit&&id="+maBoTieuChuan).forward(request, response);
		}
	}
}
