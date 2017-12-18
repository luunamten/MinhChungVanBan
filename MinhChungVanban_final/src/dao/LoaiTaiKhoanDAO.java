package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.LoaiTaiKhoan;

public class LoaiTaiKhoanDAO {
	public ArrayList<LoaiTaiKhoan> GetListLoaiTaiKhoan() throws SQLException {
		ArrayList<LoaiTaiKhoan> list = new ArrayList<LoaiTaiKhoan>();
		String sql = "SELECT * FROM userlevel";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {

			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					LoaiTaiKhoan ltk = new LoaiTaiKhoan();
					ltk.setID(rs.getInt("userlevel"));
					ltk.setTenLoaiTaiKhoan(rs.getString("name"));
					list.add(ltk);
				}
			}
		}
		return list;
	}

	public LoaiTaiKhoan GetLoaiTaiKhoanByID(int id) throws SQLException {
		String sql = "SELECT * FROM userlevel WHERE userlevel = ?";
		LoaiTaiKhoan ltk = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setInt(1, id);
			try(ResultSet rs = ps.executeQuery();) {
				if (rs.next()) {
					ltk = new LoaiTaiKhoan();
					ltk.setID(rs.getInt("userlevel"));
					ltk.setTenLoaiTaiKhoan(rs.getString("name"));
				}
			}
		}
		return ltk;
	}
}
