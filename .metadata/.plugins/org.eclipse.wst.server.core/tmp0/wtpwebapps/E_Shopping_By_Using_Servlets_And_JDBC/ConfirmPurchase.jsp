<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="com.eshoping.modeal.Customer_Details"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%Customer_Details customer = (Customer_Details) session.getAttribute("loginincludecustomerdetail");
	Product_Details details=(Product_Details) session.getAttribute("CurrentProduct");
	int Qty=Integer.parseInt(request.getParameter("Quantity"));
	if(Qty>details.getQuantity())
	{%><script type="text/javascript">
		alert(`Select Quantity Less Than <%=details.getQuantity()%>`);
		window.location.href='CheckOut.jsp';
	</script>
		
	<%}
	double TotalCost=Qty*details.getPrise();
	double TotalAfterDisscount=TotalCost-(TotalCost*details.getDiscount()/100);
	%>
	<h2>Product Order Summary</h2>
<form action="ConfirmOrder" method="post">
    <table border="1" cellpadding="10">
        <tr>
            <th>Customer Name</th>
            <td><%= customer.getName() %></td>
        </tr>
        <tr>
            <th>Product Name</th>
            <td><%= details.getName() %></td>
        </tr>
        <tr>
            <th>Quantity</th>
            <td><%= Qty %></td>
        </tr>
        <tr>
            <th>Price per Unit</th>
            <td><%= details.getPrise() %></td>
        </tr>
        <tr>
            <th>Total Cost</th>
            <td><%= TotalCost %></td>
        </tr>
        <tr>
            <th>Discount (%)</th>
            <td><%= details.getDiscount() %></td>
        </tr>
        <tr>
            <th>Total Cost After Discount</th>
            <td><%= TotalAfterDisscount %></td>
        </tr>
    </table>
    <br>
    <input type="hidden" name="TotalCost" value="<%= TotalCost %>">
    <input type="hidden" name="TotalAfterDiscount" value="<%= TotalAfterDisscount %>">
    <input type="submit" value="Confirm Order">
    <input type="reset" value="Cancel">
</form>

</body>
</html>