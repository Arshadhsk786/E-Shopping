package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.CustomerDAO;
import com.eshoping.DAO.CustomerDAOImpl;
import com.eshoping.Service.CustomerService;
import com.eshoping.Service.CustomerServiceImpl;
import com.eshoping.modeal.Customer_Details;
import com.shoping.Exception.CustomerException;
@WebServlet("/customer_registration")
public class CustomerRegistration extends HttpServlet
{
	Customer_Details customer_Details=new Customer_Details();
	CustomerDAO customerDAO= new CustomerDAOImpl();
	CustomerService customerService=new CustomerServiceImpl();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		String name=request.getParameter("CustomerName");
		String emailId=request.getParameter("CustomerEmlid");
		long mobileNum=Long.parseLong(request.getParameter("CustomerMblnum"));
		String password=request.getParameter("CustomerPassword");
		String gender=request.getParameter("CustomerGender");
		String address=request.getParameter("CustomerAddress");
		customer_Details.setName(name);
		customer_Details.setEmailId(emailId);
		customer_Details.setMobile_Num(mobileNum);
		customer_Details.setPassword(password);
		customer_Details.setGender(gender);
		customer_Details.setAddress(address);
		try
		{
			if(customerService.CustomerRegistration(customer_Details))
			{
				RequestDispatcher dispatcher=request.getRequestDispatcher("CustomerLogin.html");
				dispatcher.forward(request, response);
			}
			else
			{
				RequestDispatcher dispatcher=request.getRequestDispatcher("CustomerRegistration.html");
				dispatcher.include(request, response);
				write.println("Invalid Data..!");
			}
		}
		catch(CustomerException e)
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("CustomerRegistration.html");
			dispatcher.include(request, response);
			write.println("<center><h2>"+ e.getMsg()+"</h2></center>");
		}
	}
}
