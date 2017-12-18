package controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TapTinDAO;
import dao.Util;

@WebServlet("/admin/TapTinServlet")
public class TapTinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	TapTinDAO tapTinDAO = new TapTinDAO();

	public TapTinServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void deleteFile(String src) {
		if(src != null && !src.trim().isEmpty()) {
			String rootPath = getServletContext().getRealPath("");
			File file = new File(rootPath + File.separator + src);
			File folder = file.getParentFile();
			if(file.exists()) {
				file.delete();
			}
			if(folder.exists()) {
				folder.delete();
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		request.setCharacterEncoding("UTF-8");
		ArrayList<String> errors = new ArrayList<String>();
		String url = "MinhChungServlet?command=edit&id=";
		String cmd = request.getParameter("command");
		String maMC = request.getParameter("id");
		if (cmd != null && maMC != null) {
			url += maMC;
			switch (request.getParameter("command")) {
			case "delete":
				System.out.println(maMC);
				String filepath = tapTinDAO.XoaTapTin(maMC);
				if(filepath == null || filepath.trim().isEmpty()) {
					errors.add("Có lỗi xảy ra!");
				} else {
					this.deleteFile(filepath);
				}
				break;
			}
		} else {
			errors.add("Có lỗi xảy ra!");
		}
		if (errors.size() > 0) {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher(url).forward(request, response);
		} else {
			response.sendRedirect(url);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
