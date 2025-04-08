package com.eshoping.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eshoping.DAO.ProductDAOimpl;
import com.eshoping.DAO.ProductsDAO;
import com.eshoping.modeal.Product_Details;
@WebServlet("/deleteProduct")
public class DeleteProduct extends HttpServlet
{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		int id=Integer.parseInt(request.getParameter("productId"));
		ProductsDAO dao=new ProductDAOimpl();
		Product_Details details=new Product_Details();
		details.setId(id);
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		if(dao.deleteProduct(details))
		{
			write.println("<script>alert(`product Deleted Successfully`);"
					+ "window.location.href=`AllProductsDetails.jsp`</script>");
		}
		else
		{
			write.println("<script>alert(`product Not Deleted`);"
					+ "window.location.href=`AllProductsDetails.jsp`</script>"); 
		}
	}
}
