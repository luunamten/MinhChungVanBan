package model;

public class BoTieuChuan {
	private String ID;
	private String tenBoTieuChuan;
	private String moTa;

	public BoTieuChuan() {
		super();
	}

	public BoTieuChuan(String iD, String tenBoTieuChuan, String moTa) {
		super();
		ID = iD;
		this.tenBoTieuChuan = tenBoTieuChuan;
		this.moTa = moTa;
	}

	

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getTenBoTieuChuan() {
		return tenBoTieuChuan;
	}

	public void setTenBoTieuChuan(String tenBoTieuChuan) {
		this.tenBoTieuChuan = tenBoTieuChuan;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

}
