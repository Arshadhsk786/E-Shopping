package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.adminDAO;
import com.eshoping.DAO.adminDAOImpl;
import com.eshoping.modeal.Admin_Details;
@WebServlet("/adminLogin")
public class adminLogin extends HttpServlet
{
	Admin_Details admin_Details=new Admin_Details();
	adminDAO adminDAO=new adminDAOImpl();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String email =request.getParameter("adminEmail");
		String password =request.getParameter("adminPass");
		admin_Details.setAdmin_EmailId(email);
		admin_Details.setAdmin_Password(password);
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		if(adminDAO.adminLoginCheck(admin_Details))
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("AdminOperations.html");
			dispatcher.forward(request, response);
		}
		else
		{
			RequestDispatcher dispatcher=request.getRequestDispatcher("AdminLogin.html");
			dispatcher.include(request, response);
			write.println("<center><h1>Invalid Credentials..!</h1></center>");
		}
	}
}
