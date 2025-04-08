<%@page import="com.eshoping.modeal.Customer_Details"%>
<%@page import="com.eshoping.DAO.CartDAOimpl"%>
<%@page import="com.eshoping.DAO.CartDAO"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart - Product List</title>
<link rel="stylesheet" href="./FooterStyle.css">
<style>
    body {
        font-family: 'Helvetica Neue', Arial, sans-serif;
        background: black;
        color: #FFD700;
        margin: 0;
        padding: 0;
    }

    .container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        justify-content: center;
        padding: 20px;
    }

    .card {
        width: 300px;
        border: 2px solid #FFD700;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(255, 215, 0, 0.2);
        padding: 15px;
        text-align: center;
        background-color: #1C1C1C;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height: 520px;
    }

    .card:hover {
        box-shadow: 0 6px 16px rgba(255, 215, 0, 0.4);
    }

    .card img {
        width: 66%;
        height: 200px;
        border-radius: 10px;
        border: 3px solid orange;
        background: linear-gradient(45deg, rgba(255, 215, 0, 0.1), rgba(255, 140, 0, 0.2));
    }
    .card img:hover
    {
    	background: linear-gradient(45deg, #FFD700, #FFD700);
    }

    .card h3 {
        font-size: 18px;
        margin: 10px 0;
        color: #E5C100;
    }

    .card p {
        font-size: 14px;
        color: #BDB76B;
    }

    .card .price {
        font-size: 20px;
        color: green;
        font-weight: bold;
    }

    .form-buttons input[type="submit"] {
        padding: 10px 20px;
        font-size: 16px;
        font-weight: bold;
        border: 3px solid orange;
        border-radius: 30px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.3s ease;
        width: 80%;
        color: black;
    }

    .form-buttons form {
        margin-top: 10px;
    }

    .form-buttons input[type="submit"][value="Remove"] {
        background-color: grey;
    }

    .form-buttons input[type="submit"][value="Remove"]:hover {
        background: linear-gradient(45deg, #FF4500, #FF4500);
        transform: scale(1.06);
    }

    .form-buttons input[type="submit"][value="Buy"] {
        background-color: #FFD700;
    }

    .form-buttons input[type="submit"][value="Buy"]:hover {
        background-color: green;
        transform: scale(1.06);
    }

    footer {
        margin-top: 20px;
        color: #FFD700;
    }

    .contact-us:hover {
        text-decoration: underline;
        color: orange;
    }
    a{
    	text-decoration: none;
    }
</style>
</head>
<body>
<% 
    CartDAO cartDAO = new CartDAOimpl();
    Customer_Details customer = (Customer_Details) session.getAttribute("loginincludecustomerdetail");
    List<Product_Details> list = cartDAO.getCart(customer.getId());
%>

<div class="container">
    <% 
        for (Product_Details product : list)  { 
    %><a href="CartProductSelect.jsp?productId=<%= product.getId() %>&CustomerId=<%= customer.getId() %>">
        <div class="card">
            <img src="images/<%= product.getImageurl() %>" alt="<%= product.getName() %>">
            <h3><%= product.getName() %></h3>
            <p class="price">&#8377;<%= product.getPrise() %></p>
            <p><strong>Brand:</strong> <%= product.getBrand() %></p>
            <p><strong>Discount:</strong> <%= product.getDiscount() %>%</p>
            <p><strong>Category:</strong> <%= product.getCategory() %></p>
            <p><strong>Quantity:</strong> <%= product.getQuantity() %></p>

            <div class="form-buttons">
                <form action="cartDelete">
                    <input value="<%= product.getId() %>" hidden="true" name="productId">
                    <input value="<%= customer.getId() %>" hidden="true" name="CustomerId">
                    <input type="submit" value="Remove">
                </form>
                <form action="CheckOut.jsp">
                    <% session.setAttribute("CurrentId", product.getId()); %>
                    <input value="<%= product.getId() %>" hidden="true" name="productId">
                    <input value="<%= customer.getId() %>" hidden="true" name="CustomerId">
                    <input type="submit" value="Buy">
                </form>
            </div>
        </div>
        </a>
    <% 
        }
    %>
</div>
<footer id="footerSection">
  <div class="footer-content">
    <p>&copy; 2025 Your E-Shop. All Rights Reserved.</p>
    <p class="about-eshop">Welcome to Your E-Shop! We offer a wide range of products to suit all your needs. Shop now and experience the best deals and quality products.</p>
    <a href="ContactUsPage.jsp?CustomerId=<%= customer.getId() %>&preUrl=<%= request.getRequestURL() %>" class="contact-us">Contact Us</a>
  </div>
</footer>
</body>
</html>
