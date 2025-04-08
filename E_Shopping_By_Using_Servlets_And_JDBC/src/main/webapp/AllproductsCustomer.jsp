<!DOCTYPE html>
<%@page import="com.eshoping.DAO.CartDAOimpl"%>
<%@page import="com.eshoping.DAO.CartDAO"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="java.util.List"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.modeal.Customer_Details"%>
<html>
<head>
<meta charset="UTF-8">
<title>All Product Details</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="./FooterStyle.css?v=1.1">
<style>
body {
	font-family: 'Helvetica Neue', Arial, sans-serif;
	background: black;
	margin: 0;
	padding: 0;
	color: #FFD700; /* Gold text */
}

h1 {
	text-align: center;
	margin-top: 30px;
	font-size: 36px;
	color: #FFD700; /* Gold */
	font-weight: bold;
	cursor: pointer;
}
h1:hover{
	text-decoration: underline;
	color: orange;
}

#OrderDetails {
	height: 45px;
	width: 160px;
	position: absolute;
	right: 20px;
	top: 20px;
	border-radius: 30px;
	font-weight: bold;
	border: 3px solid #FFD700; /* Gold border */
	font-size: 18px;
	background-color: #121212; /* Black */
	color: #FFD700; /* Gold */
	text-transform: uppercase;
	transition: 0.3s;
}

#OrderDetails:hover {
	background: linear-gradient(45deg, #FFD700, #FFD700);
	color: black; /* Black text */
	border: 3px solid orange;
	transform: scale(1.06);
}

.header {
	text-align: center;
	font-size: 22px;
	color: #FFD700; /* Gold */
	margin-top: 30px;
}

.cart-button {
	background-color: #FFD700; /* Gold */
	color: black; /* Black text */
	border: 3px solid orange;
	font-weight: bold;
	font-size: 30px;
	padding: 12px 20px;
	cursor: pointer;
	font-size: 18px;
	border-radius: 30px;
	text-decoration: none;
	position: relative;
	transition: background-color 0.3s ease, transform 0.3s ease;
}

.cart-button sup {
	background-color: black;
	border-radius: 50%;
	color: #FFD700; /* Gold */
	font-size: 14px;
	font-weight: bold;
	padding: 5px 10px;
	position: absolute;
	top: -10px;
	right: -10px;
	border: 3px solid orange;
}

.cart-button:hover {
	background: linear-gradient(45deg, #FFD700, #FFD700);
	color: #121212; /* Black */
	transform: scale(1.05);
}

/* Product grid styling */
.product-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: center;
	padding: 20px;
}

.product-card-wrapper {
	background-color: #1C1C1C; /* Slight light color for card */
	padding: 15px;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(255, 215, 0, 0.2); /* Gold shadow */
	text-align: center;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: 2px solid #FFD700; /* Gold border */
	width: 300px;
	height: 520px;
	/* Flexbox for card content */
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	opacity: 0; /* Initially hidden */
	transform: translateY(20px); /* Start with slight translation */
	cursor: pointer;
}

.product-card-wrapper:hover {
	box-shadow: 0 6px 16px rgba(255, 215, 0, 0.4);
	transform: scale(1.03);
}

.product-card-wrapper.visible {
	opacity: 1;
	transform: translateY(0);
}

/* Product image */
.product-card img {
	width: 66%;
	height: 200px;
	object-fit: contain;
	background: linear-gradient(45deg, rgba(255, 215, 0, 0.1), rgba(255, 140, 0, 0.2)); /* Glowing background */
	border-radius: 10px;
	padding: 5px;
	border: 3px solid orange;
}

.product-card img:hover {
	background: linear-gradient(45deg, #FFD700, #FFD700);
}

.product-card h3 {
	font-size: 18px;
	color: #E5C100; /* Lighter Gold for text */
	margin-top: 6px;
	font-weight: 600;
}

.product-card p {
	font-size: 14px;
	color: #BDB76B; /* Light gold */
	margin-bottom: 3px;
}

.product-card .actual-price {
	margin-top: 3%;
	font-size: 20px;
	color: green;
	font-weight: bold;
}

.product-card .discounted-price {
	font-size: 18px;
	color: #FF4500; /* Red for the strike-through price */
	text-decoration: line-through;
}

.form-buttons {
	margin-top: 10px;
	display: flex;
	flex-direction: column;
	gap: 10px;
	justify-content: flex-end;
	flex-grow: 1;
}

.form-buttons input[type="submit"] {
	background-color: #FFD700; /* Gold */
	color: black; /* Black text */
	padding: 6px 10px;
	font-weight: bold;
	font-size: 16px;
	border: 3px solid orange;
	cursor: pointer;
	border-radius: 30px;
	transition: background-color 0.3s ease, transform 0.3s ease;
	width: 80%;
}

.form-buttons input[type="submit"]:hover {
	background: linear-gradient(45deg, #FFD700, #FFD700);
	color: black; /* Black text */
	transform: scale(1.06);
}

#searchContainer {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin: 30px auto;
}

#searchBar {
	width: 300px;
	padding: 10px;
	font-size: 16px;
	border: 2px solid #FFD700; /* Gold border */
	border-radius: 30px;
	outline: none;
	background-color: black; /* Black background */
	color: #FFD700; /* Gold text */
}

