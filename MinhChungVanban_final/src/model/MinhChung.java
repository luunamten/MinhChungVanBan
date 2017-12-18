package model;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class MinhChung {
	private String ID;
	private String maTieuChi;
	private String tenMinhChung;
	private String moTa;
	private String soHieu;
	private String ngayBanhanh;
	private String maNoiBanHanh;
	private String maHoatDong;
	private String email;
	private String ngayThem;

	public MinhChung() {
		this.ID = "";
		this.maTieuChi = "";
		this.tenMinhChung = "";
		this.moTa = "";
		this.soHieu = "";
		this.ngayBanhanh = "";
		this.maNoiBanHanh = "";
		this.maHoatDong = "";
		this.email = "";
		this.ngayThem = "";
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getMaTieuChi() {
		return maTieuChi;
	}

	public void setMaTieuChi(String maTieuChi) {
		this.maTieuChi = maTieuChi;
	}

	public String getTenMinhChung() {
		return tenMinhChung;
	}

	public void setTenMinhChung(String tenMinhChung) {
		this.tenMinhChung = tenMinhChung;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public String getSoHieu() {
		return soHieu;
	}

	public void setSoHieu(String soHieu) {
		this.soHieu = soHieu;
	}

	public String getNgayBanhanh() {
		return ngayBanhanh;
	}

	public void setNgayBanhanh(String ngayBanhanh) {
		this.ngayBanhanh = ngayBanhanh;
	}

	public String getMaNoiBanHanh() {
		return maNoiBanHanh;
	}

	public void setMaNoiBanHanh(String maNoiBanHanh) {
		this.maNoiBanHanh = maNoiBanHanh;
	}

	public String getMaHoatDong() {
		return maHoatDong;
	}

	public void setMaHoatDong(String maHoatDong) {
		this.maHoatDong = maHoatDong;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNgayThem() {
		return ngayThem;
	}

	public void setNgayThem(String ngayThem) {
		this.ngayThem = ngayThem;
	}

	public Date getNgayBanHanh() {
		SimpleDateFormat fomatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Date date = fomatter.parse(this.ngayBanhanh);
			return date;
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
