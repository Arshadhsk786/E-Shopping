<%@page import="java.util.List"%>
<%@page import="com.eshoping.modeal.Order_Details"%>
<%@page import="com.eshoping.DAO.OrdersDAOimpl"%>
<%@page import="com.eshoping.DAO.OrdersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update Order Status</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&family=Open+Sans:wght@400;600&display=swap"
	rel="stylesheet">
<style>
/* General container styles */
.container {
	width: 80%;
	margin: 50px auto;
	padding: 30px;
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

/* Title styling */
h1 {
	font-family: 'Open Sans', sans-serif;
	font-size: 30px;
	color: #333;
	text-align: center;
	margin-bottom: 30px;
}

/* Order card container */
.order-card {
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.order-card img {
	max-width: 200px;
	max-height: 200px;
	object-fit: contain;
	border-radius: 8px;
	margin-bottom: 20px;
}

/* Details Section */
.order-details {
	font-family: 'Roboto', sans-serif;
	font-size: 16px;
	color: #333;
	margin: 10px 0;
	text-align: center;
}

/* Dropdown style */
.select-status {
	font-family: 'Roboto', sans-serif;
	padding: 10px;
	font-size: 16px;
	width: 100%;
	border-radius: 5px;
	border: 1px solid #ddd;
	margin-top: 20px;
}

/* Submit Button */
.update-status-btn {
	padding: 12px 30px;
	background-color: #007bff;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	font-size: 16px;
	margin-top: 20px;
}

.update-status-btn:hover {
	background-color: #0056b3;
}

/* Error or Success messages */
.message {
	color: green;
	font-size: 18px;
	margin-top: 20px;
	text-align: center;
}

.error-message {
	color: red;
	font-size: 18px;
	margin-top: 20px;
	text-align: center;
}
</style>
<script>
    // JavaScript function for confirming delete action
    function confirmDelete() {
        var userConfirmed = confirm("Are you sure you want to Cancel this order?");
        return userConfirmed; // If the user clicks "OK", it returns true, which will allow the form submission.
        // If the user clicks "Cancel", it returns false, preventing the form submission.
    }
</script>
</head>
<body>

	<% int ordId=Integer.parseInt(request.getParameter("orderId"));
		OrdersDAO dao=new OrdersDAOimpl();
		Order_Details currentOrder=null;
		List<Order_Details> orders= dao.getAllOrders();
		for(Order_Details order:orders)
		{
			if(ordId==order.getOrder_id())
				currentOrder=order;
		}
%>
	<div class="container">

		<h1>Update Order Status</h1>

		<div class="order-card">
			<!-- Order Image -->
			<img src="images/<%= currentOrder.getImg() %>" alt="Order Image">

			<!-- Order Details -->
			<div class="order-details">
				<strong>Order ID:</strong>
				<%= currentOrder.getOrder_id() %><br> <strong>Customer
					ID:</strong>
				<%= currentOrder.getCustomer_Id() %><br> <strong>Product
					ID:</strong>
				<%= currentOrder.getProduct_Id() %><br> <strong>Payment
					ID:</strong>
				<%= currentOrder.getPayment_Id() %><br> <strong>Quantity:</strong>
				<%= currentOrder.getPurchase_Quantity() %><br> <strong>Purchase
					Date:</strong>
				<%= currentOrder.getPurchase_Date() %><br> <strong>Purchase
					Time:</strong>
				<%= currentOrder.getPurchase_Time() %><br> <strong>Total
					Price:</strong>
				<%= currentOrder.getTotal_Purchase_Prise() %><br> <strong>Status:</strong>
				<%= currentOrder.getStatus() %><br>
			</div>

			<!-- Status Update Dropdown -->
			<form action="updateOrders">
				<input type="hidden" name="orderId" value="<%= currentOrder.getOrder_id() %>"> 
				<select
					name="status" class="select-status">
					<option value="" disabled selected>Select Order Status</option>
					<option value="Order Packed">Order Packed</option>
					<option value="Dispatched From Hub">Dispatched from Hub</option>
					<option value="Reached To NearHub">Reached to Near Hub</option>
					<option value="Out For Delivery">Out For Delivery</option>
					<option value="Delivered">Delivered</option>
				</select>

				<!-- Submit Button -->
				<button type="submit" class="update-status-btn">Update Status</button>
			</form>
			<form action="cancelOrder" onsubmit="return confirmDelete()">
				<input type="hidden" name="orderId" value="<%= currentOrder.getOrder_id() %>"> 
				<input type="hidden" name="status" value="Cancelled"> 
				<button type="submit" class="update-status-btn">Cancel</button>
			</form>


		</div>

	</div>

</body>
</html>
