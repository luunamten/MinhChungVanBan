package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

import model.TapTin;

public class TapTinDAO {
	public ArrayList<TapTin> GetListTapTin() throws SQLException {
		Connection conn = DBConnect.getConnection();
		String sql = "SELECT * FROM taptin";
		PreparedStatement ps = conn.prepareCall(sql);

		ArrayList<TapTin> list = new ArrayList<TapTin>();
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			TapTin tt = new TapTin();
			tt.setID(rs.getString("mataptin"));
			tt.setMaMinhChung(rs.getString("maMinhChung"));
			tt.setFilePath(rs.getString("FilePath"));
			tt.setFileType(rs.getString("FuleType"));
			list.add(tt);
		}
		return list;
	}

	public ArrayList<TapTin> GetListTapTinByMinhChung(String maMinhChung) throws SQLException {
		Connection conn = DBConnect.getConnection();
		String sql = "SELECT * FROM taptin WHERE maMinhChung = ?";
		PreparedStatement ps = conn.prepareCall(sql);
		ps.setString(1, maMinhChung);
		ArrayList<TapTin> list = new ArrayList<TapTin>();
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			TapTin tt = new TapTin();
			tt.setID(rs.getString("mataptin"));
			tt.setMaMinhChung(rs.getString("maMinhChung"));
			tt.setFilePath(rs.getString("FilePath"));
			tt.setFileType(rs.getString("FileType"));
			list.add(tt);
		}
		return list;
	}

	public TapTin GetTapTinByMinhChung(String maMinhChung) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall("SELECT * FROM taptin WHERE maMinhChung = ?");
				) {
			ps.setString(1, maMinhChung);
			try(ResultSet rs = ps.executeQuery();) {
				TapTin tt = new TapTin();				
				while (rs.next()) {
					tt.setID(rs.getString("mataptin"));
					tt.setMaMinhChung(rs.getString("maMinhChung"));
					tt.setFilePath(rs.getString("FilePath"));
					tt.setFileType(rs.getString("FileType"));
				}
				return tt;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public TapTin GetTapTinByID(String maTapTin) throws SQLException {
		String sql = "SELECT * FROM taptin WHERE mataptin = ?";
		TapTin tt = null;
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, maTapTin);
			try(ResultSet rs = ps.executeQuery();) {
				while (rs.next()) {
					tt = new TapTin();
					tt.setID(rs.getString("mataptin"));
					tt.setMaMinhChung(rs.getString("maMinhChung"));
					tt.setFilePath(rs.getString("FilePath"));
					tt.setFileType(rs.getString("FileType"));

				}
			}
		}
		return tt;
	}

	public void ThemTapTin(String maMinhChung, String filePath, String fileType) throws SQLException {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addTapTin(?,?,?)}");) {
			cmd.setString(1, maMinhChung);
			cmd.setString(2, filePath);
			cmd.setString(3, fileType);
			cmd.executeUpdate();
		}
	}

	public String XoaTapTin(String maTapTin) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_xoaTapTin(?,?)}")) {
			cmd.setString(1, maTapTin);
			cmd.registerOutParameter(2, Types.VARCHAR, "_filepath");
			cmd.executeUpdate();
			return cmd.getString("_filepath");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
