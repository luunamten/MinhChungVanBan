package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.BoTieuChuan;
import model.SoMinhChung;
import model.TieuChuan;

public class ThongKeDAO {
	public ArrayList<String> getYears() {
		ArrayList<String> years = new ArrayList<String>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement cmd = conn.prepareStatement(
						"select extract(year from ngaythem) as y from minhchung group by y having y is not null order by y desc;")) {
			try(ResultSet rs = cmd.executeQuery()) {
				while(rs.next()) {
					years.add(rs.getString("y"));
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return years;
	}
	
	public int getNumPerMonth(String year, String month) {
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_soMinhChungThang(?,?)}")) {
			cmd.setString(1, year);
			cmd.setString(2, month);
			try(ResultSet rs = cmd.executeQuery()) {
				if(rs.next()) {
					return rs.getInt("num");
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<BoTieuChuan> getBTCS() {
		ArrayList<BoTieuChuan> btcs = new ArrayList<BoTieuChuan>();
		try(Connection conn = DBConnect.getConnection();
				PreparedStatement cmd = conn.prepareStatement("select * from botieuchuan;")) {
			try(ResultSet rs = cmd.executeQuery()) {
				while(rs.next()) {
					BoTieuChuan btc = new BoTieuChuan();
					btc.setID(rs.getString("mabtc"));
					btc.setMoTa(rs.getString("mota"));
					btc.setTenBoTieuChuan(rs.getString("tenbtc"));
					btcs.add(btc);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return btcs;
	}
	
	public ArrayList<SoMinhChung> getSoMinhChung(BoTieuChuan btc) {
		ArrayList<SoMinhChung> smcs = new ArrayList<SoMinhChung>();
		try(Connection conn = DBConnect.getConnection();
				CallableStatement cmd = conn.prepareCall("{call sp_soMinhChungTrenTC(?)}")) {
			cmd.setString(1, btc.getID());
			try(ResultSet rs = cmd.executeQuery()) {
				while(rs.next()) {
					SoMinhChung smc = new SoMinhChung();
					TieuChuan tc = new TieuChuan();
					tc.setID(rs.getString("mtc"));
					tc.setTenTieuChuan(rs.getString("ttc"));
					smc.setTieuChuan(tc);
					smc.setSoMinhChung(rs.getInt("nummc"));
					smcs.add(smc);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return smcs;
	}
}
