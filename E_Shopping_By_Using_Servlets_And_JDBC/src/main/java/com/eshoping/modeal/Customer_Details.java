package com.eshoping.modeal;

public class Customer_Details 
{
	private int Id;
	private String Name;
	private long Mobile_Num;
	private String EmailId;
	private String Password;
	private String Gender;
	private String Address;
	
	public Customer_Details() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Customer_Details(int id, String name, long mobile_Num, String emailId, String password, String gender,
			String address) {
		super();
		Id = id;
		Name = name;
		Mobile_Num = mobile_Num;
		EmailId = emailId;
		Password = password;
		Gender = gender;
		Address = address;
	}



	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public long getMobile_Num() {
		return Mobile_Num;
	}

	public void setMobile_Num(long mobile_Num) {
		Mobile_Num = mobile_Num;
	}

	public String getEmailId() {
		return EmailId;
	}

	public void setEmailId(String emailId) {
		EmailId = emailId;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getGender() {
		return Gender;
	}

	public void setGender(String gender) {
		Gender = gender;
	}

	public String getAddress() {
		return Address;
	}

	public void setAddress(String address) {
		Address = address;
	}

	@Override
	public String toString() {
		return "Customer_Details [Id=" + Id + ", Name=" + Name + ", Mobile_Num=" + Mobile_Num + ", EmailId=" + EmailId
				+ ", Password=" + Password + ", Gender=" + Gender + ", Address=" + Address + "]";
	}
	
	
}