#searchBar:focus {
	border-color: orange; /* Gold */
	box-shadow: 0 0 5px rgba(255, 215, 0, 0.5);
}

#buttonSub {
	padding: 10px 20px;
	font-size: 16px;
	background-color: #FFD700; /* Gold */
	color: black; /* Black text */
	border: none;
	border-radius: 30px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.3s ease;
	font-weight: bold;
	font-size: 25px;
	border: 3px solid orange;
}

#buttonSub:hover {
	background: linear-gradient(45deg, #FFD700, #FFD700);
	color: black; /* Black text */
	border: 3px solid orange;
	transform:scale(1.04);
}

a {
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

@media only screen and (max-width: 768px) {
	.product-grid {
		grid-template-columns: repeat(2, 1fr);
	}
	.product-card-wrapper {
		padding: 10px;
	}
	#searchBar {
		width: 80%;
	}
	#buttonSub {
		width: 80%;
	}
}

#NotFound p {
	text-align: center;
	color: #FFD700; /* Gold */
	font-size: 24px;
}

button:disabled {
  background-color: #555555 !important;
  color: #777777 !important;
  border: 3px solid #777777 !important;
  cursor: not-allowed;
}

button:disabled:hover {
  background-color: #555555 !important;
  color: #777777 !important;
  transform: none;
}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const productCards = document.querySelectorAll(".product-card-wrapper");
    productCards.forEach((card, index) => {
        setTimeout(() => {
            card.classList.add("visible"); // Make the card visible with animation
        }, 200 * index); // 200ms delay for each card
    });
});
</script>
</head>
<body>
	<%
Customer_Details customer = (Customer_Details) session.getAttribute("loginincludecustomerdetail");

ProductsDAO productsDAO = new ProductDAOimpl();
List<Product_Details> allProducts = null;

CartDAO cartDAO = new CartDAOimpl();
int cartCount = cartDAO.getCustomerCartCount(customer.getId());
String search = request.getParameter("value");
if (search == null || search.equalsIgnoreCase("all")) {
    allProducts = productsDAO.getAllProducts();
} else {
    allProducts = productsDAO.Applyfilter(search);
}
%>
	<h1>All Product Details</h1>
	<button id="OrderDetails"
		onclick="window.location.href='CustomerOrders.jsp'">My Orders</button>

	<div class="header">
		<%= customer.getName() %><br>
		<button onclick="window.location.href='CurrentCart.jsp'"
			class="cart-button">
			My Cart <sup><%= cartCount %></sup>
		</button>
	</div>

	<form action="AllproductsCustomer.jsp" method="get">
		<div id="searchContainer">
			<input id="searchBar" type="search"
				placeholder="Search by Category, Brand, or Name" name="value"
				autocomplete="off" required> <input id="buttonSub"
				type="submit" value="Search">
		</div>
	</form>

	<div class="product-grid">

		<% 
    if (allProducts != null && !allProducts.isEmpty()) {
        for (Product_Details product : allProducts) {
    %>
		<a href="ProductSelect.jsp?productId=<%= product.getId() %>&CustomerId=<%= customer.getId() %>">
			<div class="product-card-wrapper">
				<div class="product-card">

					<img alt="Product Image" src="images/<%= product.getImageurl() %>">

					<h3><%= product.getName() %></h3>
					<p><strong>Category:</strong> <%= product.getCategory() %></p>
					<p><strong>Brand:</strong> <%= product.getBrand() %></p>
					<p><strong>Discount:</strong> <%= product.getDiscount() %>%</p>

					<div class="actual-price">
						&#8377;<%= (int) Math.floor(product.getPrise() - (product.getPrise() * product.getDiscount() / 100)) %>
					</div>
					<div class="discounted-price">
						<strong>&#8377;<%= product.getPrise() %></strong>
					</div>
					<div class="form-buttons">
						<form action="AddtoCart">
							<input hidden="true" value=<%=request.getRequestURL()%> name="preUrl">
							<input value="<%= product.getId() %>" hidden="true"
								name="productId"> <input value="<%= customer.getId() %>"
								hidden="true" name="CustomerId"> 
							<input type="submit" value="Add To Cart">
						</form>
						<form action="CheckOut.jsp">
							<input value="<%= product.getId() %>" hidden="true"
								name="productId"> <input value="<%= customer.getId() %>"
								hidden="true" name="CustomerId"> 
							<input type="submit" value="Buy">
						</form>
					</div>
				</div>
			</div>
		</a>
		<% 
        }
    } else {	
    %>
		<div id="NotFound">
			<p>No Products Available At This Time</p>
		</div>
		<% 
    }
    %>
	</div>

<link rel="stylesheet" href="./FooterStyle.css?v=1.1">
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
    	<button id="truble" onclick="window.location.href=`ContactUsPage.jsp?CustomerId=<%= customer.getId() %>`;">Contact..?</button>
	</div>
</footer>
</body>
</html>
