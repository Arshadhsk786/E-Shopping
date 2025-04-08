<%@page import="java.util.stream.Collectors"%>
<%@page import="com.eshoping.modeal.Order_Details"%>
<%@page import="java.util.List"%>
<%@page import="com.eshoping.DAO.OrdersDAOimpl"%>
<%@page import="com.eshoping.DAO.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer Orders</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
<style>
/* General container styles */
.container {
    width: 85%;
    margin: 20px auto;
    padding: 30px;
    text-align: center;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* Title styling */
h1 {
    font-family: 'Open Sans', sans-serif;
    font-size: 28px;
    color: #333;
    margin-bottom: 30px;
}

/* Grid container for the order display */
.order-wrapper {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 20px;
    margin-top: 30px;
}

/* Individual order card styling */
.order-card {
    display: flex;
    flex-direction: column;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.order-card:hover {
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
    transform: translateY(-5px);
}

.order-card img {
    width: 100%;
    max-height: 150px;
    object-fit: contain;
    border-radius: 8px;
    margin-bottom: 15px;
}

/* Order card details styling */
.order-card div {
    font-family: 'Roboto', sans-serif;
    font-size: 14px;
    color: #333;
    margin: 5px 0;
    text-align: center;
}

.order-card .details {
    font-weight: bold;
    margin-top: 10px;
}

/* Button styling for "Update Status" */
button {
    padding: 8px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    align-self: center;
}

button:hover {
    background-color: #0056b3;
}

/* Styling for empty orders message */
.no-orders-message {
    color: #e74c3c;
    font-size: 18px;
    margin-top: 20px;
}

/* Media query for mobile responsiveness */
@media (max-width: 768px) {
    .order-wrapper {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>

<% 
// Get all orders from the DAO
OrdersDAO ordersDAO = new OrdersDAOimpl();
List<Order_Details> totalOrders = ordersDAO.getAllOrders();

// Default filter is for Delivered Orders
String filterStatus = request.getParameter("filterStatus");
if (filterStatus == null) {
    filterStatus = "Delivered"; // Default filter to Delivered
}

// Make filterStatus effectively final by not reassigning it after initial declaration
final String finalFilterStatus = filterStatus; // Declare a final variable

// Filter the orders based on selected status
List<Order_Details> orders = totalOrders.stream()
    .filter(order -> {
        String status = order.getStatus();
        // Treat "Delivered" and "Cancelled" as their respective statuses
        if ("Delivered".equals(status)) {
            return finalFilterStatus.equals("Delivered");
        } else if ("Cancelled".equals(status)) {
            return finalFilterStatus.equals("Cancelled");
        } else {
            // Treat all other statuses as "Pending"
            return finalFilterStatus.equals("Pending");
        }
    })
    .collect(Collectors.toList());
%>

<div class="container">
    <h1>Customer Orders</h1>

    <!-- Dropdown for selecting order status -->
    <form method="get">
        <label for="filterStatus">Filter Orders by Status:</label>
        <select name="filterStatus" id="filterStatus">
            <option value="Pending" <%= "Pending".equals(finalFilterStatus) ? "selected" : "" %>>Pending Orders</option>
            <option value="Cancelled" <%= "Cancelled".equals(finalFilterStatus) ? "selected" : "" %>>Cancelled Orders</option>
            <option value="Delivered" <%= "Delivered".equals(finalFilterStatus) ? "selected" : "" %>>Delivered Orders</option> <!-- Added Delivered option -->
        </select>
        <button type="submit">Apply Filter</button>
    </form>

    <!-- Order wrapper for all rows -->
    <div class="order-wrapper">
        <% if (orders.isEmpty()) { %>
            <div class="no-orders-message">
                No Orders Available
            </div>
        <% } else { %>
            <!-- Loop through each order and display it in a card format -->
            <% for (Order_Details order : orders) { %>
                <div class="order-card">
                    <!-- Order Image -->
                    <img alt="notFound" src="images/<%= order.getImg() %>">

                    <!-- Order Details -->
                    <div>Order ID: <%= order.getOrder_id() %></div>
                    <div>Customer ID: <%= order.getCustomer_Id() %></div>
                    <div>Product ID: <%= order.getProduct_Id() %></div>
                    <div>Payment ID: <%= order.getPayment_Id() %></div>
                    <div>Quantity: <%= order.getPurchase_Quantity() %></div>
                    <div>Purchase Date: <%= order.getPurchase_Date() %></div>
                    <div>Purchase Time: <%= order.getPurchase_Time() %></div>
                    <div>Total Price: <%= order.getTotal_Purchase_Prise() %></div>
                    <div>Status: <%= order.getStatus() %></div>

                    <!-- Conditionally render "Update Status" Button only for Pending orders -->
                    <% if (!"Delivered".equals(order.getStatus()) && !"Cancelled".equals(order.getStatus())) { %>
                        <form action="ProductStatusUpdate.jsp">
                            <input type="hidden" value="<%= order.getOrder_id() %>" name="orderId">
                            <button type="submit">Update Status</button>
                        </form>
                    <% } %>
                </div>
            <% } %>
        <% } %>
    </div>
</div>

</body>
</html>
