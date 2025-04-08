package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eshoping.DAO.CartDAO;
import com.eshoping.DAO.CartDAOimpl;
import com.eshoping.DAO.CustomerDAO;
import com.eshoping.DAO.CustomerDAOImpl;
import com.eshoping.DAO.ProductDAOimpl;
import com.eshoping.DAO.ProductsDAO;
import com.eshoping.modeal.Customer_Details;
import com.eshoping.modeal.Product_Details;
@WebServlet("/customerLogin")
public class CustomerLogin extends HttpServlet
{
	Customer_Details customer_Details=new Customer_Details();
	CustomerDAO customerDAO=new CustomerDAOImpl();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String email=request.getParameter("customerDetail");
		String pass=request.getParameter("customerPass");
		customer_Details.setEmailId(email);
		customer_Details.setPassword(pass);
		CustomerDAO dao=new CustomerDAOImpl();
		Customer_Details customer=dao.customerLogin(customer_Details);
		ProductsDAO dao2=new ProductDAOimpl();
		List<Product_Details> products=dao2.getAllProducts();
		HttpSession session=request.getSession();
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		if(customer!=null)
		{
			session.setAttribute("loginincludecustomerdetail", customer);
			session.setAttribute("products", products);
			RequestDispatcher dispatcher=request.getRequestDispatcher("AllproductsCustomer.jsp");
			dispatcher.forward(request, response);
		}
		else
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("CustomerLogin.html");
			dispatcher.include(request, response);
			write.println("<center><h1>Invalid Credentials..!</h1></center>");
		}
	}
}
