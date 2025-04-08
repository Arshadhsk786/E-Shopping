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
import com.eshoping.modeal.ContactUs_Details;
@WebServlet("/ContactUsData")
public class ContactUsSubmitt extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String reqType=request.getParameter("regarding");
		int customerId=Integer.parseInt(request.getParameter("custId"));
		String hassel=request.getParameter("hassel");
		LocalDate curentDate=LocalDate.now();
		LocalTime currentTime=LocalTime.now();
		
		ContactUs_Details contactUs_Details=new ContactUs_Details();
		contactUs_Details.setConType(reqType);
		contactUs_Details.setCustId(customerId);
		contactUs_Details.setHassel(hassel);
		contactUs_Details.setCurrentDate(curentDate);
		contactUs_Details.setCurrentTime(currentTime);
		
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		
		String fullUrl= request.getParameter("preUrl");
		String pageName = fullUrl.substring(fullUrl.lastIndexOf("/") + 1);
		CustomerDAO cuDao=new CustomerDAOImpl();
		if(cuDao.ContactUsInsert(contactUs_Details))
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher(pageName);
			dispatcher.include(request, response);
			write.println("<script>alert(`Response Sent To Admin..!`)</script>;");
		}
		else
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher(pageName);
			dispatcher.include(request, response);
			write.println("<script>alert(`Server 404 Error..!`)</script>;");
		}
	}
}
