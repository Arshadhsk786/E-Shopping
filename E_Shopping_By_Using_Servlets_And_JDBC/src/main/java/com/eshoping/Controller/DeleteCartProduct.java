package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.CartDAO;
import com.eshoping.DAO.CartDAOimpl;
import com.eshoping.modeal.Cart_Details;
@WebServlet("/cartDelete")
public class DeleteCartProduct extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int proid=Integer.parseInt(request.getParameter("productId"));
		int custid=Integer.parseInt(request.getParameter("CustomerId"));
		Cart_Details cart_Details=new Cart_Details();
		cart_Details.setProduct_Id(proid);
		cart_Details.setCustomer_Id(custid);
		CartDAO cartDAO=new CartDAOimpl();
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		if(cartDAO.deleteFRomCart(cart_Details))
		{
			write.println("<script>alert(`product Removed Successfully`);"
					+ "window.location.href=`CurrentCart.jsp`</script>");
		}
		else
		{
			write.println("<script>alert(`Server 404 Error`);"
					+ "window.location.href=`CurrentCart.jsp`</script>");
		}
	}
}
