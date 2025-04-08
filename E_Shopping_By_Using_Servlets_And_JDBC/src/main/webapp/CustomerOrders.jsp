<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.eshoping.modeal.Order_Details"%>
<%@page import="com.eshoping.DAO.OrdersDAOimpl"%>
<%@page import="com.eshoping.DAO.OrdersDAO"%>
<%@page import="com.eshoping.modeal.Customer_Details"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Orders</title>
    <link rel="stylesheet" href="css/FooterStyle.css">
</head>
<style>
    /* Table styles */
    .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .order-table th, .order-table td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
        cursor: pointer;
    }

    /* Header style */
    .order-table th {
        background-color: #4CAF50;
        color: white;
        font-size: 16px;
    }

    /* Row styling on hover */
    .order-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .order-table tr:hover {
        background-color: #ddd;
        cursor: pointer;
    }

    img {
        width: 50px;
    }
</style>

<body>
    <% 
        // Java Code: Getting customer details and orders
        Customer_Details customer_Details = (Customer_Details) session.getAttribute("loginincludecustomerdetail");
        OrdersDAO ordersDAO = new OrdersDAOimpl();
        List<Order_Details> orders = ordersDAO.getAllOrders();

        // Filter orders for the specific customer
        List<Order_Details> customerProduct = orders.stream()
            .filter(order -> order.getCustomer_Id() == customer_Details.getId())
            .collect(Collectors.toList());

     // Define a custom order for the statuses
        List<String> statusOrder = Arrays.asList(
            "Order Packed",
            "Dispatched from Hub",
            "Reached to Near Hub",
            "Out For Delivery",
            "Delivered",
            "Cancelled"
        );

        // Sort orders by the defined custom status order
        customerProduct.sort((o1, o2) -> {
            int statusIndex1 = statusOrder.indexOf(o1.getStatus());
            int statusIndex2 = statusOrder.indexOf(o2.getStatus());
            return Integer.compare(statusIndex1, statusIndex2); // Compare by status index
        });
    %>

    <div class="container">
        <h1>Customer Orders</h1>
        <h1><%= "Name: " + customer_Details.getName() %></h1>
        
        <!-- Single table to display all orders -->
        <table class="order-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Image</th>
                    <th>Cost</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Quantity</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Loop through all customer orders and display them in the table
                    for (Order_Details order : customerProduct) { 
                %>
                    <tr>
                        <td><%= order.getOrder_id() %></td>
                        <td><img src="images/<%= order.getImg() %>" alt="Product Image"></td>
                        <td><%= order.getTotal_Purchase_Prise() %></td>
                        <td><%= order.getPurchase_Date() %></td>
                        <td><%= order.getPurchase_Time() %></td>
                        <td><%= order.getPurchase_Quantity() %></td>
                        <td><%= order.getStatus() %></td>
                    </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
