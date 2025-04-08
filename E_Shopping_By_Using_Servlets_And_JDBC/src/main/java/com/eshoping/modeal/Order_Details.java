package com.eshoping.modeal;

import java.time.LocalDate;
import java.time.LocalTime;

public class Order_Details 
{
	private int Order_id;
	private int Customer_Id;
	private int Product_Id;
	private int Payment_Id;
	private int Purchase_Quantity;
	private LocalDate Purchase_Date;
	private LocalTime Purchase_Time;
	private double Total_Purchase_Prise;
	private String status;
	private String img;
	
	public Order_Details() {
		// TODO Auto-generated constructor stub
	}

	public int getOrder_id() {
		return Order_id;
	}

	public void setOrder_id(int order_id) {
		Order_id = order_id;
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

	public int getPayment_Id() {
		return Payment_Id;
	}

	public void setPayment_Id(int payment_Id) {
		Payment_Id = payment_Id;
	}

	public int getPurchase_Quantity() {
		return Purchase_Quantity;
	}

	public void setPurchase_Quantity(int purchase_Quantity) {
		Purchase_Quantity = purchase_Quantity;
	}

	public LocalDate getPurchase_Date() {
		return Purchase_Date;
	}

	public void setPurchase_Date(LocalDate purchase_Date) {
		Purchase_Date = purchase_Date;
	}

	public LocalTime getPurchase_Time() {
		return Purchase_Time;
	}

	public void setPurchase_Time(LocalTime purchase_Time) {
		Purchase_Time = purchase_Time;
	}

	public double getTotal_Purchase_Prise() {
		return Total_Purchase_Prise;
	}

	public void setTotal_Purchase_Prise(double total_Purchase_Prise) {
		Total_Purchase_Prise = total_Purchase_Prise;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "Order_Details [Order_id=" + Order_id + ", Customer_Id=" + Customer_Id + ", Product_Id=" + Product_Id
				+ ", Payment_Id=" + Payment_Id + ", Purchase_Quantity=" + Purchase_Quantity + ", Purchase_Date="
				+ Purchase_Date + ", Purchase_Time=" + Purchase_Time + ", Total_Purchase_Prise=" + Total_Purchase_Prise
				+ ", status=" + status + ", img=" + img + "]";
	}
	
	
}
