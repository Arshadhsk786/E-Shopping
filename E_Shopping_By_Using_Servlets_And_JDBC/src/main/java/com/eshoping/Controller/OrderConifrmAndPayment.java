package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.CustomerDAO;
import com.eshoping.DAO.CustomerDAOImpl;
import com.eshoping.DAO.ProductDAOimpl;
import com.eshoping.DAO.ProductsDAO;
import com.eshoping.modeal.Order_Details;
import com.eshoping.modeal.Payment_Details;
import com.eshoping.modeal.Product_Details;
@WebServlet("/OrderAndPayment")
public class OrderConifrmAndPayment extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int customerId=Integer.parseInt(request.getParameter("customerID"));
		int productId=Integer.parseInt(request.getParameter("productID"));
		double purchase=Double.parseDouble(request.getParameter("totalCost"));
		LocalDate currentDate = LocalDate.now();
		LocalTime cuLocalTime=LocalTime.now();
		int Quantity=Integer.parseInt(request.getParameter("purchaseQuantity"));
		String method=request.getParameter("paymentMethod");
		
		Payment_Details paymentdetails=new Payment_Details();
		paymentdetails.setCustomer_Id(customerId);
		paymentdetails.setProduct_Id(productId);
		paymentdetails.setAmount(purchase);
		paymentdetails.setPayment_Type(method);
		paymentdetails.setPayment_Date(currentDate);
		paymentdetails.setPayment_Time(cuLocalTime);
		
		CustomerDAO customerDAO=new CustomerDAOImpl();
		
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		
		int paymentId=customerDAO.paymentStatus(paymentdetails);
		System.out.println("paymentId: "+paymentId);
		if(paymentId!=0)
		{
			Order_Details orderdetails=new Order_Details();
			orderdetails.setCustomer_Id(customerId);
			orderdetails.setProduct_Id(productId);
			orderdetails.setPayment_Id(paymentId);
			orderdetails.setPurchase_Quantity(Quantity);
			orderdetails.setPurchase_Date(currentDate);
			orderdetails.setPurchase_Time(cuLocalTime);
			orderdetails.setTotal_Purchase_Prise(purchase);
			if(customerDAO.PlaceOrder(orderdetails))
			{
				int currentQuantity=Integer.parseInt(request.getParameter("currentQuantity"));
				int afterPurchaseQty=currentQuantity-Quantity;
				
				Product_Details productDetails=new Product_Details();
				productDetails.setId(productId);
				productDetails.setQuantity(afterPurchaseQty);
				
				ProductsDAO productsDAO=new ProductDAOimpl();
				if(productsDAO.updateQuantityAfterPayment(productDetails))
				{
					write.println("<script type='text/javascript'>alert('Order Placed..!')</script>");

					 RequestDispatcher dispatcher = request.getRequestDispatcher("AllproductsCustomer.jsp");
				        dispatcher.include(request, response);
				}
				else
				{
					write.println("<script type='text/javascript'>alert('Server 404... Contact Admin If Payment Debited..!')</script>");

					 RequestDispatcher dispatcher = request.getRequestDispatcher("AllproductsCustomer.jsp");
				        dispatcher.include(request, response);
				}
			}
			else
			{
				write.println("<script type='text/javascript'>alert('Server 404... Contact Admin If Payment Debited..!')</script>");

				 RequestDispatcher dispatcher = request.getRequestDispatcher("AllproductsCustomer.jsp");
			        dispatcher.include(request, response);
			}
		}
		else
		{
			write.println("<script type='text/javascript'>alert('Server 404 Error..!')</script>");

			 RequestDispatcher dispatcher = request.getRequestDispatcher("AllproductsCustomer.jsp");
		        dispatcher.include(request, response);
		}
		
		
		
		
	}
}
