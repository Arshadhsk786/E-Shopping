package com.eshoping.modeal;


public class Cart_Details 
{
	private int Cart_Id;
	private int Customer_Id;
	private int Product_Id;
	public int getCart_Id() {
		return Cart_Id;
	}
	public void setCart_Id(int cart_Id) {
		Cart_Id = cart_Id;
	}
	public int getCustomer_Id() {
		return Customer_Id;
	}
	public void setCustomer_Id(int customer_Id) {
		Customer_Id = customer_Id;
	}
	public int getProduct_Id() {
		return Product_Id;
	}
	public void setProduct_Id(int product_Id) {
		Product_Id = product_Id;
	}
	public Cart_Details() {
		// TODO Auto-generated constructor stub
	}
	
	public Cart_Details(int cart_Id, int customer_Id, int product_Id) {
		super();
		Cart_Id = cart_Id;
		Customer_Id = customer_Id;
		Product_Id = product_Id;
	}
	@Override
	public String toString() {
		return "Cart_Details [Cart_Id=" + Cart_Id + ", Customer_Id=" + Customer_Id + ", Product_Id=" + Product_Id + "]";
	}
	
	
}
