package controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.HoatDongDAO;
import dao.Util;
import model.HoatDong;
import model.TaiKhoan;

/**
 * Servlet implementation class HoatDongServlet
 */
@WebServlet("/admin/HoatDong")
@MultipartConfig
public class HoatDongServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_FOLDER = "HoatDong";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HoatDongServlet() {
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		request.setCharacterEncoding("utf-8");
		String cmd = request.getParameter("command");
		if(cmd == null || cmd.trim().isEmpty()) {
			return;
		}
		if(cmd.equals("delete")) {
			this.xoaHoatDong(request, response);
		} else if(cmd.equals("edit")) {
			this.chuyenHuongSuaHoatDong(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!Util.checkLogin(request)) {
			response.sendRedirect("../index.jsp");
			return;
		}
		request.setCharacterEncoding("utf-8");
		String cmd = this.partToString(request.getPart("Func"));
		if(cmd == null || cmd.trim().isEmpty()) {
			return;
		}
		if(cmd.equals("add")) {
			this.themHoatDong(request, response);
		} else if(cmd.equals("edit")) {
			this.xoaAnh(request, response);
			this.suaHoatDong(request, response);
		} else {
			this.deleteFile(request.getParameter("anhmh"));
		}
	}

	private void chuyenHuongSuaHoatDong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String maHD = request.getParameter("mahd");
		if(maHD == null || !maHD.trim().isEmpty()) {
			HoatDong hd = new HoatDong();
			HoatDongDAO dao = new HoatDongDAO();
			hd.setID(maHD);
			if(dao.getHoaDong(hd)) {
				request.setAttribute("hoatDong", hd);
				request.getRequestDispatcher("suahoatdong.jsp").forward(request, response);
				return;
			}
		}
		response.sendRedirect("hoatdong.jsp");
	}

	private void themHoatDong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tenHD = this.partToString(request.getPart("TenHD"));
		String moTa = this.partToString(request.getPart("MoTa"));
		Part file = request.getPart("img");
		if(
				tenHD == null || tenHD.trim().isEmpty()) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else {
			HoatDong hd = new HoatDong();
			HoatDongDAO hoatDongDAO = new HoatDongDAO();
			hd.setTenHoatDong(tenHD);
			hd.setMoTa(moTa);
			if(file != null && file.getSize() > 0) {
				if(hoatDongDAO.addHoatDong(hd)) {
					String btcFolder = UPLOAD_FOLDER + File.separator + hd.getID();
					if(this.saveFile(file, btcFolder, getServletContext())) {
						String filePath = btcFolder + File.separator + file.getSubmittedFileName();
						hd.setAnh(filePath);
						if(hoatDongDAO.capNhatAnhMinhHoa(hd) < 1) {
							this.deleteFile(filePath);
							errors.add("Lưu ảnh minh họa thất bại!");
						}
					} else {	
						errors.add("Lưu ảnh minh họa thất bại!");
					}
				} else {
					errors.add("Thêm hoạt động thất bại!");
				}
			} else {
				if(!hoatDongDAO.addHoatDong(hd)) {
					errors.add("Thêm hoạt động thất bại!");
				}
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("hoatdong.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("themhoatdong.jsp").forward(request, response);
		}
	}

	private void suaHoatDong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getPart("changeBut") != null) {
			ArrayList<String> errors = new ArrayList<String>();
			HoatDong hd = new HoatDong();
			String anhMH = this.partToString(request.getPart("AnhMH"));
			String maHD =  this.partToString(request.getPart("MaHD"));
			String tenHD = this.partToString(request.getPart("TenHD"));
			String moTa = this.partToString(request.getPart("MoTa"));
			Part file = request.getPart("img");
			hd.setTenHoatDong(tenHD);
			hd.setMoTa(moTa);
			hd.setID(maHD);
			hd.setAnh(anhMH);
			if(		maHD == null || maHD.trim().isEmpty() ||
					tenHD == null || tenHD.trim().isEmpty()) {
				errors.add("Vui lòng điền tất cả các trường bắt buộc!");
			} else {			
				HoatDongDAO hoatDongDAO = new HoatDongDAO();		
				if(file != null && file.getSize() > 0) {
					if(hoatDongDAO.suaHoatDong(hd) > 0) {
						String btcFolder = UPLOAD_FOLDER + File.separator + hd.getID();
						if(this.saveFile(file, btcFolder, getServletContext())) {
							String filePath = btcFolder + File.separator + file.getSubmittedFileName();
							hd.setAnh(filePath);
							if(hoatDongDAO.capNhatAnhMinhHoa(hd) < 1) {
								this.deleteFile(filePath);
								errors.add("Lưu ảnh minh họa thất bại!");
							}
						} else {	
							errors.add("Lưu ảnh minh họa thất bại!");
						}
					} else {
						errors.add("Sửa hoạt động thất bại!");
					}
				} else {
					if(anhMH == null || anhMH.equals("null")) {
						hd.setAnh("");
					}
					if(hoatDongDAO.suaHoatDong(hd) < 1) {
						errors.add("Sửa hoạt động thất bại!");
					}
				}
			}
			if (errors.size() == 0) {
				response.sendRedirect("hoatdong.jsp");
			} else {
				request.setAttribute("errors", errors);
				request.setAttribute("hoatDong", hd);
				request.getRequestDispatcher("suahoatdong.jsp").forward(request, response);
			}
		}
	}

	private void xoaAnh(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getPart("deleteBut") != null) {
			String filePath = this.partToString(request.getPart("AnhMH"));
			String maHD = this.partToString(request.getPart("MaHD"));
			String tenHD = this.partToString(request.getPart("TenHD"));
			String moTa = this.partToString(request.getPart("MoTa"));
			HoatDong hd = new HoatDong();
			hd.setID(maHD);
			hd.setMoTa(moTa);
			hd.setTenHoatDong(tenHD);
			hd.setAnh(filePath);
			ArrayList<String> errors = new ArrayList<String>();
			if(filePath == null || filePath.trim().isEmpty()
					|| maHD == null || maHD.trim().isEmpty()) {
				errors.add("Vui lòng điền tất cả các trường bắt buộc!");
			} else {
				HoatDongDAO dao = new HoatDongDAO();
				hd.setAnh(null);
				this.deleteFile(filePath);
				if(dao.capNhatAnhMinhHoa(hd) < 1) {
					errors.add("Xóa thất bại!");
				}
			}
			if(errors.size() > 0) {
				request.setAttribute("errors", errors);
			}
			request.setAttribute("hoatDong", hd);
			request.getRequestDispatcher("suahoatdong.jsp").forward(request, response);
		}
	}

	private void xoaHoatDong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mahd = request.getParameter("mahd");
		ArrayList<String> errors = new ArrayList<String>();
		if(mahd == null || mahd.trim().isEmpty()) {
			errors.add("Không xác định được hoạt động cần xóa!");
		}
		if(errors.size() == 0) {
			HoatDong hd = new HoatDong();
			HoatDongDAO dao = new HoatDongDAO();
			hd.setID(mahd);
			if(dao.xoaHoatDong(hd)) {
				this.deleteFile(hd.getAnh());
				response.sendRedirect("hoatdong.jsp");
				return;
			} else {
				errors.add("Có lỗi xảy ra!");
			}
		}
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("hoatdong.jsp").forward(request, response);
	}

	private String partToString(Part p) {
		if(p == null)
			return null;
		try(InputStream inp = p.getInputStream();
				ByteArrayOutputStream out = new ByteArrayOutputStream()) {
			byte[] data = new byte[1024];
			int len = 0;
			while((len = inp.read(data)) != -1) {
				out.write(data, 0, len);
			}
			return new String(out.toByteArray(), "utf-8");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	private boolean saveFile(Part p, String folder, ServletContext context) {
		if(p == null || folder == null|| context == null)
			return false;
		String fileName = p.getSubmittedFileName();
		String absFileFolderPath = context.getRealPath("") + File.separator + folder;
		String absFilePath = absFileFolderPath + File.separator + fileName;
		File fileFolderObj = new File(absFileFolderPath);
		if(!fileFolderObj.exists()) {
			fileFolderObj.mkdirs();
		}
		try(InputStream inp = p.getInputStream();
				OutputStream outf = new FileOutputStream(absFilePath)) {
			byte[] data = new byte[2048];
			int len = 0;
			while((len = inp.read(data)) != -1) {
				outf.write(data, 0, len);
			}
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		File invalidFileObj = new File(absFilePath);
		if(invalidFileObj.exists()) {
			invalidFileObj.delete();	
		}
		if(fileFolderObj.exists()) {
			fileFolderObj.delete();
		}
		return false;
	}
}
