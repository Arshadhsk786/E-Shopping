<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Products Details</title>
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Roboto', Arial, sans-serif;
    }

    body {
        background-color: #f0f8ff;
        color: #333;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
    }

    h1 {
        font-size: 42px;
        color: #2c3e50;
        margin-bottom: 20px;
        font-weight: bold;
        text-align: center;
    }

    h1:hover {
        text-decoration: underline;
        color: #007bff;
        transition: color 0.3s;
    }

    form {
        display: flex;
        justify-content: center;
        margin-bottom: 30px;
        width: 100%;
        max-width: 600px;
        gap: 10px;
    }

    #searchBar {
        flex: 1;
        padding: 12px 15px;
        font-size: 16px;
        border-radius: 8px;
        border: 1px solid #ccc;
        outline: none;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    #searchBar:focus {
        border-color: #007BFF;
        box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
    }

    #buttonSub {
        padding: 12px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s;
    }

    #buttonSub:hover {
        background-color: #0056b3;
        transform: scale(1.05);
    }

    /* This will make sure to have 4 items per row on all devices */
.product-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4 items per row */
    gap: 20px;
    width: 100%;
    max-width: 1200px;
    margin-top: 30px;
}

    .product-card {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        text-align: center;
        transition: transform 0.2s, box-shadow 0.3s;
    }

    .product-card:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
    }

    .product-card img {
        width: 100%;
        height: auto;
        max-height: 200px;
        object-fit: contain;
        margin-bottom: 15px;
    }

    .product-card h3 {
        font-size: 18px;
        color: #2c3e50;
        margin-bottom: 10px;
    }

    .product-card p {
        font-size: 16px;
        color: #3498db;
        margin-bottom: 10px;
    }

    .product-card .price {
        font-size: 20px;
        color: #e74c3c;
        font-weight: bold;
    }

    .product-card .category {
        font-size: 14px;
        color: #7f8c8d;
        margin-top: 10px;
    }

    .btn-container {
        margin-top: 30px;
        text-align: center;
        display: flex;
        justify-content: center;
        gap: 20px;
    }

    .btn-container button {
        padding: 12px 25px;
        background-color: #e67e22;
        font-size: 18px;
        border-radius: 8px;
        color: white;
        border: none;
        transition: background-color 0.3s, transform 0.2s;
        cursor: pointer;
    }

    .btn-container button:hover {
        background-color: #d35400;
        transform: scale(1.05);
    }

    .product-card .action-btns {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 15px;
    }

    .product-card button {
        padding: 8px 16px;
        background-color: #27ae60;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s;
    }

    .product-card button:hover {
        background-color: #2ecc71;
        transform: scale(1.05);
    }

    @media (max-width: 1024px) {
        .product-grid {
            grid-template-columns: repeat(3, 1fr);
        }
    }

    @media (max-width: 768px) {
        .product-grid {
            grid-template-columns: repeat(2, 1fr);
        }

        form {
            flex-direction: column;
            gap: 15px;
        }

        #searchBar {
            width: 100%;
        }

        #buttonSub {
            width: 100%;
        }

        .btn-container {
            flex-direction: column;
            gap: 15px;
        }
    }

    @media (max-width: 480px) {
        .product-grid {
            grid-template-columns: 3fr;
        }
    }
    </style>
</head>
<body>

<h1>All Products Details</h1>

<!-- Search Form -->
<form action="AllProductsDetails.jsp" method="get">
    <input id="searchBar" type="search" placeholder="Search by Category, Brand, or Name" name="value" autocomplete="off" required>
    <input id="buttonSub" type="submit" value="Search">
</form>

<!-- Add Product Button -->
<div class="btn-container">
    <button onclick="window.location.href='AddProducts.html';">Add Products</button>
</div>

<%
    String search = request.getParameter("value");
    List<Product_Details> list = new ArrayList<Product_Details>();
    ProductsDAO dao = new ProductDAOimpl();

    if (search == null || search.trim().isEmpty() || search.equalsIgnoreCase("all")) {
        list = dao.getAllProducts();
    } else {
        list = dao.Applyfilter(search);
    }

    if (!list.isEmpty()) {
%>
    <!-- Product Grid -->
    <div class="product-grid">
        <%
            for (Product_Details rs : list) {
        %>
            <div class="product-card">
            	<a href="UpdateProductSelect.jsp?productId=<%= rs.getId() %>">
    				<img alt="Product Image" src="images/<%= rs.getImageurl() %>">
			 	</a>
                <h3><%= rs.getName() %></h3>
                <p class="price">&#8377;<%= rs.getPrise() %></p>
                <p class="category"><%= rs.getCategory() %></p>
                <div class="action-btns">
                    <form action="Updateproduct.jsp">
                        <input value="<%= rs.getId() %>" hidden="true" name="productId">
                        <button type="submit">Update</button>
                    </form>
                    <form action="deleteProduct">
                        <input value="<%= rs.getId() %>" hidden="true" name="productId">
                        <button type="submit">Delete</button>
                    </form>
                </div>
            </div>
        <%
            }
        %>
    </div>
<%
    } else {
%>
    <p>No products found.</p>
<%
    }
%>

<!-- Admin Operations Button -->
<div class="btn-container">
    <button onclick="window.location.href='AdminOperations.html';">Admin Operations Page</button>
</div>

</body>
</html>
