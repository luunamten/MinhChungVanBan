package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.BoTieuChuan;

public class BoTieuChuanDAO {

	public ArrayList<BoTieuChuan> searchBoTieuChuan(String keyword) {
		ArrayList<BoTieuChuan> btcs = new ArrayList<BoTieuChuan>();
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall(
						"{call sp_searchBTC(?)}")) {	
			cmd.setString(1, keyword);		
			try(ResultSet rs = cmd.executeQuery()) {
				while(rs.next()) {
					BoTieuChuan btc = new BoTieuChuan();
					btc.setID(rs.getString("mabtc"));
					btc.setTenBoTieuChuan(rs.getString("tenbtc"));
					btc.setMoTa(rs.getString("mota"));
					btcs.add(btc);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return btcs;
	}

	public ArrayList<BoTieuChuan> getListBoTieuChuan() throws SQLException {
		ArrayList<BoTieuChuan> list = new ArrayList<BoTieuChuan>();
		String sql = "SELECT * FROM botieuchuan";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);
				ResultSet rs = ps.executeQuery();) {		
			while (rs.next()) {
				BoTieuChuan btc = new BoTieuChuan();
				btc.setID(rs.getString("MaBTC"));
				btc.setTenBoTieuChuan(rs.getString("TenBTC"));
				btc.setMoTa(rs.getString("MoTa"));
				list.add(btc);
			}
		}
		return list;
	}

	public BoTieuChuan GetBoTieuChuanByID(String id) throws SQLException {
		BoTieuChuan btc = null;
		String sql = "SELECT * FROM botieuchuan WHERE MaBTC=?";
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(sql);) {
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				btc = new BoTieuChuan();
				btc.setID(rs.getString("MaBTC"));
				btc.setTenBoTieuChuan(rs.getString("TenBTC"));
				btc.setMoTa(rs.getString("MoTa"));
			}
		}
		return btc;
	}

	public boolean ThemBoTieuChuan(String tenBoTieuChuan, String moTa)  {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_addBoTieuChuan(?,?)}")){
			cmd.setString(1, tenBoTieuChuan);
			cmd.setString(2, moTa);
			cmd.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public int SuaBoTieuChuan(String maBoTieuChuan, String tenBoTieuChuan, String moTa) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"UPDATE botieuchuan SET TenBTC=?, MoTa=?  WHERE MaBTC = ?")) {
			ps.setString(1, tenBoTieuChuan);
			ps.setString(2, moTa);
			ps.setString(3, maBoTieuChuan);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int XoaBoTieuChuan(String id) {
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement ps = conn.prepareCall(
						"DELETE FROM botieuchuan WHERE mabtc = ?")) {
			ps.setString(1, id);
			return ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
}
