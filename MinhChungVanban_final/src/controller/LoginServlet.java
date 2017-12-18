package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TaiKhoanDAO;
import model.TaiKhoan;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

	public LoginServlet() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		TaiKhoan account = new TaiKhoan();
		ArrayList<String> errors = new ArrayList<String>();
		try {
			account.setEmail(email);
			account.setMatKhau(password);
			if (email == "" || password == "" || !taiKhoanDAO.login(account)) {
				errors.add("Sai tài khoản hoặc mật khẩu!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			errors.add("Có lỗi xảy ra!");
		}
		if (errors.size() == 0) {
			HttpSession session = request.getSession(true);			//Edit				
			session.setAttribute("login", account);
			/*Cookie loginCookie = new Cookie("loginUser", email);
			loginCookie.setMaxAge(-1);
			response.addCookie(loginCookie);
			Cookie PassCookie = new Cookie("passUser", password);
			PassCookie.setMaxAge(-1);
			response.addCookie(PassCookie);
			response.sendRedirect("index.jsp");*/
			response.sendRedirect("index.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	public static void main(String agrs[]) {
		System.out.println();
	}
}
