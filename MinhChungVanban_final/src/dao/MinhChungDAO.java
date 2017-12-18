package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.MinhChung;
import model.TaiKhoan;

public class MinhChungDAO {


	public ArrayList<MinhChung> getListMinhChung(TaiKhoan account) throws SQLException {
		ArrayList<MinhChung> list = new ArrayList<MinhChung>();
		try(Connection conn = DBConnect.getConnection();) {
			PreparedStatement ps;
			if(account.getUserLevel() == 3) {
				ps = conn.prepareStatement("SELECT * FROM minhchung;");
			} else {
				ps = conn.prepareStatement("select * from minhchung where email = ?;");
				ps.setString(1, account.getEmail());
			}

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				MinhChung mc = new MinhChung();
				mc.setID(rs.getString("MaMC"));
				mc.setTenMinhChung(rs.getString("TenMC"));
				mc.setMaTieuChi(rs.getString("MaTieuChi"));
				mc.setMoTa(rs.getString("MoTa"));
				mc.setSoHieu(rs.getString("SoHieu"));
				mc.setNgayBanhanh(Util.toDMY(rs.getString("NgayBanHanh")));
				mc.setMaNoiBanHanh(rs.getString("MaNBH"));
				mc.setMaHoatDong(rs.getString("MaHD"));
				mc.setEmail(rs.getString("email"));
				mc.setNgayThem(Util.toDMY(rs.getString("NgayThem")));
				list.add(mc);
			}
		}

