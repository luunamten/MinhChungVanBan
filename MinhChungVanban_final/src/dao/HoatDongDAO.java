package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.HoatDong;

public class HoatDongDAO {
	public HoatDongDAO() {
		
	}
	
	public List<HoatDong> getCacHoatDong() {
		try(Connection con = DBConnect.getConnection();
				Statement cmd = con.createStatement();
				ResultSet res = cmd.executeQuery("select * from hoatdong;")) {
			List<HoatDong> cacHoatDong = new ArrayList<HoatDong>();
			while(res.next()) {
				HoatDong hd = new HoatDong();
				hd.setID(res.getString("mahd"));
				hd.setTenHoatDong(res.getString("tenhd"));
				hd.setMoTa((res.getString("mota")));
				hd.setAnh(res.getString("anhmh"));
				if(hd.getMoTa() == null) {
					hd.setMoTa("");
				}
				cacHoatDong.add(hd);
			}
			return cacHoatDong;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean getHoaDong(HoatDong hd) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall("select * from hoatdong where mahd=?;")) {
			cmd.setString(1, hd.getID());
			try(ResultSet res = cmd.executeQuery()) {
				if(res.next()) {
					hd.setTenHoatDong(res.getString("tenhd"));
					hd.setMoTa(res.getString("mota"));
					hd.setAnh(res.getString("anhmh"));
					if(hd.getAnh() == null) {
						hd.setAnh("");
					}
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean addHoatDong(HoatDong hd) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall("{call sp_addHoatDong(?,?,?,?)}")) {
			cmd.setString(1, hd.getTenHoatDong());
			cmd.setString(2, hd.getMoTa());
			cmd.setString(3, hd.getAnh());
			cmd.registerOutParameter(4, Types.VARCHAR, "$mahd");
			cmd.executeUpdate();
			hd.setID(cmd.getString("$mahd"));
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public int capNhatAnhMinhHoa(HoatDong hd) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall("update hoatdong set anhmh=? where mahd=?")) {
			cmd.setString(1, hd.getAnh());
			cmd.setString(2, hd.getID());
			return cmd.executeUpdate();		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	
	public int suaHoatDong(HoatDong hd) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall(
						"update hoatdong set tenhd=?, mota=?, anhmh=? where mahd=?;")) {
			cmd.setString(1, hd.getTenHoatDong());
			cmd.setString(2, hd.getMoTa());
			cmd.setString(3, hd.getAnh());
			cmd.setString(4, hd.getID());
			return cmd.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean xoaHoatDong(HoatDong hd) {
		try(Connection con = DBConnect.getConnection();
				CallableStatement cmd = con.prepareCall(
						"{call sp_xoaHoatDong(?,?)}")) {
			cmd.setString(1, hd.getID());
			cmd.registerOutParameter(2, Types.VARCHAR, "_anhmh");
			cmd.executeUpdate();
			hd.setAnh(cmd.getString("_anhmh"));
			if(hd.getAnh() == null) {
				hd.setAnh("");
			}
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	public HoatDong getHoatDongbyID(String id) {
		String sql = "select * from hoatdong where mahd = ?";
		try(Connection con = DBConnect.getConnection();
			PreparedStatement ps = con.prepareCall(sql);) {
			ps.setString(1, id);
			ResultSet res = ps.executeQuery();
			HoatDong hd = new HoatDong();
			if(res.next()) {
				hd.setID(res.getString("mahd"));
				hd.setTenHoatDong(res.getString("tenhd"));
				hd.setMoTa((res.getString("mota")));
				hd.setAnh(res.getString("anhmh"));
				if(hd.getMoTa() == null) {
					hd.setMoTa("");
				}
			}
			return hd;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
