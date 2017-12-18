package model;

public class TieuChi {
	private String ID;
	private String maTieuChuan;
	private String tenTieuChi;

	public TieuChi() {
	}

	public TieuChi(String iD, String maTieuChuan, String tenTieuChi) {
		this.ID = iD;
		this.maTieuChuan = maTieuChuan;
		this.tenTieuChi = tenTieuChi;
	}


	public String getMaTieuChuan() {
		return this.maTieuChuan;
	}
	
	public void setMaTieuChuan(String maTieuChuan) {
		this.maTieuChuan = maTieuChuan;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	
	public String getTenTieuChi() {
		return tenTieuChi;
	}

	public void setTenTieuChi(String tenTieuChi) {
		this.tenTieuChi = tenTieuChi;
	}

}
