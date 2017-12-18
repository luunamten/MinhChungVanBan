package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.NoiBanHanh;

public class NoiBanHanhDAO {
	public ArrayList<NoiBanHanh> getListNoiBanHanh() throws SQLException {
		String sql = "SELECT * FROM noibanhanh";
		ArrayList<NoiBanHanh> list = new ArrayList<NoiBanHanh>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					NoiBanHanh nbh = new NoiBanHanh();
					nbh.setMaNoiBanHanh(rs.getString("MaNBH"));
					nbh.setTenNoiBanHanh(rs.getString("TenNBH"));
					list.add(nbh);
				}
			}
		}
		return list;
	}

	public void ThemNoiBanHanh(String tenNoiBanHanh) throws SQLException {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_createNBH(?)}")) {
			cmd.setString(1, tenNoiBanHanh);
			cmd.executeUpdate();
		}
	}

	public void SuaNoiBanHanh(String maNoiBanHanh, String tenNoiBanHanh) throws SQLException {
		String sql = "UPDATE noibanhanh SET TenNBH=? WHERE MaNBH=?";
		try(Connection conn = DBConnect.getConnection();
			PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, tenNoiBanHanh);
			ps.setString(2, maNoiBanHanh);
			ps.executeUpdate();
		}
	}

	public void XoaNoiBanHanh(String maNBH) throws SQLException {
		String sql = "DELETE FROM noibanhanh WHERE MaNBH = ?";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maNBH);
			ps.executeUpdate();
		}
	}

	public NoiBanHanh GetNoiBanHanhByID(String maNBH) throws SQLException {
		String sql = "SELECT * FROM noibanhanh WHERE MaNBH = ?";
		NoiBanHanh nbh = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maNBH);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					nbh = new NoiBanHanh();
					nbh.setMaNoiBanHanh(rs.getString("MaNBH"));
					nbh.setTenNoiBanHanh(rs.getString("TenNBH"));
				}
			}
		}
		return nbh;
	}

}
