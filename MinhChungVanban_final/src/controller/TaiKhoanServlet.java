package controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.ChangePass;
import dao.DBConnect;
import dao.HoatDongDAO;
import dao.TaiKhoanDAO;
import dao.Util;
import model.HoatDong;
import model.TaiKhoan;

@WebServlet({"/admin/TaiKhoan", "/TaiKhoan"})
@MultipartConfig
public class TaiKhoanServlet extends HttpServlet {

	TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_FOLDER = "Avatar";
	public TaiKhoanServlet() {
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
		String url = "taikhoan.jsp";
		if (request.getParameter("command") != null) {
			switch (request.getParameter("command")) {
			case "delete":
				this.xoaTaiKhoan(request, response);
				return;
			case "edit":
				request.getRequestDispatcher("suataikhoan.jsp").forward(request, response);
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
		String cmd = this.partToString(request.getPart("Func"));
		if(cmd.equals("add")) {
			this.themTaiKhoan(request, response);
		} else if(cmd.equals("edit")) {
			this.suaTaiKhoan(request, response);
		} else if(cmd.equals("uedit")) {
			this.userSuaTaiKhoan(request, response);
		} else if(cmd.equals("pedit")) {
			this.doiMatKhau(request, response);
		}
	}

	private void themTaiKhoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		ArrayList<String> errors = new ArrayList<String>();
		String email = this.partToString(request.getPart("Email"));
		String matKhau = this.partToString(request.getPart("MatKhau"));
		String reMatKhau = this.partToString(request.getPart("Re-MatKhau"));
		String hoTen = this.partToString(request.getPart("HoTen"));
		String userLevel = this.partToString(request.getPart("IDLoaiTaiKhoan"));
		String gioiTinh = this.partToString(request.getPart("GioiTinh"));
		String ngaySinh = this.partToString(request.getPart("NgaySinh"));
		String diaChi = this.partToString(request.getPart("DiaChi"));
		String noiCongTac = this.partToString(request.getPart("NoiCongTac"));
		String chucVu = this.partToString(request.getPart("ChucVu"));
		String soDienThoai = this.partToString(request.getPart("SoDienThoai"));
		Part avatar = request.getPart("Avatar");
		TaiKhoan tk = new TaiKhoan();
		tk.setEmail(email);
		tk.setMatKhau(matKhau);
		tk.setHoTen(hoTen);
		tk.setUserLevel((userLevel.equals(""))?0:Integer.parseInt(userLevel));
		tk.setNu((gioiTinh.equals("Nu"))?true:false);
		tk.setNgaySinh(ngaySinh);
		tk.setDiaChi(diaChi);
		tk.setNoiCongTac(noiCongTac);
		tk.setChucVu(chucVu);
		tk.setSoDienThoai(soDienThoai);
		if(
				email.isEmpty() ||
				matKhau.isEmpty() ||
				reMatKhau.isEmpty() ||
				hoTen.isEmpty() ||
				userLevel.isEmpty() ||
				gioiTinh.isEmpty() ||
				ngaySinh.isEmpty() ||
				diaChi.isEmpty() ||
				noiCongTac.isEmpty() ||
				chucVu.isEmpty() ||
				soDienThoai.isEmpty()) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else if(!matKhau.equals(reMatKhau)) {
			errors.add("Nhập lại mật khẩu không trùng khớp!");
		}	else {	
			if(avatar != null && avatar.getSize() > 0) {
				if(taiKhoanDAO.ThemTaiKhoan(tk) > 0) {
					String btcFolder = UPLOAD_FOLDER + File.separator + tk.getEmail();
					if(this.saveFile(avatar, btcFolder, getServletContext())) {
						String filePath = btcFolder + File.separator + avatar.getSubmittedFileName();
						tk.setAnhDaiDien(filePath);
						if(taiKhoanDAO.capNhatAnh(tk) < 1) {
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
				if(taiKhoanDAO.ThemTaiKhoan(tk) < 1) {
					errors.add("Thêm hoạt động thất bại!");
				}
			}
		}

		if (errors.size() == 0) {
			response.sendRedirect("taikhoan.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("account", tk);
			request.getRequestDispatcher("themtaikhoan.jsp").forward(request, response);
		}
	}

	private void suaTaiKhoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		ArrayList<String> errors = new ArrayList<String>();
		String oldEmail = this.partToString(request.getPart("oldEmail"));
		String hoTen = this.partToString(request.getPart("HoTen"));
		String userLevel = this.partToString(request.getPart("IDLoaiTaiKhoan"));
		String gioiTinh = this.partToString(request.getPart("GioiTinh"));
		String ngaySinh = this.partToString(request.getPart("NgaySinh"));
		String diaChi = this.partToString(request.getPart("DiaChi"));
		String noiCongTac = this.partToString(request.getPart("NoiCongTac"));
		String chucVu = this.partToString(request.getPart("ChucVu"));
		String soDienThoai = this.partToString(request.getPart("SoDienThoai"));
		String oldimg = this.partToString(request.getPart("oldimg"));
		Part avatar = request.getPart("Avatar");
		TaiKhoan tk = new TaiKhoan();
		tk.setEmail(oldEmail);
		tk.setHoTen(hoTen);
		tk.setUserLevel((userLevel.equals(""))?0:Integer.parseInt(userLevel));
		tk.setNu((gioiTinh.equals("Nu"))?true:false);
		tk.setNgaySinh(ngaySinh);
		tk.setDiaChi(diaChi);
		tk.setNoiCongTac(noiCongTac);
		tk.setChucVu(chucVu);
		tk.setSoDienThoai(soDienThoai);
		tk.setAnhDaiDien(oldimg);
		if(
				oldEmail.isEmpty() ||
				oldEmail.isEmpty() ||
				hoTen.isEmpty() ||
				userLevel.isEmpty() ||
				gioiTinh.isEmpty() ||
				ngaySinh.isEmpty() ||
				diaChi.isEmpty() ||
				noiCongTac.isEmpty() ||
				chucVu.isEmpty() ||
				soDienThoai.isEmpty()) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else {	
			if(avatar != null && avatar.getSize() > 0) {
				if(taiKhoanDAO.suaTaiKhoan(tk) > 0) {
					String btcFolder = UPLOAD_FOLDER + File.separator + tk.getEmail();
					if(!oldimg.isEmpty()) {
						this.deleteFile(oldimg);
					}
					if(this.saveFile(avatar, btcFolder, getServletContext())) {
						String filePath = btcFolder + File.separator + avatar.getSubmittedFileName();
						tk.setAnhDaiDien(filePath);
						if(taiKhoanDAO.capNhatAnh(tk) < 1) {
							this.deleteFile(filePath);
							errors.add("Lưu ảnh thất bại!");
						}
					} else {	
						errors.add("Lưu ảnh  thất bại!");
					}
				} else {
					errors.add("Sửa tài khoản thất bại!");
				}
			} else {	
				if(taiKhoanDAO.suaTaiKhoan(tk) < 1) {
					errors.add("Sửa tài khoản thất bại!");
				}
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("taikhoan.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("account", tk);
			request.getRequestDispatcher("suataikhoan.jsp").forward(request, response);
		}
	}
	
	private void userSuaTaiKhoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		ArrayList<String> errors = new ArrayList<String>();
		String email = this.partToString(request.getPart("Email"));
		String hoTen = this.partToString(request.getPart("HoTen"));
		String gioiTinh = this.partToString(request.getPart("GioiTinh"));
		String ngaySinh = this.partToString(request.getPart("NgaySinh"));
		String diaChi = this.partToString(request.getPart("DiaChi"));
		String noiCongTac = this.partToString(request.getPart("NoiCongTac"));
		String chucVu = this.partToString(request.getPart("ChucVu"));
		String soDienThoai = this.partToString(request.getPart("SoDienThoai"));
		String oldimg = this.partToString(request.getPart("oldimg"));
		Part avatar = request.getPart("Avatar");
		TaiKhoan tk = new TaiKhoan();
		tk.setEmail(email);
		tk.setHoTen(hoTen);
		tk.setNu((gioiTinh.equals("Nu"))?true:false);
		tk.setNgaySinh(ngaySinh);
		tk.setDiaChi(diaChi);
		tk.setNoiCongTac(noiCongTac);
		tk.setChucVu(chucVu);
		tk.setSoDienThoai(soDienThoai);
		tk.setAnhDaiDien(oldimg);
		if(
				email.isEmpty() ||
				hoTen.isEmpty() ||
				gioiTinh.isEmpty() ||
				ngaySinh.isEmpty() ||
				diaChi.isEmpty() ||
				noiCongTac.isEmpty() ||
				chucVu.isEmpty() ||
				soDienThoai.isEmpty()) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else {	
			if(avatar != null && avatar.getSize() > 0) {
				if(taiKhoanDAO.userSuaTaiKhoan(tk) > 0) {
					String btcFolder = UPLOAD_FOLDER + File.separator + tk.getEmail();
					if(!oldimg.isEmpty()) {
						this.deleteFile(oldimg);
					}
					if(this.saveFile(avatar, btcFolder, getServletContext())) {
						String filePath = btcFolder + File.separator + avatar.getSubmittedFileName();
						tk.setAnhDaiDien(filePath);
						if(taiKhoanDAO.capNhatAnh(tk) < 1) {
							this.deleteFile(filePath);
							errors.add("Lưu ảnh thất bại!");
						}
					} else {	
						errors.add("Lưu ảnh  thất bại!");
					}
				} else {
					errors.add("Sửa tài khoản thất bại!");
				}
			} else {
				if(oldimg == null || oldimg.equals("null")) {
					tk.setAnhDaiDien("");
				}
				if(taiKhoanDAO.userSuaTaiKhoan(tk) < 1) {
					errors.add("Sửa tài khoản thất bại!");
				}
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("profile.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("account", tk);
			request.getRequestDispatcher("capnhattaikhoan.jsp").forward(request, response);
		}
	}
	
	private TaiKhoan getTaiKhoan(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if(session != null) {
			TaiKhoan tk = (TaiKhoan)session.getAttribute("login");
			return tk;
		} else {
			return new TaiKhoan();
		}
	}
	
	private void doiMatKhau(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		TaiKhoan tk = this.getTaiKhoan(request);
		ArrayList<String> errors = new ArrayList<String>();
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		String reNewPass = request.getParameter("reNewPass");
		ChangePass cpass = new ChangePass();
		cpass.setOldPass(oldPass);
		cpass.setNewPass(newPass);
		cpass.setReNewPass(reNewPass);
		cpass.setEmail(tk.getEmail());
		if(oldPass == null || oldPass.trim().isEmpty() ||
				newPass == null || newPass.trim().isEmpty() ||
				reNewPass == null || reNewPass.trim().isEmpty()) {
			errors.add("Vui lòng điền đầy đủ thông tin!");
		} else if(!tk.getMatKhau().equals(oldPass)) {
			errors.add("Mật khẩu cũ sai!");
		} else if(!reNewPass.equals(newPass)) {
			errors.add("Nhập lại mật khẩu không đúng!");
		} else {
			if(taiKhoanDAO.changePass(cpass) < 1) {
				errors.add("Đổi mật khẩu thất bại");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("profile.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("cpass", cpass);
			request.getRequestDispatcher("doimatkhau.jsp").forward(request, response);
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

	private void xoaTaiKhoan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		ArrayList<String> errors = new ArrayList<String>();
		if(email == null || email.trim().isEmpty()) {
			errors.add("Không xác định được hoạt động cần xóa!");
		}
		if(errors.size() == 0) {
			TaiKhoan tk = new TaiKhoan();;
			tk.setEmail(email);
			if(taiKhoanDAO.XoaTaiKhoan(tk)) {
				this.deleteFile(tk.getAnhDaiDien());
				response.sendRedirect("taikhoan.jsp");
				return;
			} else {
				errors.add("Có lỗi xảy ra!");
			}
		}
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("taikhoan.jsp").forward(request, response);
	}

	private String partToString(Part p) {
		if(p == null)
			return "";
		try(InputStream inp = p.getInputStream();
				ByteArrayOutputStream out = new ByteArrayOutputStream()) {
			byte[] data = new byte[1024];
			int len = 0;
			while((len = inp.read(data)) != -1) {
				out.write(data, 0, len);
			}
			String res = new String(out.toByteArray(), "utf-8");
			return (res == null)?"":res;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
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
