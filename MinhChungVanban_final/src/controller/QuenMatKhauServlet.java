package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

import dao.MailDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.TaiKhoanDAO;

@WebServlet("/QuenMatKhau")
public class QuenMatKhauServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TaiKhoanDAO taikhoan_dao = new TaiKhoanDAO();

    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static Random rnd = new Random();

    String randomString( int len ){
       StringBuilder sb = new StringBuilder( len );
       for( int i = 0; i < len; i++ ) 
          sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
       return sb.toString();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
        try {
        	response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("utf-8");
            
        	String user = "chsachvietbook@gmail.com";
            String pass = "chsachvb";
            String to = request.getParameter("email");
            String newpass = randomString(6);
			if(taikhoan_dao.CapLaiMatKhau(to, newpass)) {
				String subject = "Cấp lại mật khẩu mới cho tài khoản Website Quản lý Minh chứng UTE.";
			    String message = "Mật khẩu mới của bạn là <b>" + newpass +
			    		"</b>. Nếu bạn không yêu cầu nội dung này, bạn có thể phản phản hồi lại giúp chúng tôi tại địa chỉ " +
			    		user + ". Chúng tôi cảm ơn bạn đã đọc thư này.";
			   
			    MailDAO mailDAO = new MailDAO();
			    mailDAO.send(to, subject, message, user, pass);
			    errors.add("Đã đặt lại mật khẩu thành công! Vui lòng kiểm tra lại hòm thư của bạn để biết mật khẩu mới.");
			}
			else
				errors.add("Vui lòng kiểm tra lại tài khoản!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			errors.add("Có lỗi xảy ra!");
		}
        request.setAttribute("errors", errors);
		request.getRequestDispatcher("caplaimatkhau.jsp").forward(request, response);
        
	}
}
