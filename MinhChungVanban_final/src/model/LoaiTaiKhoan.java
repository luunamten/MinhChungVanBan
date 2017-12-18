package model;

public class LoaiTaiKhoan {
	private int ID;
	private String tenLoaiTaiKhoan;

	public LoaiTaiKhoan() {
		super();
	}
	
	public int getID() {
		return this.ID;
	}

	public void setID(int ID) {
		this.ID = ID;
	}

	public String getTenLoaiTaiKhoan() {
		return this.tenLoaiTaiKhoan;
	}

	public void setTenLoaiTaiKhoan(String tenLoaiTaiKhoan) {
		this.tenLoaiTaiKhoan = tenLoaiTaiKhoan;
	}

}
