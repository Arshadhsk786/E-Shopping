<%@page import="java.util.List"%>
<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Arial', sans-serif;
	background-color: #000; /* Black background */
	color: #fff; /* White text */
	padding: 10px;
	height: 100vh; /* Full height for proper centering */
	display: flex;
	justify-content: center; /* Horizontal centering */
	align-items: center; /* Vertical centering */
}

.product-detail {
	background-color: #1a1a1a; /* Dark background */
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
	width: 100%;
	max-width: 1000px;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	gap: 20px;
}

.product-image {
	flex: 0 0 400px;
	height: 500px;
	width: 80%;
	border-radius: 50px;
	box-shadow: 0px 0px 100px rgba(255, 215, 0, 0.5); /* Golden glow */
}

.product-image:hover {
	border: 3px solid #FFD700;
	background-color: #303030;
}

.product-info {
	flex: 1;
	margin-left: 20%;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding-right: 20px;
}

h1 {
	font-size: 2rem;
	color: #ffd700; /* Gold color */
	margin-bottom: 15px;
	font-weight: bold;
	text-decoration: underline;
}

p {
	font-size: 1rem;
	color: #ccc;
	margin-bottom: 10px;
}

.price {
	font-size: 1.6rem;
	color: #00ff00;
	font-weight: bold;
	margin-top: 10px;
}

.discount {
	font-size: 1.2rem;
	color: red;
	text-decoration: line-through;
}

.button-container {
	margin-top: 20px;
	margin-left: -60%;
	display: flex;
	gap: 20px;
	justify-content: center;
}

.button-container form {
	width: 40%;
}

.button-container input[type="submit"] {
	width: 100%;
	padding: 15px;
	font-size: 1.2rem;
	border: 4px solid orange;
	border-radius: 30px;
	font-weight: bold;
	font-size: 20px;
	background-color: #ffd700;
	color: #000;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 4px 8px rgba(255, 215, 0, 0.5);
}

.button-container input[type="submit"]:hover {
	background-color: #000;
	color: #ffd700;
	transform: scale(1.04);
	box-shadow: 0 6px 12px rgba(255, 215, 0, 0.5);
}

@media ( max-width : 768px) {
	.product-detail {
		flex-direction: column;
		align-items: center;
	}
	.product-image {
		flex: 0 0 300px;
		max-width: 90%;
		margin-bottom: 20px;
	}
	.product-info {
		margin-left: 0;
		padding-right: 0;
		text-align: center;
	}
	.button-container {
		margin-left: 20px;
		flex-direction: column;
		gap: 10px;
	}
	.button-container form {
		max-width: 300px;
	}
}

@media ( max-width : 480px) {
	h1 {
		font-size: 1.6rem;
	}
	.price {
		font-size: 1.2rem;
	}
	.discount {
		font-size: 1rem;
	}
	.button-container input[type="submit"] {
		font-size: 1.2rem;
	}
}
</style>
</head>
<body>

<%
    String productIdParam = request.getParameter("productId");
    String customerIdParam = request.getParameter("CustomerId");
    int productId = 0;
    int customerId = 0;
    if (productIdParam == null || customerIdParam == null) {
        out.print("<p style='color: red;'>Product ID or Customer ID is missing.</p>");
    } else {
        productId = Integer.parseInt(productIdParam);
        customerId = Integer.parseInt(customerIdParam);
    }

    ProductsDAO productsDAO = new ProductDAOimpl();
    List<Product_Details> allpro = productsDAO.getAllProducts();
    Product_Details product = null;
    for (Product_Details details : allpro) {
        if (details.getId() == productId) {
            product = details;
            break;
        }
    }
%>

<% if (product != null) { %>
    <div class="product-detail">
        <img class="product-image" src="images/<%= product.getImageurl() %>" alt="Product Image">

        <div class="product-info">
            <h1><%= product.getName() %></h1>
            <p><strong>Category:</strong> <%= product.getCategory() %></p>
            <p><strong>Brand:</strong> <%= product.getBrand() %></p>
            <p><strong>Price:</strong> &#8377;<%= product.getPrise() %></p>
            <p><strong>Discount:</strong> <%= product.getDiscount() %>%</p>

            <div class="price">
                &#8377;<%= (int) Math.floor(product.getPrise() - (product.getPrise() * product.getDiscount() / 100)) %>
            </div>
            <div class="discount">
                <strong>&#8377;<%= product.getPrise() %></strong>
            </div>

            <div class="button-container">
                <form action="cartDelete">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <input type="hidden" name="CustomerId" value="<%= customerId %>">
                    <input type="submit" value="Remove">
                </form>

                <form action="CheckOut.jsp">
                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                    <input type="hidden" name="CustomerId" value="<%= customerId %>">
                    <input type="submit" value="Buy">
                </form>
            </div>
        </div>
    </div>
<% } else { %>
    <p style="color: red;">Product not found.</p>
<% } %>

</body>
</html>
