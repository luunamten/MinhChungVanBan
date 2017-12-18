package controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.MinhChungDAO;
import dao.TapTinDAO;
import model.BoTieuChuan;
import model.MinhChung;
import model.TaiKhoan;

@WebServlet("/admin/MinhChungServlet")
@MultipartConfig
public class MinhChungServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_FOLDER = "MinhChung";
	MinhChungDAO minhChungDAO = new MinhChungDAO();
	TapTinDAO tapTinDAO = new TapTinDAO();

	public MinhChungServlet() {
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
		HttpSession session = request.getSession(false);	
		if(session != null) {
			TaiKhoan account = (TaiKhoan)session.getAttribute("login");
			if(account != null) {
				request.setCharacterEncoding("UTF-8");
				ArrayList<String> errors = new ArrayList<String>();
				if (request.getParameter("command") != null && request.getParameter("id") != null) {
					String id = request.getParameter("id");
					switch (request.getParameter("command")) {
					case "delete":
						try {
							String src = minhChungDAO.XoaMinhChung(id, account);
							this.deleteFile(src);
							response.sendRedirect("minhchung.jsp");
							return;
						} catch (SQLException e) {
							errors.add("Đã có lỗi xảy ra!");
							e.printStackTrace();
						}
						break;
					case "edit":
						request.getRequestDispatcher("suaminhchung.jsp").forward(request, response);
						return;
					}

				} else {
					errors.add("Đã có lỗi xảy ra!");
				}
				if (errors.size() > 0) {
					request.setAttribute("errors", errors);
					request.getRequestDispatcher("minhchung.jsp").forward(request, response);
					return;
				}
			}
		}
		response.sendRedirect("../index.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session != null) {
			TaiKhoan account = (TaiKhoan)session.getAttribute("login");
			if(account != null) {
				request.setCharacterEncoding("UTF-8");
				String cmd = this.partToString(request.getPart("Func"));
				if(cmd != null && !cmd.trim().isEmpty()) {
					if(cmd.equals("add")) {
						this.themMinhChung(request, response, account);
						return;
					} else if(cmd.equals("edit")) {
						this.updateMinhChung(request, response, account);
						return;
					}
				}
			}
		} 
		response.sendRedirect("../index.jsp");
	}

	private void themMinhChung(
			HttpServletRequest request, HttpServletResponse response, TaiKhoan account) throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String tenMinhChung = this.partToString(request.getPart("TenMinhChung"));
		String moTa = this.partToString(request.getPart("MoTa"));
		String soHieu = this.partToString(request.getPart("SoHieu"));
		String maBTC = this.partToString(request.getPart("IDBoTieuChuan"));
		String maTieuChuan = this.partToString(request.getPart("IDTieuChuan"));
		String maTieuChi = this.partToString(request.getPart("IDTieuChi"));
		String maNoiBanHanh = this.partToString(request.getPart("IDNoiBanHanh"));
		String ngayBanHanh = this.partToString(request.getPart("NgayBanHanh"));
		String maHoatDong = this.partToString(request.getPart("MaHoatDong"));
		Part file = request.getPart("attach");
		MinhChung mc = new MinhChung();
		mc.setMaTieuChi(maTieuChi);
		mc.setTenMinhChung(tenMinhChung);
		mc.setMoTa(moTa);
		mc.setSoHieu(soHieu);
		mc.setNgayBanhanh(ngayBanHanh);
		mc.setMaNoiBanHanh(maNoiBanHanh);
		mc.setEmail(account.getEmail());
		mc.setMaHoatDong(maHoatDong);
		if(
				tenMinhChung == null || tenMinhChung.trim().isEmpty() ||
				soHieu == null || soHieu.trim().isEmpty() ||
				maTieuChi == null || maTieuChi.trim().isEmpty() ||
				maBTC == null || maBTC.trim().isEmpty() ||
				maTieuChuan == null || maTieuChuan.trim().isEmpty() ||
				maNoiBanHanh == null || maNoiBanHanh.trim().isEmpty() ||
				ngayBanHanh == null || ngayBanHanh.trim().isEmpty() ||
				maHoatDong == null || maHoatDong.trim().isEmpty() ||
				file == null || file.getSize() == 0) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else {
			if(minhChungDAO.ThemMinhChung(mc)) {
				String btcFolder = mc.getID();
				if(!this.saveFile(file, btcFolder, mc, getServletContext())) {
					errors.add("Thêm minh chứng thất bại!");
				}
			} else {
				errors.add("Thêm minh chứng thất bại!");
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("minhchung.jsp");
		} else {
			request.setAttribute("mc", mc);
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("themminhchung.jsp").forward(request, response);
		}
	}

	private void updateMinhChung(
			HttpServletRequest request, HttpServletResponse response, TaiKhoan account) throws ServletException, IOException {
		ArrayList<String> errors = new ArrayList<String>();
		String maMinhChung = this.partToString(request.getPart("MaMinhChung"));
		String tenMinhChung = this.partToString(request.getPart("TenMinhChung"));
		String moTa = this.partToString(request.getPart("MoTa"));
		String soHieu = this.partToString(request.getPart("SoHieu"));
		String maBTC = this.partToString(request.getPart("IDBoTieuChuan"));
		String maTieuChuan = this.partToString(request.getPart("IDTieuChuan"));
		String maTieuChi = this.partToString(request.getPart("IDTieuChi"));
		String maNoiBanHanh = this.partToString(request.getPart("IDNoiBanHanh"));
		String ngayBanHanh = this.partToString(request.getPart("NgayBanHanh"));
		String maHoatDong = this.partToString(request.getPart("MaHoatDong"));
		Part file = request.getPart("attach");
		MinhChung mc = new MinhChung();
		mc.setID(maMinhChung);
		mc.setMaTieuChi(maTieuChi);
		mc.setTenMinhChung(tenMinhChung);
		mc.setMoTa(moTa);
		mc.setSoHieu(soHieu);
		mc.setNgayBanhanh(ngayBanHanh);
		mc.setMaNoiBanHanh(maNoiBanHanh);
		mc.setEmail(account.getEmail());
		mc.setMaHoatDong(maHoatDong);
		if(
				maMinhChung == null || maMinhChung.trim().isEmpty() ||
				tenMinhChung == null || tenMinhChung.trim().isEmpty() ||
				soHieu == null || soHieu.trim().isEmpty() ||
				maTieuChi == null || maTieuChi.trim().isEmpty() ||
				maBTC == null || maBTC.trim().isEmpty() ||
				maTieuChuan == null || maTieuChuan.trim().isEmpty() ||
				maNoiBanHanh == null || maNoiBanHanh.trim().isEmpty() ||
				ngayBanHanh == null || ngayBanHanh.trim().isEmpty() ||
				maHoatDong == null || maHoatDong.trim().isEmpty()) {
			errors.add("Vui lòng điền tất cả các trường bắt buộc!");
		} else {	
			try {
				if(minhChungDAO.SuaMinhChung(mc) > 0) {
					String btcFolder = mc.getID();
					if(file != null && file.getSize() > 0) {
						if(!this.saveFile(file, btcFolder, mc, getServletContext())) {
							errors.add("Cập nhật minh chứng thất bại!");
						}
					}
				} else {
					errors.add("Cập nhật minh chứng thất bại!");
				}
			} catch (SQLException e) {
				errors.add("Có lỗi xảy ra!");
				e.printStackTrace();
			}
		}
		if (errors.size() == 0) {
			response.sendRedirect("minhchung.jsp");
		} else {
			request.setAttribute("errors", errors);
			request.setAttribute("mc", mc);
			request.getRequestDispatcher("suaminhchung.jsp?command=edit").forward(request, response);
		}
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

	private boolean saveFile(Part p, String folder, MinhChung mc, ServletContext context) {
		if(p == null || folder == null || mc == null || context == null)
			return false;
		String maMC = mc.getID();
		String fileName = p.getSubmittedFileName();
		String fileFolder = UPLOAD_FOLDER + File.separator + folder;
		String absFileFolderPath = context.getRealPath("")+File.separator+fileFolder;
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
			try {
				tapTinDAO.ThemTapTin(maMC, fileFolder+ File.separator + fileName, "PDF");
				return true;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
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
