package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.TieuChi;

public class TieuChiDAO {


	public ArrayList<TieuChi> searchTieuChi(String keyword) {
		ArrayList<TieuChi> tcs = new ArrayList<TieuChi>();
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall(
						"{call sp_searchTieuChi(?)}")) {
			cmd.setString(1, keyword);
			try(ResultSet rs = cmd.executeQuery()) {
				while (rs.next()) {
					TieuChi tc = new TieuChi();
					tc.setMaTieuChuan(rs.getString("MaTieuChuan"));
					tc.setID(rs.getString("MaTieuChi"));
					tc.setTenTieuChi(rs.getString("TenTieuChi"));
					tcs.add(tc);
				}	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return tcs;
	}

	public ArrayList<TieuChi> getListTieuChi() {
		ArrayList<TieuChi> list = new ArrayList<TieuChi>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"SELECT * FROM tieuchi ORDER BY MaTieuChuan");) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TieuChi tc = new TieuChi();
					tc.setMaTieuChuan(rs.getString("MaTieuChuan"));
					tc.setID(rs.getString("MaTieuChi"));
					tc.setTenTieuChi(rs.getString("TenTieuChi"));
					list.add(tc);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<TieuChi> getListTieuChiByTieuChuan(String maTieuChuan) throws SQLException {
		String sql = "SELECT * FROM tieuchi WHERE MaTieuChuan = ?";
		ArrayList<TieuChi> list = new ArrayList<TieuChi>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maTieuChuan);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TieuChi tc = new TieuChi();
					tc.setMaTieuChuan(rs.getString("MaTieuChuan"));
					tc.setID(rs.getString("MaTieuChi"));
					tc.setTenTieuChi(rs.getString("TenTieuChi"));
					list.add(tc);
				}
			}
		}
		return list;
	}

	public boolean ThemTieuChi(String maTieuChuan, String tenTieuChi) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addTieuChi(?,?)}");) {
			cmd.setString(1, maTieuChuan);
			cmd.setString(2, tenTieuChi);
			cmd.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public TieuChi GetTieuChiByID(String maTieuChi) throws SQLException {
		String sql = "SELECT * FROM tieuchi WHERE MaTieuChi = ?";
		TieuChi tc = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maTieuChi);
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					tc = new TieuChi();
					tc.setMaTieuChuan(rs.getString("MaTieuChuan"));
					tc.setID(rs.getString("MaTieuChi"));
					tc.setTenTieuChi(rs.getString("TenTieuChi"));
				}
			}
		}
		return tc;
	}

	public int XoaTieuChi(String maTieuChi) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall(
						"DELETE FROM tieuchi WHERE MaTieuChi = ?");) {
			cmd.setString(1, maTieuChi);
			return cmd.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int SuaTieuChi(TieuChi tch) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall(
						"UPDATE  tieuchi SET MaTieuChuan=?,TenTieuChi=? WHERE MaTieuChi = ?");) {
			cmd.setString(1, tch.getMaTieuChuan());
			cmd.setString(2, tch.getTenTieuChi());
			cmd.setString(3, tch.getID());
			return cmd.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

}
