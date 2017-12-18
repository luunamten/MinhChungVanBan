package model;

public class TieuChuan {
	private String ID;
	private String maBoTieuChuan;
	private String tenTieuChuan;

	public TieuChuan() {
		super();
	}

	public TieuChuan(String maBoTieuChuan, String maTieuChuan, String tenTieuChuan) {
		super();
		this.ID = maTieuChuan;
		this.maBoTieuChuan = maBoTieuChuan;
		this.tenTieuChuan = tenTieuChuan;
	}

	
	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getMaBoTieuChuan() {
		return maBoTieuChuan;
	}

	public void setMaBoTieuChuan(String maBoTieuChuan) {
		this.maBoTieuChuan = maBoTieuChuan;
	}


	public String getTenTieuChuan() {
		return tenTieuChuan;
	}

	public void setTenTieuChuan(String tenTieuChuan) {
		this.tenTieuChuan = tenTieuChuan;
	}

}
