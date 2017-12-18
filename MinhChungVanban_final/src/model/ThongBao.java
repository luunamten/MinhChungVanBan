package model;

public class ThongBao {
	private String ID;
	private String tieuDe;
	private String noiDung;
	private String thoiGianDang;
	private String email;
	public ThongBao() {
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getTieuDe() {
		return tieuDe;
	}

	public void setTieuDe(String tieuDe) {
		this.tieuDe = tieuDe;
	}

	public String getNoiDung() {
		return noiDung;
	}

	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}
	
	public String getThoiGianDang() {
		return thoiGianDang;
	}

	public void setThoiGianDang(String thoiGianDang) {
		this.thoiGianDang = thoiGianDang;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
