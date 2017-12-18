package controller;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Util;

/**
 * Servlet implementation class ThongKeServlet
 */
@WebServlet("/admin/ThongKe")
public class ThongKeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ThongKeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		String selectType = request.getParameter("selectType1");
		if(selectType != null) {
			if(selectType.equals("year")) {
				String year = request.getParameter("selectType2");
				String url = String.format("index.jsp?year=%s&type=%s", year, selectType);
				request.getRequestDispatcher(url).forward(request, response);
			} else if(selectType.equals("criteria")) {
				String mabtc = request.getParameter("selectType2");
				String url = String.format("index.jsp?btc=%s&type=%s", mabtc, selectType);
				request.getRequestDispatcher(url).forward(request, response);
			}
		} else {
			response.sendRedirect("index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
