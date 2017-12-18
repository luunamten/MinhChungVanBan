package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoiBanHanhDAO;
import dao.Util;

@WebServlet("/admin/NoiBanHanhServlet")
public class NoiBanHanhServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	NoiBanHanhDAO noiBanHanhDAO = new NoiBanHanhDAO();

	public NoiBanHanhServlet() {
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
		String url = "noibanhanh.jsp";
		if (request.getParameter("command") != null && request.getParameter("id") != null) {
			String maNBH = request.getParameter("id");
			switch (request.getParameter("command")) {
			case "delete":
				try {
					noiBanHanhDAO.XoaNoiBanHanh(maNBH);
					response.sendRedirect(url);
				} catch (SQLException e) {
					errors.add("Có lỗi xảy ra!");
					e.printStackTrace();
				}
				break;
			case "edit":
				request.getRequestDispatcher("suanoibanhanh.jsp").forward(request, response);
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
		ArrayList<String> errors = new ArrayList<String>();
		if (request.getParameter("Func") != null) {
			String maNoiBanHanh = request.getParameter("MaNoiBanHanh");
			String tenNoiBanHanh = request.getParameter("TenNoiBanHanh");
			if (tenNoiBanHanh == "") {
				errors.add("Vui lòng điền đầy đủ thông tin các trường bắt buộc!");
			} else {
				try {
					switch (request.getParameter("Func")) {
					case "add":
						noiBanHanhDAO.ThemNoiBanHanh(tenNoiBanHanh);
						break;
					case "edit":
						noiBanHanhDAO.SuaNoiBanHanh(maNoiBanHanh, tenNoiBanHanh);
						break;
					}
				} catch (SQLException e) {
					errors.add("Có lỗi xảy ra!");
					e.printStackTrace();
				}
			}
		} else {
			errors.add("Có lỗi xảy ra");
		}
		if (errors.size() == 0) {
			response.sendRedirect("noibanhanh.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("noibanhanh.jsp").forward(request, response);
		}
	}
}
