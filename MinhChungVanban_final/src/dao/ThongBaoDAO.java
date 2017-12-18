package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.TaiKhoan;
import model.ThongBao;

public class ThongBaoDAO {
	public ArrayList<ThongBao> GetListThongBao() throws SQLException {
		ArrayList<ThongBao> list = new ArrayList<ThongBao>();
		String sql = "SELECT * FROM thongbao order by ThGianDangTai desc limit 6;";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					ThongBao tb = new ThongBao();
					tb.setID(rs.getString("MaTB"));
					tb.setTieuDe(rs.getString("TieuDeTB"));
					tb.setNoiDung(rs.getString("NoiDungTB"));
					tb.setThoiGianDang(Util.toDMY(rs.getString("ThGianDangTai")));
					list.add(tb);
				}
			}
		}
		return list;
	}

	public boolean ThemThongBao(String tieuDe, String noiDung, TaiKhoan account) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addThongBao(?,?,?)}");) {
			cmd.setString(1, tieuDe);
			cmd.setString(2, noiDung);
			cmd.setString(3, account.getEmail());
			cmd.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int SuaThongBao(String id, String tieuDe, String noiDung) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"UPDATE thongbao SET TieuDeTB=?,NoiDungTB=? WHERE matb = ?");) {
			ps.setString(1, tieuDe);
			ps.setString(2, noiDung);
			ps.setString(3, id);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int XoaThongBao(String id) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"DELETE FROM thongbao WHERE matb = ?");) {
			ps.setString(1, id);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public ThongBao GetThongBaoByID(String maThongBao) throws SQLException {
		ThongBao tb = null;
		String sql = "SELECT * FROM thongbao WHERE matb = ?";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maThongBao);
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					tb = new ThongBao();
					tb.setID(rs.getString("matb"));
					tb.setTieuDe(rs.getString("TieuDeTB"));
					tb.setNoiDung(rs.getString("NoiDungTB"));
					tb.setThoiGianDang(Util.toDMY(rs.getString("ThGianDangTai")));
					tb.setEmail(rs.getString("Email"));
				}
			}
		}
		return tb;
	}
}
