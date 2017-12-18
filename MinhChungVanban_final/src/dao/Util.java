package dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.TaiKhoan;

public class Util {
	
	public static String toDMY(String dateString) {
		SimpleDateFormat fmYMD = new SimpleDateFormat("yyyy-mm-dd");
		SimpleDateFormat fmDMY = new SimpleDateFormat("dd-mm-yyyy");
		try {
			Date YMDDate = fmYMD.parse(dateString);
			String res = fmDMY.format(YMDDate);
			if(res != null) {
				return res;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public static String toYMD(String dateString) {
		SimpleDateFormat fmYMD = new SimpleDateFormat("yyyy-mm-dd");
		SimpleDateFormat fmDMY = new SimpleDateFormat("dd-mm-yyyy");
		try {
			Date DMYDate = fmDMY.parse(dateString);
			String res = fmYMD.format(DMYDate);
			if(res != null) {
				return res;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	public static boolean checkLogin(HttpServletRequest request) {
		HttpSession session =  request.getSession(false);
		if(session == null) {
			return false;
		}
		if(session.getAttribute("login") == null) {
			return false;
		}
		return true;
	}
}
