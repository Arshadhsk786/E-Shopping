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
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 10px;
        }

        .product-detail {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
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
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .product-info {
            flex: 1;
            margin-left:20%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding-right: 20px;
        }

        h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 15px;
            font-weight: bold;
        }

        h2 {
            font-size: 1.5rem;
            color: #555;
            margin-bottom: 15px;
            font-weight: bold;
        }

        p {
            font-size: 1rem;
            color: #777;
            margin-bottom: 10px;
        }

        .price {
            font-size: 1.6rem;
            color: green;
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
            margin-left:-60%;
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .button-container form {
            width: 100%;
            max-width: 200px;
        }

        .button-container input[type="submit"] {
            width: 100%;
            padding: 15px;
            font-size: 1.2rem;
            border: none;
            border-radius: 30px;
            background-color: #27ae60;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-container input[type="submit"]:hover {
            background-color: #2ecc71;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
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
            	margin-left:20px;
                flex-direction: column;
                gap: 10px;
            }

            .button-container form {
                max-width: 300px;
            }

            h1 {
                font-size: 1.8rem;
            }

            .price {
                font-size: 1.4rem;
            }

            .discount {
                font-size: 1.1rem;
            }
        }

        /* Further adjustments for very small devices */
        @media (max-width: 480px) {
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
                font-size: 1rem;
            }
        }
    </style>
</head>
<script>
    // JavaScript function for confirming delete action
    function confirmDelete() {
        var userConfirmed = confirm("Are you sure you want to Cancel this order?");
        return userConfirmed; // If the user clicks "OK", it returns true, which will allow the form submission.
        // If the user clicks "Cancel", it returns false, preventing the form submission.
    }
</script>
<body>

<%
    // Get the product ID from the query parameter
    String productIdParam = request.getParameter("productId");
    int productId=0;
    if (productIdParam == null) {
        out.print("<p style='color: red;'>Product ID or Customer ID is missing.</p>");
    } else {
        productId = Integer.parseInt(productIdParam);
        
        // Proceed with fetching product details
    }
        ProductsDAO productsDAO = new ProductDAOimpl();
        List<Product_Details> allpro = productsDAO.getAllProducts();
        Product_Details product = null;
        for (Product_Details details : allpro) 
        {
            if (details.getId() == productId)
                product = details;
        }
        %>
            <div class="product-detail">
                <!-- Product Image -->
                <img class="product-image" src="images/<%= product.getImageurl() %>" alt="Product Image">

                <!-- Product Info -->
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

                    <!-- Buttons -->
                    
                    <div class="button-container">
                        <form action="Updateproduct.jsp">
                            <input type="hidden" name="productId" value="<%= product.getId() %>"> 
                            <input type="submit" value="Update">
                        </form>

                        <form action="deleteProduct" onsubmit="return confirmDelete()">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <input type="submit" value=Delete>
                        </form>
                    </div>
                </div>
            </div>
</body>
</html>
