package com.eshoping.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;

import com.eshoping.modeal.ContactUs_Details;
import com.eshoping.modeal.Customer_Details;
import com.eshoping.modeal.Order_Details;
import com.eshoping.modeal.Payment_Details;

public class CustomerDAOImpl implements CustomerDAO
{	
	private static final String url="jdbc:mysql://localhost:3306/e_shoping?user=root&password=Root";
	private static final String insert="insert into customer_details(Name, Mobile_Num, EmailId, Gender, Address, Password)"
			+ "values(?,?,?,?,?,?)";
	private static final String select="select * from customer_details";
	private static final String customerLogin="SELECT * FROM customer_details where "
			+ "EmailId=? and Password=?";
	private static final String placeOrder="INSERT INTO order_details (Customer_Id,Product_Id,Payment_Id,Purchase_Quantity,Purchase_Date,Purchase_Time,Total_Purchase_Prise,Status)"
			+ "VALUES (?,?,?,?,?,?,?,?);";
	private static final String orderId="select * from payment_details where Payment_Date=? and Payment_Time=?";
	private static final String paymentConfirm="insert into payment_details(Product_Id,Customer_Id,Amount,Payment_Date,Payment_Time,Payment_Type)"
			+ "values(?,?,?,?,?,?)";
	private static final String ContactPush="insert into contactus (regarding, customerId, customer_hassel, time, date, Status)"
			+ "values(?,?,?,?,?,?)";
	@Override
	public int insertCustomerDetails(Customer_Details customer_Details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(insert);
			pstm.setString(1, customer_Details.getName());
			pstm.setString(3, customer_Details.getEmailId());
			pstm.setLong(2, customer_Details.getMobile_Num());
			pstm.setString(6, customer_Details.getPassword());
			pstm.setString(4, customer_Details.getGender());
			pstm.setString(5, customer_Details.getAddress());
			return pstm.executeUpdate();
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) 
		{
			// TODO Auto-generated catch block
						e.printStackTrace();
//			RequestDispatcher dispath=request.getRequestDispatcher("CustomerRegistration.html");
//			dispath.include(request, response);
//			write.println("<center><h2>You got an Sql Exception</h2></center>");
		}
		return 0;
	}
	@Override
	public List<Customer_Details> getAllCustomerDetails() 
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			List<Customer_Details> list=new ArrayList<Customer_Details>();
			PreparedStatement pstm=con.prepareStatement(select);
			ResultSet res=pstm.executeQuery();
			while(res.next())
			{
				Customer_Details customer_Details=new Customer_Details();
				customer_Details.setId(res.getInt("Id"));
				customer_Details.setName(res.getString("Name"));
				customer_Details.setMobile_Num(res.getLong("Mobile_Num"));
				customer_Details.setEmailId(res.getString("EmailId"));
				customer_Details.setPassword(res.getString("Password"));
				customer_Details.setGender(res.getString("Gender"));
				customer_Details.setAddress(res.getString("Address"));
				list.add(customer_Details);
			}
			return list;
		}
		catch (ClassNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public Customer_Details  customerLogin(Customer_Details customer_Details) 
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(customerLogin);
			pstm.setString(1, customer_Details.getEmailId());
			pstm.setString(2, customer_Details.getPassword());
			Customer_Details customer=new Customer_Details();
			ResultSet res=pstm.executeQuery();
			if(res.isBeforeFirst())
			{
				while (res.next())
				{
					customer.setId(res.getInt("Id"));
					customer.setName(res.getString("Name"));
					customer.setMobile_Num(res.getLong("Mobile_Num"));
					customer.setEmailId(res.getString("EmailId"));
					customer.setPassword(res.getString("Password"));
					customer.setGender(res.getString("Gender"));
					customer.setAddress(res.getString("Address"));
                }
				return customer;
			}
			else
				return null;
		} 
		catch (ClassNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	@Override
	public boolean PlaceOrder(Order_Details details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(placeOrder);
			pstm.setInt(1, details.getCustomer_Id());
			pstm.setInt(2, details.getProduct_Id());
			pstm.setInt(3, details.getPayment_Id());
			pstm.setInt(4, details.getPurchase_Quantity());
			pstm.setDate(5, Date.valueOf(details.getPurchase_Date()));
			pstm.setTime(6, Time.valueOf(details.getPurchase_Time()));
			pstm.setDouble(7, details.getTotal_Purchase_Prise());
			pstm.setString(8, "Being Packed");
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	@Override
	public int paymentStatus(Payment_Details details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(paymentConfirm);
			pstm.setInt(1, details.getProduct_Id());
			pstm.setInt(2, details.getCustomer_Id());
			pstm.setDouble(3, details.getAmount());
			pstm.setDate(4, Date.valueOf(details.getPayment_Date()));
			pstm.setTime(5, Time.valueOf(details.getPayment_Time()));
			pstm.setString(6, details.getPayment_Type());
			if(pstm.executeUpdate()>0)
			{
				PreparedStatement pst=con.prepareStatement(orderId);
				pst.setDate(1, Date.valueOf(details.getPayment_Date()));
				pst.setTime(2, Time.valueOf(details.getPayment_Time()));
				ResultSet res=pst.executeQuery();
				while(res.next())
					return res.getInt("Payment_Id");
			}
			else
				return 0;
		} 
		catch (ClassNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return 0;
	}
	@Override
	public boolean ContactUsInsert(ContactUs_Details contactUs_Details) 
	{
		
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(ContactPush);
			pstm.setString(1, contactUs_Details.getConType());
			pstm.setInt(2, contactUs_Details.getCustId());
			pstm.setString(3, contactUs_Details.getHassel());
			pstm.setDate(5,Date.valueOf(contactUs_Details.getCurrentDate()));
			pstm.setTime(4,Time.valueOf(contactUs_Details.getCurrentTime()));
			pstm.setString(6, "Pending");
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		}
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}
