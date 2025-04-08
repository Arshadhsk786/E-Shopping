package com.eshoping.Service;

import java.util.List;

import com.eshoping.DAO.CustomerDAO;
import com.eshoping.DAO.CustomerDAOImpl;
import com.eshoping.modeal.Customer_Details;
import com.shoping.Exception.CustomerException;

public class CustomerServiceImpl implements CustomerService
{
	CustomerDAO customerDAO=new CustomerDAOImpl();
	@Override
	public boolean CustomerRegistration(Customer_Details customer_Details)
	{
		List<Customer_Details> customers=customerDAO.getAllCustomerDetails();
		String email=customer_Details.getEmailId();
		boolean mailMatch =customers.stream().
				anyMatch((customerCheck->customerCheck.getEmailId().equalsIgnoreCase(email)));
		if(mailMatch)
		{
			System.out.println(mailMatch);
			throw new CustomerException("Email id alredy Existed..!");
		}
		long mblnum=customer_Details.getMobile_Num();
		boolean mblMatch =customers.stream().
				anyMatch((customerCheck->customerCheck.getMobile_Num()==customer_Details.getMobile_Num()));
		if(mblMatch)
		{
			throw new CustomerException("Mobile Number alredy Existed..!");
		}
		if(customerDAO.insertCustomerDetails(customer_Details)>0)
			return true;
		else
			return false;
	}
}
