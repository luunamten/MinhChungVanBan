package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ThongBaoDAO;
import dao.Util;
import model.TaiKhoan;

@WebServlet("/admin/ThongBaoServlet")
public class ThongBaoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ThongBaoDAO thongBaoDAO = new ThongBaoDAO();

	public ThongBaoServlet() {
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
		String url = "thongbao.jsp";
		String matb = request.getParameter("matb");
		String cmd = request.getParameter("command");
		if (cmd != null && !cmd.trim().isEmpty() && matb != null && !matb.trim().isEmpty()) {
			switch (cmd) {
			case "delete":
				if(thongBaoDAO.XoaThongBao(matb) > 0) {
					response.sendRedirect(url);
					return;
				} else {
					errors.add("Có lỗi xảy ra!");
				}
				break;
			case "edit":
				request.getRequestDispatcher("suathongbao.jsp").forward(request, response);
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
		HttpSession session = request.getSession(false);
		if(session != null) {
			TaiKhoan account = (TaiKhoan)session.getAttribute("login");
			if(account != null) {
				String cmd = request.getParameter("Func");
				if (cmd != null && !cmd.trim().isEmpty()) {
					if(cmd.equals("add")) {
						this.themThongBao(request, response, account);
						return;
					} else if(cmd.equals("edit")) {
						this.suaThongBao(request, response, account);
						return;
					}
				}
			}
		}
		response.sendRedirect("../index.jsp");
	}

	private void themThongBao(HttpServletRequest request, HttpServletResponse response, TaiKhoan account)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tieuDe = request.getParameter("TieuDe");
		String noiDung = request.getParameter("NoiDung");
		if (tieuDe == "" || noiDung == "") {
			errors.add("Vui lòng điền đầy đủ thông tin các trường bắt buộc!");
		} else {

			if(!thongBaoDAO.ThemThongBao(tieuDe, noiDung, account)) {
				errors.add("Có lỗi xảy ra!");
			}

		}
		if (errors.size() > 0) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("themthongbao.jsp").forward(request, response);
		} else {
			response.sendRedirect("thongbao.jsp");
		}
	}

	private void suaThongBao(HttpServletRequest request, HttpServletResponse response, TaiKhoan account)
			throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tieuDe = request.getParameter("TieuDe");
		String noiDung = request.getParameter("NoiDung");
		if (tieuDe == "" || noiDung == "") {
			errors.add("Vui lòng điền đầy đủ thông tin các trường bắt buộc!");
		} else {
			String idThongBao = request.getParameter("IDThongBao");
			if(thongBaoDAO.SuaThongBao(idThongBao, tieuDe, noiDung) < 1) {
				errors.add("Có lỗi xảy ra!");
			}
		}
		if (errors.size() > 0) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("themthongbao.jsp").forward(request, response);
		} else {
			response.sendRedirect("thongbao.jsp");
		}
	}
}
