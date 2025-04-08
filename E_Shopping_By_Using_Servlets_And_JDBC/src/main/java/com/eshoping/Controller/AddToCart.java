package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eshoping.DAO.CartDAO;
import com.eshoping.DAO.CartDAOimpl;
import com.eshoping.modeal.Cart_Details;
@WebServlet("/AddtoCart")
public class AddToCart extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int proId=Integer.parseInt(request.getParameter("productId"));
		int custId=Integer.parseInt(request.getParameter("CustomerId"));
		String fullUrl=request.getParameter("preUrl");
		System.out.println(fullUrl);
		String pageName = fullUrl.substring(fullUrl.lastIndexOf("/") + 1);
		Cart_Details cart_Details=new Cart_Details();
		cart_Details.setCustomer_Id(custId);
		cart_Details.setProduct_Id(proId);
		CartDAO cartDAO=new CartDAOimpl();
		
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		
		if(cartDAO.AddToCart(cart_Details)>0)
		{
			write.println("<script>alert(`product Added To Cart`);window.location.href=`"+pageName+"`;</script>");
		}
		else
		{
			write.println("<script>alert(`Alredy Added to Cart`);window.location.href=`"+pageName+"`;</script>");
		}
	}
}