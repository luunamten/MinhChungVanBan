package model;

public class SoMinhChung {
	private TieuChuan tieuChuan;
	private int soMinhChung;
	
	public SoMinhChung() {
		this.tieuChuan = new TieuChuan();
		this.soMinhChung = 0;
	}
	
	public TieuChuan getTieuChuan() {
		return tieuChuan;
	}
	public void setTieuChuan(TieuChuan tieuChuan) {
		this.tieuChuan = tieuChuan;
	}
	public int getSoMinhChung() {
		return soMinhChung;
	}
	public void setSoMinhChung(int soMinhChung) {
		this.soMinhChung = soMinhChung;
	}
	
}
