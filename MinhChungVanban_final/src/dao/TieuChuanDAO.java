package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.TieuChuan;

public class TieuChuanDAO {
	public ArrayList<TieuChuan> getListTieuChuan() throws SQLException {
		ArrayList<TieuChuan> list = new ArrayList<TieuChuan>();
		String sql = "SELECT * FROM tieuchuan order by mabtc asc";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TieuChuan tc = new TieuChuan();
					tc.setMaBoTieuChuan(rs.getString("MaBTC"));
					tc.setID(rs.getString("MaTieuChuan"));
					tc.setTenTieuChuan(rs.getString("TenTieuChuan"));
					list.add(tc);
				}
			}
		}
		return list;
	}

	public ArrayList<TieuChuan> getListTieuChuanByBoTieuChuan(String id) throws SQLException {
		String sql = "SELECT * FROM tieuchuan WHERE MaBTC=?";
		ArrayList<TieuChuan> list = new ArrayList<TieuChuan>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, id);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					TieuChuan tc = new TieuChuan();
					tc.setMaBoTieuChuan(rs.getString("MaBTC"));
					tc.setID(rs.getString("MaTieuChuan"));
					tc.setTenTieuChuan(rs.getString("TenTieuChuan"));
					list.add(tc);
				}
			}
		}
		return list;
	}

	public boolean ThemTieuChuan(String maBoTieuChuan, String tenTC){
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addTieuChuan(?,?)}");) {
			cmd.setString(1, maBoTieuChuan);
			cmd.setString(2, tenTC);
			cmd.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public TieuChuan GetTieuChuanByID(String id) throws SQLException {
		TieuChuan tc = new TieuChuan();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall("SELECT * FROM tieuchuan WHERE MaTieuChuan=?");) {
			ps.setString(1, id);	
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					tc.setID(rs.getString("MaTieuChuan"));
					tc.setMaBoTieuChuan(rs.getString("MaBTC"));
					tc.setTenTieuChuan(rs.getString("TenTieuChuan"));
				}
			}
		}
		return tc;
	}

	public int SuaTieuChuan(String maTieuChuan, String maBoTieuChuan, String tenTC) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"UPDATE tieuchuan SET MaBTC=?,TenTieuChuan=? WHERE MaTieuChuan = ?");) {
			ps.setString(1, maBoTieuChuan);
			ps.setString(2, tenTC);
			ps.setString(3, maTieuChuan);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int XoaTieuChuan(String id) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareStatement(
						"DELETE FROM tieuchuan WHERE MaTieuChuan = ?");) {
			ps.setString(1, id);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
