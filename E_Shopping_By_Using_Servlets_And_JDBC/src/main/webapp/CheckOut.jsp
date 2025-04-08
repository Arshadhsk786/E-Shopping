<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@page import="com.eshoping.DAO.CartDAOimpl"%>
<%@page import="com.eshoping.DAO.CartDAO"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@page import="com.eshoping.modeal.Customer_Details"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Customer_Details customer = (Customer_Details) session.getAttribute("loginincludecustomerdetail");
    ProductsDAO productsDAO = new ProductDAOimpl();
    List<Product_Details> allProducts = productsDAO.getAllProducts();
    int proid = Integer.parseInt(request.getParameter("productId"));
    
    Product_Details currentProduct = null;
    for (Product_Details product : allProducts) {
        if (proid == product.getId()) {
            currentProduct = product;
            break;
        }
    }
    session.setAttribute("CurrentProduct", currentProduct);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Details</title>
    <!-- Compact CSS styling -->
    <style>
        /* CSS styles (Black and Golden theme) */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #212121; /* Black background */
            color: #f1c40f; /* Golden text color */
            margin: 0;
            padding: 0;
            font-weight: bold;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 20px;
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
        }

        .product-image {
            max-width: 100%;
            border-radius: 8px;
        }
        img{
        	width:300px;
        	height:400px;
        	border: 5px solid #f1c40f; /* Golden border */
        }

        .product-details {
            background-color: #333333; /* Dark background for product details */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border:3px solid #f1c40f;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            text-align: center;
            color: #f1c40f; /* Golden color for headers */
            cursor: pointer;
        }

        h1:hover {
            color: orange;
            text-decoration: underline;
        }

        .product-details table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .product-details th, .product-details td {
            padding: 10px;
            text-align: left;
        }

        .product-details th {
            background-color: #444444; /* Dark background for headers */
            color: #f1c40f; /* Golden color */
        }

        input[type="text"], input[type="number"], input[type="radio"], input[type="submit"] {
            font-size: 20px;
            padding: 8px;
            width: 100%;
            border: none; /* Removed border */
            background-color: #444444; /* Dark input background */
            color: #f1c40f; /* Golden text */
            border-radius: 8px;
            border:3px solid orange;
            text-align: center;
        }
        #quantityInput{
        	color: black;
        	outline: none;
        }

        .calc-output {
            width: 96%;
            margin: 20px 0;
            background-color: #333333;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: none;
            font-weight: bold;
        }

        .calc-output h2 {
            font-size: 25px;
            margin-bottom: 25px;
            text-align: center;
            cursor: pointer;
            color: #f1c40f; /* Golden color */
        }
        
        .calc-output h2:hover 
        {
            text-align: center;
            color: #f1c40f; /* Golden color for headers */
            text-decoration: underline;
            color: orange;
        }
        .calc-output input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            font-size: 16px;
            background-color: #444444; /* Dark background */
            color: #f1c40f; /* Golden text */
        }

        .calc-output input:disabled {
            background-color: #555555;
        }

        .calc-output input.valid {
            background-color: #e0f7e0;
        }

        .calc-output input.invalid {
            background-color: #ffcccc;
        }

        #paymentMethods {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background-color: #333333;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-family: 'Arial', sans-serif;
            border: 2px solid #f1c40f; /* Golden border */
        }

        #paymentMethods label {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #f1c40f; /* Golden color */
        }

        .payment-options {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 30px;
            margin-top:10px;
        }

        .payment-options input[type="radio"] {
            display: none; /* Hide the default radio button */
        }

        .payment-options label {
            display: flex;
            align-content: center;
            justify-content: flex-start;
            padding: 15px;
            border-radius: 8px;
            background-color: #444444;
            font-size: 18px;
            cursor: pointer;
            color: #f1c40f;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .payment-options label::before {
            content: "";
            width: 20px;
            height: 20px;
            margin-right: 10px;
            border: 2px solid #f1c40f; /* Golden border */
            border-radius: 50%;
            display: inline-block;
            background-color: #333333;
        }

        .payment-options input[type="radio"]:checked+label {
            background-color: #333333;
            border: 3px solid orange;
        }

        .payment-options input[type="radio"]:checked+label::before {
            background-color: orange;
        }

        .payment-options label:hover {
            background-color: #007bff;
            color: white;
        }

        .payment-options input[type="radio"]:disabled+label {
            background-color: #555555;
            color: #888888;
            cursor: not-allowed;
        }

        .payment-options input[type="radio"]:disabled+label::before {
            border-color: #555555;
            background-color: #444444;
        }

        #paymentMethods .submit-button {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #f1c40f; /* Golden background */
            color: black;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
            text-align: center;
        }

        #paymentMethods .submit-button:hover {
            background-color: #e0b90f;
        }

        .confirm-button {
            background-color: #f1c40f; /* Golden color */
            color: black;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        .confirm-button:hover {
            background-color: #e0b90f;
        }

        input.invalid {
            background-color: #ffcccc;
        }

        input.valid {
            background-color: #e0f7e0;
        }
    </style>

    <script>
        function calculateSum() {
            let Qty = parseInt(document.getElementById('quantityInput').value);
            let stock = parseInt(document.getElementById('stockAvailable').value);
            let quantityInput = document.getElementById('quantityInput');
            
            if (Qty <= 0 || isNaN(Qty) || Qty > stock) {
                quantityInput.classList.remove('valid');
                quantityInput.classList.add('invalid');
                document.querySelector('.calc-output').style.display = 'none';
                document.getElementById('paymentMethods').style.display = 'none';
                return;
            }
            
            quantityInput.classList.remove('invalid');
            quantityInput.classList.add('valid');

            let UnitCost = parseFloat(document.getElementById('productPrice').value);
            let Discount = parseFloat(document.getElementById('productDiscount').value);
            
            let TotalCost = UnitCost * Qty;
            let TotalAfterDiscount = TotalCost - (TotalCost * (Discount / 100));
            
            document.getElementById('purchaseQuantity').value = 'Purchase Quantity: ' + Qty;
            document.getElementById('unitCost').value = 'Unit Cost: ' + UnitCost.toFixed(2);
            document.getElementById('discount').value = 'Unit Discount: ' + Discount.toFixed(2);
            document.getElementById('totalCost').value = 'Total Cost: ' + TotalCost.toFixed(2);
            document.getElementById('discountDeduction').value = 'Total Discount: ' + (TotalCost * (Discount / 100)).toFixed(2);
            document.getElementById('totalDiscount').value = 'Payable Ammount: ' + TotalAfterDiscount.toFixed(2);
            document.getElementById('sendQuantity').value = Qty;
            document.getElementById('sendtotalCost').value = TotalAfterDiscount.toFixed(2);
            
            document.querySelector('.calc-output').style.display = 'block';
        }

        function showPaymentMethods() {
            let Qty = parseInt(document.getElementById('quantityInput').value);
            let stock = parseInt(document.getElementById('stockAvailable').value);

            if (Qty > 0 && Qty <= stock) {
                document.getElementById('paymentMethods').style.display = 'block';
            } else {
                alert('Please enter a valid quantity between ' + 1 + ' and ' + stock + '.');
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="product-image">
            <img src="images/<%= currentProduct.getImageurl() %>"
                 alt="<%= currentProduct.getName() %>" class="product-image">
        </div>

        <div class="product-details">
            <h1>Product Details</h1>
            <table>
                <tr>
                    <td><label for="productName">Name</label></td>
                    <td><input type="text" id="productName" value="<%= currentProduct.getName() %>" disabled></td>
                </tr>
                <tr>
                    <td><label for="productBrand">Brand</label></td>
                    <td><input type="text" id="productBrand" value="<%= currentProduct.getBrand() %>" disabled></td>
                </tr>
                <tr>
                    <td><label for="productPrice">Price</label></td>
                    <td><input type="number" id="productPrice" value="<%= currentProduct.getPrise() %>" disabled></td>
                </tr>
                <tr>
                    <td><label for="stockAvailable">Stock Available</label></td>
                    <td><input type="number" id="stockAvailable" value="<%= currentProduct.getQuantity() %>" disabled></td>
                </tr>
                <tr>
                    <td><label for="quantityInput">Enter Quantity</label></td>
                    <td><input type="number" id="quantityInput" placeholder="Enter the Quantity.." name="Quantity" oninput="calculateSum()" required></td>
                </tr>
                <tr>
                    <td><label for="productDiscount">Discount (%)</label></td>
                    <td><input type="number" id="productDiscount" value="<%= currentProduct.getDiscount() %>" disabled></td>
                </tr>
            </table>

            <!-- Calculation Output -->
            <div class="calc-output">
                <h2>Payment Calculation</h2>
                <input type="text" id="purchaseQuantity" disabled><br>
                <input type="text" id="unitCost" disabled><br>
                <input type="text" id="discount" disabled><br>
                <input type="text" id="totalCost" disabled><br>
                <input type="text" id="discountDeduction" disabled><br>
                <input type="text" id="totalDiscount" disabled><br>
            </div>

            <!-- Confirm Purchase Button -->
            <button class="confirm-button" type="button" onclick="showPaymentMethods()">Confirm Purchase</button>

            <!-- Payment Options Section -->
            <div id="paymentMethods">
                <form action="OrderAndPayment">
                    <input value="<%= customer.getId() %>" hidden="true" name="customerID">
                    <input value="<%= currentProduct.getId() %>" hidden="true" name="productID">
                    <input id="sendQuantity" hidden="true" name="purchaseQuantity">
                    <input id="sendtotalCost" hidden="true" name="totalCost">
                    <input id="stockAvailable" value="<%= currentProduct.getQuantity() %>" hidden="true" name="currentQuantity">
                    <label for="paymentMethod">Choose Payment Method:</label><br>
                    <div class="payment-options">
                        <input type="radio" id="upi" name="paymentMethod" value="UPI">
                        <label for="upi">UPI</label>
                        <input type="radio" id="debit" name="paymentMethod" value="Debit">
                        <label for="debit">Debit Card</label>
                        <input type="radio" id="credit" name="paymentMethod" value="Credit">
                        <label for="credit">Credit Card</label>
                        <input type="radio" id="emi" name="paymentMethod" value="EMI">
                        <label for="emi">EMI</label>
                        <input type="radio" id="netbanking" name="paymentMethod" value="Net Banking">
                        <label for="netbanking">Net Banking</label>
                        <input type="radio" id="cod" name="paymentMethod" value="Cash On Delivary">
                        <label for="cod">COD</label>
                        <input type="radio" id="wallet" name="paymentMethod" value="Wallet">
                        <label for="wallet">Wallet</label>
                    </div>
                    <input type="submit" class="submit-button" value="Proceed to Payment">
                </form>
            </div>
        </div>
    </div>
</body>
</html>
