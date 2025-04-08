package com.eshoping.modeal;

import java.sql.Date;



public class Product_Details 
{
	private int id;
	private String Name;
	private String Brand;
	private double Prise;
	private int Discount;
	private String Category; 
	private int Quantity;
	private String imageurl;
	
	public Product_Details() {
		// TODO Auto-generated constructor stub
	}
	public Product_Details(int id, String name, String brand, double prise, int discount, String category, int quantity,
			String imageurl) {
		super();
		this.id = id;
		Name = name;
		Brand = brand;
		Prise = prise;
		Discount = discount;
		Category = category;
		Quantity = quantity;
		this.imageurl = imageurl;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getBrand() {
		return Brand;
	}
	public void setBrand(String brand) {
		Brand = brand;
	}
	public double getPrise() {
		return Prise;
	}
	public void setPrise(double prise) {
		Prise = prise;
	}
	public int getDiscount() {
		return Discount;
	}
	public void setDiscount(int discount) {
		Discount = discount;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public String getImageurl() {
		return imageurl;
	}
	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}
	@Override
	public String toString() {
		return "Product_Details [id=" + id + ", Name=" + Name + ", Brand=" + Brand + ", Prise=" + Prise + ", Discount="
				+ Discount + ", Category=" + Category + ", Quantity=" + Quantity + ", imageurl=" + imageurl + "]";
	}
	
	
}
