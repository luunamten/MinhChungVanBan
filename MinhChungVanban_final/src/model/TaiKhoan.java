package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TaiKhoan {
	private String email;
	private String matKhau;
	private int userLevel;
	private String hoTen;
	private boolean nu;
	private String ngaySinh;
	private String diaChi;
	private String noiCongTac;
	private String chucVu;
	private String soDienThoai;
	private String anhDaiDien;

	public TaiKhoan() {
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMatKhau() {
		return matKhau;
	}

	public void setMatKhau(String matKhau) {
		this.matKhau = matKhau;
	}
	
	public int getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}

	public String getHoTen() {
		return hoTen;
	}

	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}

	public boolean isNu() {
		return nu;
	}

	public void setNu(boolean nu) {
		this.nu = nu;
	}
	
	public String getNgaySinh() {
		return ngaySinh;
	}

	public void setNgaySinh(String ngaySinh) {
		this.ngaySinh = ngaySinh;
	}

	public String getDiaChi() {
		return diaChi;
	}

	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}

	public String getNoiCongTac() {
		return noiCongTac;
	}

	public void setNoiCongTac(String noiCongTac) {
		this.noiCongTac = noiCongTac;
	}

	public String getChucVu() {
		return chucVu;
	}

	public void setChucVu(String chucVu) {
		this.chucVu = chucVu;
	}

	public String getSoDienThoai() {
		return soDienThoai;
	}

	public void setSoDienThoai(String soDienThoai) {
		this.soDienThoai = soDienThoai;
	}

	public String getAnhDaiDien() {
		return anhDaiDien;
	}

	public void setAnhDaiDien(String anhDaiDien) {
		this.anhDaiDien = anhDaiDien;
	}
}
