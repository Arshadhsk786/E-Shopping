package com.eshoping.modeal;

import java.time.LocalDate;
import java.time.LocalTime;

public class Payment_Details 
{
	private int Payment_Id;
	private int Product_Id;
	private int Customer_Id;
	private double Amount;
	private LocalDate Payment_Date;
	private LocalTime Payment_Time;
	private String Payment_Type;
	
	public Payment_Details() {
		// TODO Auto-generated constructor stub
	}

	public Payment_Details(int payment_Id, int product_Id, int customer_Id, double amount, LocalDate payment_Date,
			LocalTime payment_Time, String payment_Type) {
		super();
		Payment_Id = payment_Id;
		Product_Id = product_Id;
		Customer_Id = customer_Id;
		Amount = amount;
		Payment_Date = payment_Date;
		Payment_Time = payment_Time;
		Payment_Type = payment_Type;
	}

	public int getPayment_Id() {
		return Payment_Id;
	}

	public void setPayment_Id(int payment_Id) {
		Payment_Id = payment_Id;
	}

	public int getProduct_Id() {
		return Product_Id;
	}

	public void setProduct_Id(int product_Id) {
		Product_Id = product_Id;
	}

	public int getCustomer_Id() {
		return Customer_Id;
	}

	public void setCustomer_Id(int customer_Id) {
		Customer_Id = customer_Id;
	}

	public double getAmount() {
		return Amount;
	}

	public void setAmount(double amount) {
		Amount = amount;
	}

	public LocalDate getPayment_Date() {
		return Payment_Date;
	}

	public void setPayment_Date(LocalDate payment_Date) {
		Payment_Date = payment_Date;
	}

	public LocalTime getPayment_Time() {
		return Payment_Time;
	}

	public void setPayment_Time(LocalTime payment_Time) {
		Payment_Time = payment_Time;
	}

	public String getPayment_Type() {
		return Payment_Type;
	}

	public void setPayment_Type(String payment_Type) {
		Payment_Type = payment_Type;
	}

	@Override
	public String toString() {
		return "Payment_Details [Payment_Id=" + Payment_Id + ", Product_Id=" + Product_Id + ", Customer_Id="
				+ Customer_Id + ", Amount=" + Amount + ", Payment_Date=" + Payment_Date + ", Payment_Time="
				+ Payment_Time + ", Payment_Type=" + Payment_Type + "]";
	}
	
	
}