		return list;
	}

	public ArrayList<MinhChung> searchMinhChung(String keyword, TaiKhoan account) {
		ArrayList<MinhChung> list = new ArrayList<MinhChung>();
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_searchMinhChung(?,?,?)}");) {
			cmd.setString(1, keyword);
			cmd.setString(2, account.getEmail());
			cmd.setInt(3, account.getUserLevel());
			try(ResultSet rs = cmd.executeQuery()) {
				while (rs.next()) {
					MinhChung mc = new MinhChung();
					mc.setID(rs.getString("MaMC"));
					mc.setTenMinhChung(rs.getString("TenMC"));
					mc.setMaTieuChi(rs.getString("MaTieuChi"));
					mc.setMoTa(rs.getString("MoTa"));
					mc.setSoHieu(rs.getString("SoHieu"));
					mc.setNgayBanhanh(Util.toDMY(rs.getString("NgayBanHanh")));
					mc.setMaNoiBanHanh(rs.getString("MaNBH"));
					mc.setMaHoatDong(rs.getString("MaHD"));
					mc.setEmail(rs.getString("email"));
					mc.setNgayThem(Util.toDMY(rs.getString("NgayThem")));
					list.add(mc);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}


	public MinhChung getMinhChungByID(String maMinhChung, TaiKhoan account) throws SQLException {
		String sql = "SELECT * FROM minhchung WHERE MaMC = ? and (email=? or ? = 3);";
		MinhChung mc = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maMinhChung);
			ps.setString(2, account.getEmail());
			ps.setInt(3, account.getUserLevel());
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					mc = new MinhChung();
					mc.setID(rs.getString("MaMC"));
					mc.setTenMinhChung(rs.getString("TenMC"));
					mc.setMaTieuChi(rs.getString("MaTieuChi"));
					mc.setMoTa(rs.getString("MoTa"));
					mc.setSoHieu(rs.getString("SoHieu"));
					mc.setNgayBanhanh(Util.toDMY(rs.getString("NgayBanHanh")));
					mc.setMaNoiBanHanh(rs.getString("MaNBH"));
					mc.setMaHoatDong(rs.getString("MaHD"));
					mc.setEmail(rs.getString("email"));
					mc.setNgayThem(Util.toDMY(rs.getString("NgayThem")));
				}
			}
		}
		return mc;
	}

	public ArrayList<MinhChung> getListMinhChungByName(String name) throws SQLException {
		ArrayList<MinhChung> list = new ArrayList<MinhChung>();
		String sql = "SELECT * FROM minhchungvanban.minhchung WHERE TenMC LIKE concat('%',?,'%')";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, name);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					MinhChung mc = new MinhChung();
					mc.setID(rs.getString("MaMC"));
					mc.setTenMinhChung(rs.getString("TenMC"));
					mc.setMaTieuChi(rs.getString("MaTieuChi"));
					mc.setMoTa(rs.getString("MoTa"));
					mc.setSoHieu(rs.getString("SoHieu"));
					mc.setNgayBanhanh(Util.toDMY(rs.getString("NgayBanHanh")));
					mc.setMaNoiBanHanh(rs.getString("MaNBH"));
					mc.setMaHoatDong(rs.getString("MaHD"));
					mc.setEmail(rs.getString("email"));
					mc.setNgayThem(Util.toDMY(rs.getString("NgayThem")));
					list.add(mc);
				}
			}
		}
		return list;
	}

	public ArrayList<MinhChung> getListMinhChungByMaTieuChi(String maTieuChi) throws SQLException {
		String sql = "SELECT * FROM minhchung WHERE MaTieuChi = ?";
		ArrayList<MinhChung> list = new ArrayList<MinhChung>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maTieuChi);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					MinhChung mc = new MinhChung();
					mc.setID(rs.getString("MaMC"));
					mc.setTenMinhChung(rs.getString("TenMC"));
					mc.setMaTieuChi(rs.getString("MaTieuChi"));
					mc.setMoTa(rs.getString("MoTa"));
					mc.setSoHieu(rs.getString("SoHieu"));
					mc.setNgayBanhanh(Util.toDMY(rs.getString("NgayBanHanh")));
					mc.setMaNoiBanHanh(rs.getString("MaNBH"));
					mc.setMaHoatDong(rs.getString("MaHD"));
					mc.setEmail(rs.getString("email"));
					mc.setNgayThem(Util.toDMY(rs.getString("NgayThem")));
					list.add(mc);
				}
			}
		}
		return list;
	}

	public boolean ThemMinhChung(MinhChung mc) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addMinhChung(?,?,?,?,?,?,?,?,?)}");
				) {
			cmd.setString(1, mc.getMaTieuChi());
			cmd.setString(2, mc.getTenMinhChung());
			cmd.setString(3, mc.getMoTa());
			cmd.setString(4, mc.getSoHieu());
			cmd.setString(5, Util.toYMD(mc.getNgayBanhanh()));
			cmd.setString(6, mc.getMaNoiBanHanh());
			cmd.setString(7, mc.getMaHoatDong());
			cmd.setString(8, mc.getEmail());
			cmd.registerOutParameter(9, Types.VARCHAR, "$MaMC");
			cmd.executeUpdate();
			mc.setID(cmd.getString("$MaMC"));
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int SuaMinhChung(MinhChung mc) throws SQLException {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement("UPDATE minhchung SET MaTieuChi=?,TenMC=?,MoTa=?,SoHieu=?,"
						+ "NgayBanHanh=?,MaNBH=?,MaHD=?, Email=?"
						+ " WHERE MaMC = ?")
				) {
			int numRowAffected = 0;
			ps.setString(1, mc.getMaTieuChi());
			ps.setString(2, mc.getTenMinhChung());
			ps.setString(3, mc.getMoTa());
			ps.setString(4, mc.getSoHieu());
			ps.setString(5,  Util.toYMD(mc.getNgayBanhanh()));
			ps.setString(6, mc.getMaNoiBanHanh());
			ps.setString(7, mc.getMaHoatDong());
			ps.setString(8, mc.getEmail());
			ps.setString(9, mc.getID());
			numRowAffected = ps.executeUpdate();
			return numRowAffected;
		}
	}

	public String XoaMinhChung(String id, TaiKhoan account) throws SQLException {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_xoaMinhChung(?,?,?,?)}")) {
			cmd.setString(1, id);
			cmd.setString(2, account.getEmail());
			cmd.setInt(3, account.getUserLevel());
			cmd.registerOutParameter(4, Types.VARCHAR, "_filepath");
			cmd.executeUpdate();
			return cmd.getString("_filepath");
		}
	}

	public String GetIDMinhChungByMaMinhChung(String maMinhChung) throws SQLException {
		Connection conn = DBConnect.getConnection();
		String sql = "SELECT * FROM minhchung WHERE MaMC = ?";
		PreparedStatement ps = conn.prepareCall(sql);
		ps.setString(1, maMinhChung);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			return rs.getString("maMinhChung");
		}
		return null;
	}

	public List<Integer> GetDSNamDangMinhChungTheoHD(String MaHD) throws SQLException {
		List<Integer> years = new ArrayList<Integer>();
		String sql = "select distinct year(ngaythem) as years FROM minhchung where MaHD = ? order by years desc;";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, MaHD);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					years.add(rs.getInt("years"));
				}
			}
		}
		return years;
	}

	public List<Integer> GetDSThangDangMinhChungTheoHDVaNam(String MaHD, Integer Nam) throws SQLException {
		List<Integer> months = new ArrayList<Integer>();
		String sql = "select distinct month(ngaythem) as months FROM minhchung where MaHD = ? and year(ngaythem) = ? order by months;";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, MaHD);
			ps.setInt(2, Nam);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					months.add(rs.getInt("months"));
				}
			}
		}
		return months;
	}

	public ArrayList<MinhChung> getListMinhChungByHDVaNgayDT(String MaHD, Integer Nam, Integer Thang) throws SQLException {
		String sql = "select * FROM minhchung where MaHD = ? and year(ngaythem) = ? and month(ngaythem) = ?;";
		ArrayList<MinhChung> list = new ArrayList<MinhChung>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, MaHD);
			ps.setInt(2, Nam);
			ps.setInt(3, Thang);

			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					MinhChung mc = new MinhChung();
					mc.setID(rs.getString("MaMC"));
					mc.setTenMinhChung(rs.getString("TenMC"));
					mc.setMaTieuChi(rs.getString("MaTieuChi"));
					mc.setMoTa(rs.getString("MoTa"));
					mc.setSoHieu(rs.getString("SoHieu"));
					mc.setNgayBanhanh(rs.getString("NgayBanHanh"));
					mc.setMaNoiBanHanh(rs.getString("MaNBH"));
					mc.setMaHoatDong(rs.getString("MaHD"));
					mc.setEmail(rs.getString("email"));
					mc.setNgayThem(rs.getString("NgayThem"));
					list.add(mc);
				}
			}
		}
		return list;
	}

}
