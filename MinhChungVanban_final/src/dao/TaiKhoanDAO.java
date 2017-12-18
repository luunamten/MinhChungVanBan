package dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import model.TaiKhoan;

public class TaiKhoanDAO {

	public boolean login(TaiKhoan account) throws SQLException {
		String sql = "SELECT * FROM taikhoan WHERE Email = ? AND ((MatKhau = ?) OR (MatKhau = ?))";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, account.getEmail());
			ps.setString(2, getMD5(account.getMatKhau()));
			ps.setString(3, account.getMatKhau());
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					account.setHoTen(rs.getString("HoTen"));
					account.setAnhDaiDien(rs.getString("AnhDaiDien"));
					account.setChucVu(rs.getString("ChucVu"));
					account.setDiaChi(rs.getString("DiaChi"));
					account.setNgaySinh(Util.toDMY(rs.getString("NgaySinh")));
					account.setNoiCongTac(rs.getString("NoiCongTac"));
					account.setNu(rs.getBoolean("nu"));
					account.setSoDienThoai(rs.getString("SoDT"));
					account.setUserLevel(rs.getInt("UserLevel"));
					return true;
				}
			}
			return false;
		}
	}

	public ArrayList<TaiKhoan> getListTaiKhoan() throws SQLException {
		String sql = "SELECT * FROM taikhoan";
		ArrayList<TaiKhoan> list = new ArrayList<TaiKhoan>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TaiKhoan tk = new TaiKhoan();
					tk.setEmail(rs.getString("Email"));
					tk.setMatKhau(rs.getString("MatKhau"));
					tk.setHoTen(rs.getString("HoTen"));
					tk.setUserLevel(rs.getInt("userlevel"));
					tk.setNu(rs.getInt("Nu") != 0);

					tk.setNgaySinh(Util.toDMY(rs.getString("NgaySinh")));
					tk.setDiaChi(rs.getString("DiaChi"));
					tk.setNoiCongTac(rs.getString("NoiCongTac"));
					tk.setChucVu(rs.getString("ChucVu"));
					tk.setSoDienThoai(rs.getString("SoDT"));
					tk.setAnhDaiDien(rs.getString("AnhDaiDien"));
					list.add(tk);
				}
			}
			return list;
		}
	}

	public ArrayList<TaiKhoan> getListTaiKhoanAreContact() throws SQLException {
		String sql = "SELECT * FROM taikhoan WHERE userlevel = 2";
		ArrayList<TaiKhoan> list = new ArrayList<TaiKhoan>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TaiKhoan tk = new TaiKhoan();
					tk.setEmail(rs.getString("Email"));
					tk.setMatKhau(rs.getString("MatKhau"));
					tk.setHoTen(rs.getString("HoTen"));
					tk.setUserLevel(rs.getInt("userLevel"));
					tk.setNu(rs.getInt("Nu") != 0);
					tk.setNgaySinh(Util.toDMY(rs.getString("NgaySinh")));
					tk.setDiaChi(rs.getString("DiaChi"));
					tk.setNoiCongTac(rs.getString("NoiCongTac"));
					tk.setChucVu(rs.getString("ChucVu"));
					tk.setSoDienThoai(rs.getString("SoDT"));
					tk.setAnhDaiDien(rs.getString("AnhDaiDien"));
					list.add(tk);
				}
			}
		}
		return list;
	}
	public int ThemTaiKhoan(TaiKhoan tk){
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"INSERT INTO taikhoan(Email,MatKhau,HoTen,userLevel,"
								+ "Nu,NgaySinh,DiaChi,NoiCongTac,ChucVu,SoDT,AnhDaiDien)"
								+ " VALUES (?,?,?,?,?,?,?,?,?,?,?)");) {
			ps.setString(1, tk.getEmail());
			ps.setString(2, tk.getMatKhau());
			ps.setString(3, tk.getHoTen());
			ps.setInt(4, tk.getUserLevel());
			ps.setBoolean(5,  tk.isNu());
			ps.setString(6, Util.toYMD(tk.getNgaySinh()));
			ps.setString(7, tk.getDiaChi());
			ps.setString(8, tk.getNoiCongTac());
			ps.setString(9, tk.getChucVu());
			ps.setString(10, tk.getSoDienThoai());
			ps.setString(11, tk.getAnhDaiDien());
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int capNhatAnh(TaiKhoan tk) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall("update taikhoan set anhdaidien=? where email=?")) {
			cmd.setString(1, tk.getAnhDaiDien());
			cmd.setString(2, tk.getEmail());
			return cmd.executeUpdate();		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int suaTaiKhoan(TaiKhoan tk){
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"update taikhoan set HoTen=?,userLevel=?,"
								+ "Nu=?,NgaySinh=?,DiaChi=?,NoiCongTac=?,ChucVu=?,SoDT=?,AnhDaiDien=?"
								+ " where email=?");) {

			ps.setString(1, tk.getHoTen());
			ps.setInt(2, tk.getUserLevel());
			ps.setBoolean(3,  tk.isNu());
			ps.setString(4, Util.toYMD(tk.getNgaySinh()));
			ps.setString(5, tk.getDiaChi());
			ps.setString(6, tk.getNoiCongTac());
			ps.setString(7, tk.getChucVu());
			ps.setString(8, tk.getSoDienThoai());
			ps.setString(9, tk.getAnhDaiDien());
			ps.setString(10, tk.getEmail());
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int userSuaTaiKhoan(TaiKhoan tk){
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"update taikhoan set HoTen=?,"
								+ "Nu=?,NgaySinh=?,DiaChi=?,NoiCongTac=?,ChucVu=?,SoDT=?,AnhDaiDien=?"
								+ " where email=?");) {	
			ps.setString(1, tk.getHoTen());
			ps.setBoolean(2,  tk.isNu());
			ps.setString(3, Util.toYMD(tk.getNgaySinh()));
			ps.setString(4, tk.getDiaChi());
			ps.setString(5, tk.getNoiCongTac());
			ps.setString(6, tk.getChucVu());
			ps.setString(7, tk.getSoDienThoai());
			ps.setString(8, tk.getAnhDaiDien());
			ps.setString(9, tk.getEmail());
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public TaiKhoan GetTaiKhoanByID(String email) throws SQLException {
		TaiKhoan tk = null;
		String sql = "SELECT * FROM taikhoan WHERE email = ?";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, email);
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					tk = new TaiKhoan();
					tk.setEmail(rs.getString("Email"));
					tk.setMatKhau(rs.getString("MatKhau"));
					tk.setHoTen(rs.getString("HoTen"));
					tk.setUserLevel(rs.getInt("userlevel"));
					tk.setNu(rs.getInt("Nu") != 0);
					tk.setNgaySinh(Util.toDMY(rs.getString("NgaySinh")));
					tk.setDiaChi(rs.getString("DiaChi"));
					tk.setNoiCongTac(rs.getString("NoiCongTac"));
					tk.setChucVu(rs.getString("ChucVu"));
					tk.setSoDienThoai(rs.getString("SoDT"));
					tk.setAnhDaiDien(rs.getString("AnhDaiDien"));
				}
			}
			return tk;
		}
	}

	public TaiKhoan GetTaiKhoanByEmail(String email) throws SQLException {
		String sql = "SELECT * FROM taikhoan WHERE Email = ?";
		TaiKhoan tk = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, email);
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					tk = new TaiKhoan();
					tk.setEmail(rs.getString("Email"));
					tk.setMatKhau(rs.getString("MatKhau"));
					tk.setHoTen(rs.getString("HoTen"));
					tk.setUserLevel(rs.getInt("userlevel"));
					tk.setNu(rs.getInt("Nu") != 0);
					tk.setNgaySinh(Util.toDMY(rs.getString("NgaySinh")));
					tk.setDiaChi(rs.getString("DiaChi"));
					tk.setNoiCongTac(rs.getString("NoiCongTac"));
					tk.setChucVu(rs.getString("ChucVu"));
					tk.setSoDienThoai(rs.getString("SoDT"));
					tk.setAnhDaiDien(rs.getString("AnhDaiDien"));
				}
			}
			return tk;
		}
	}

	public boolean XoaTaiKhoan(TaiKhoan tk) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_xoaTaiKhoan(?,?)}");) {
			cmd.setString(1, tk.getEmail());
			cmd.registerOutParameter(2, Types.VARCHAR, "_avatar");
			cmd.executeUpdate();
			tk.setAnhDaiDien(cmd.getString("_avatar"));
			cmd.executeUpdate();
			if(tk.getAnhDaiDien() == null) {
				tk.setAnhDaiDien("");
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public static String getMD5(String str) {
		byte[] defaultBytes = str.getBytes();
		try {
			MessageDigest algorithm = MessageDigest.getInstance("MD5");
			algorithm.reset();
			algorithm.update(defaultBytes);
			byte messageDigest[] = algorithm.digest();
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < messageDigest.length; i++) {
				String hex = Integer.toHexString(0xFF & messageDigest[i]);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}
			str = hexString + "";
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return str;
	}

	public int changePass(ChangePass cpass) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("update taikhoan set matkhau=? where email=?;")) {
			cmd.setString(1, cpass.getNewPass());
			cmd.setString(2, cpass.getEmail());
			return cmd.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public boolean CapLaiMatKhau(String email, String pass) throws SQLException {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall(
						"{call sp_caplaiMatKhau(?,?,?)}")) {
			cmd.setString(1, email);
			cmd.setString(2, pass);
			cmd.registerOutParameter(3, Types.BOOLEAN, "trangthai");
			cmd.executeUpdate();
			return cmd.getBoolean("trangthai");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
