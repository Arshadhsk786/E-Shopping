package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.OrdersDAO;
import com.eshoping.DAO.OrdersDAOimpl;
import com.eshoping.modeal.Order_Details;
@WebServlet("/cancelOrder")
public class CanceOrder extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int orderId=Integer.parseInt(request.getParameter("orderId"));
		String status=request.getParameter("status");
		
		Order_Details details=new Order_Details();
		details.setOrder_id(orderId);
		details.setStatus(status);
		
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		
		OrdersDAO dao=new OrdersDAOimpl();
		if(dao.UpdateOrderStatus(details))
		{
			write.println("<script>alert(`product Cancelled Successfully`);"
					+ "window.location.href=`GetOrderDetails.jsp`</script>");
		}
		else
		{
			write.println("<script>alert(`Server 404 Erorr..!`);"
					+ "window.location.href=`GetOrderDetails.jsp`</script>");
		}
	}
}
