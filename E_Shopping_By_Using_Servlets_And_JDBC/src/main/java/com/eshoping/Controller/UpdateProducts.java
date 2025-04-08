package com.eshoping.Controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.eshoping.DAO.ProductDAOimpl;
import com.eshoping.DAO.ProductsDAO;
import com.eshoping.modeal.Cart_Details;
import com.eshoping.modeal.Product_Details;
@WebServlet("/Updateproduct")
@MultipartConfig
public class UpdateProducts extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int proid=Integer.parseInt(request.getParameter("productId"));
		double prise=Double.parseDouble(request.getParameter("productPrise"));
		int qty=Integer.parseInt(request.getParameter("productQty"));
		int diss=Integer.parseInt(request.getParameter("productDiss"));
		Product_Details details=new Product_Details();
		details.setId(proid);
		details.setPrise(prise);
		details.setQuantity(qty);
		details.setDiscount(diss);
		
		// Handle file upload (product image)
        String uploadPath = "D:\\Advanced_Java_By_Sai_Sir\\E_Shopping_By_Using_Servlets_And_JDBC\\src\\main\\webapp\\images"; // Define where to store images
        String imageFileName = request.getParameter("actualImg"); // Default image if no file is uploaded

        // Get the image file from the form (if any)
        Part filePart = request.getPart("updateImg");  // Retrieve file part from form
        if (filePart != null && filePart.getSize() > 0) {
            // Get the original filename
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // If the file already exists, append a timestamp to make it unique
            String filePath = uploadPath + File.separator + fileName;
            File file = new File(filePath);
            
            if (file.exists()) {
                // File exists, rename the file by appending a timestamp to the file name
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                String baseName = fileName.substring(0, fileName.lastIndexOf("."));
                String newFileName = baseName + "_" + System.currentTimeMillis() + fileExtension;
                filePath = uploadPath + File.separator + newFileName;  // New file path with unique name
                imageFileName = newFileName;  // Update the file name to the new unique name
            } else {
                imageFileName = fileName;  // If file doesn't exist, keep the original file name
            }

            // Ensure the upload directory exists
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();  // Create directory if it doesn't exist
            }

            // Save the uploaded file
            try (InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, Paths.get(filePath));
            }
        }

        // Set the image path (either uploaded or default)
        details.setImageurl(imageFileName);  // Save relative path for the database
        
		PrintWriter write=response.getWriter();
		response.setContentType("text/html");
		ProductsDAO dao=new ProductDAOimpl();
		if(dao.updateproduct(details))
		{
			write.println("<script>alert('Product Updated..!');"
					+ "window.location.href=`AllProductsDetails.jsp`;</script>;");
		}
		else
		{
			write.println("<script>alert('Server 404 Error..!');"
					+ "window.location.href=`AllProductsDetails.jsp`;</script>;");
		}
	}
}
