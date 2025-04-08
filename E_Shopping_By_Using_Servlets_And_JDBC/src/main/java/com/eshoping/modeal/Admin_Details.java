package com.eshoping.modeal;


public class Admin_Details 
{
	private int admin_Id;
	private String admin_EmailId;
	private String admin_Password;
	public int getAdmin_Id() {
		return admin_Id;
	}
	public void setAdmin_Id(int admin_Id) {
		this.admin_Id = admin_Id;
	}
	public String getAdmin_EmailId() {
		return admin_EmailId;
	}
	public void setAdmin_EmailId(String admin_EmailId) {
		this.admin_EmailId = admin_EmailId;
	}
	public String getAdmin_Password() {
		return admin_Password;
	}
	public void setAdmin_Password(String admin_Password) {
		this.admin_Password = admin_Password;
	}
	public Admin_Details() {
		// TODO Auto-generated constructor stub
	}
	public Admin_Details(int admin_Id, String admin_EmailId, String admin_Password) {
		super();
		this.admin_Id = admin_Id;
		this.admin_EmailId = admin_EmailId;
		this.admin_Password = admin_Password;
	}
	@Override
	public String toString() {
		return "Admin_Details [admin_Id=" + admin_Id + ", admin_EmailId=" + admin_EmailId + ", admin_Password="
				+ admin_Password + "]";
	}
	
	
}
