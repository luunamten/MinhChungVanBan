package model;

public class TapTin {
	private String ID;
	private String maMinhChung;
	private String filePath;
	private String fileType;

	public TapTin() {
		super();
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}
	
	public String getMaMinhChung() {
		return maMinhChung;
	}
	
	public void setMaMinhChung(String maMinhChung) {
		this.maMinhChung = maMinhChung;
	}
	
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

}
