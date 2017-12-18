package dao;

public class ChangePass {
	private String email;
	private String oldPass;
	private String newPass;
	private String reNewPass;
	
	public ChangePass() {
		this.email = "";
		this.oldPass = "";
		this.newPass = "";
		this.reNewPass = "";
	}
	
	public String getOldPass() {
		return oldPass;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setOldPass(String oldPass) {
		this.oldPass = oldPass;
	}
	public String getNewPass() {
		return newPass;
	}
	public void setNewPass(String newPass) {
		this.newPass = newPass;
	}
	public String getReNewPass() {
		return reNewPass;
	}
	public void setReNewPass(String reNewPass) {
		this.reNewPass = reNewPass;
	}
	
}
