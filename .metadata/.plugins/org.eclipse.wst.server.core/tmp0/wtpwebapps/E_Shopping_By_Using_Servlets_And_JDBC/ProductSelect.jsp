<!DOCTYPE html>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="java.util.List"%>
<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@ page session="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="./FooterStyle.css?v=1.1">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #000; /* Black background */
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 10px;
            color: #ffd700;
        }
        .product-detail {
        	margin-left:16%;
        	margin-top:4%;
            background-color: #1a1a1a; /* Dark background for contrast */
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
		border:3px solid #FFD700;
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
            color: #ffd700; /* Gold color for headers */
            margin-bottom: 15px;
            font-weight: bold;
            text-decoration: underline; /* Underline for the title */
            cursor: pointer;
        }

        p {
            font-size: 1rem;
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
            font-weight:bold;
            font-size:20px;
            background-color: #ffd700; /* Gold buttons */
            color: #000; /* Black text for contrast */
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(255, 215, 0, 0.5);
        }

        .button-container input[type="submit"]:hover {
            background-color: #e5c100; /* Slightly darker gold on hover */
            box-shadow: 0 6px 12px rgba(255, 215, 0, 0.5);
            color:#ffd700;
            background-color: #000;
            transform:scale(1.04);
        }

        /* Responsive Design */
        @media (max-width: 568px) {
            .product-detail {
                flex-direction: column;
                align-items: center;
            }

            .product-image {
                flex: 0 0 200px;
                width: 60%;
                height: 250px;
                margin-bottom: 10px;
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
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
<%
// Use session to store product and customer IDs
String productIdParam = request.getParameter("productId");
String customerIdParam = request.getParameter("CustomerId");
Integer productId = (Integer) session.getAttribute("productId");
Integer customerId = (Integer) session.getAttribute("customerId");

try {
    if (productIdParam != null && customerIdParam != null) {
        productId = Integer.parseInt(productIdParam);
        customerId = Integer.parseInt(customerIdParam);
        session.setAttribute("productId", productId);
        session.setAttribute("customerId", customerId);
    }

    if (productId == null || customerId == null) {
        out.print("<p style='color: red;'>Product ID or Customer ID is missing.</p>");
    } else {
        ProductsDAO productsDAO = new ProductDAOimpl();
        List<Product_Details> allpro = productsDAO.getAllProducts();
        Product_Details product = null;
        for (Product_Details details : allpro) {
            if (details.getId() == productId) {
                product = details;
                break;
            }
        }

        if (product == null) {
            out.print("<p style='color: red;'>Product not found.</p>");
        } else {
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
                <form action="AddtoCart">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <input type="hidden" name="CustomerId" value="<%= customerId %>">
                    <input value="<%= request.getRequestURL() %>" hidden="true" name="preUrl"> 
                    <input type="submit" value="Add To Cart">
                </form>

                <form action="CheckOut.jsp">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <input type="hidden" name="CustomerId" value="<%= customerId %>">
                    <input type="submit" value="Buy Now">
                </form>
            </div>
        </div>
    </div>
<%
        }
    }
} catch (NumberFormatException e) {
    out.print("<p style='color: red;'>Invalid Product ID or Customer ID format.</p>");
}
%>

<footer>
    <div class="footer-container">
        <!-- About Section (Vertical at the top) -->
        <div class="footer-about">
            <h4>About Your E-Shop</h4>
            <p>
                Your E-Shop is your go-to destination for quality products and unbeatable deals.
                Explore a wide range of categories, enjoy a seamless shopping experience, and find
                everything you need in one place.
            </p>
        </div>

        <!-- Remaining Sections (Horizontal below the About section) -->
        <div class="footer-remaining">
            <!-- Quick Links Section -->
            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="HomePage.jsp">Home</a></li>
                    <li><a href="ProductsPage.jsp">Shop Products</a></li>
                    <li><a href="ContactUsPage.jsp">Contact Us</a></li>
                    <li><a href="FAQPage.jsp">FAQs</a></li>
                    <li><a href="TermsAndConditions.jsp">Terms & Conditions</a></li>
                </ul>
            </div>

            <!-- Contact Section -->
            <div class="footer-contact">
                <h4>Contact Us</h4>
                <p>Email: <a href="mailto:support@youreshop.com">support@youreshop.com</a></p>
                <p>Phone: +1 234 567 890</p>
                <p>Address: 123 E-Shop Lane, Shopville</p>
            </div>

            <!-- Social Media Links -->
            <div class="footer-social">
                <h4>Follow Us</h4>
                <div class="social-icons">
                    <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i><label id="fb">Facebook</label></a><br>
                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i><label id="twit">Twitter</label></a><br>
                    <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i><label id="insta">Instagram</label></a><br>
                </div>
            </div>
        </div>
    </div>
    <div id="button">
    	<button id="truble" onclick="window.location.href=`ContactUsPage.jsp?CustomerId=<%= customerId%>&preUrl=<%= request.getRequestURL()%>`">Trubble Shoot</button>
    </div>
    <!-- Footer Bottom Section -->
    <div class="footer-bottom">
        <p id="copyMowa">&copy; 2025 Your E-Shop. All Rights Reserved.</p>
    </div>
</footer>

</body>
</html>
