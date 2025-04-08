package com.eshoping.DAO;

import java.util.List;

import com.eshoping.modeal.ContactUs_Details;
import com.eshoping.modeal.Customer_Details;
import com.eshoping.modeal.Order_Details;
import com.eshoping.modeal.Payment_Details;

public interface CustomerDAO
{
	List<Customer_Details> getAllCustomerDetails();
	int insertCustomerDetails(Customer_Details customer_Details);
	Customer_Details customerLogin(Customer_Details customer_Details);
	boolean PlaceOrder(Order_Details details);
	int paymentStatus(Payment_Details details);
	boolean ContactUsInsert(ContactUs_Details contactUs_Details);
}
