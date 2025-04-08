<%@page import="java.util.List"%>
<%@page import="com.eshoping.DAO.ProductDAOimpl"%>
<%@page import="com.eshoping.DAO.ProductsDAO"%>
<%@page import="com.eshoping.modeal.Product_Details"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Product</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #333;
        margin-top: 30px;
    }

    table {
        width: 60%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 12px;
        text-align: left;
        font-size: 16px;
        border-bottom: 1px solid #ddd;
    }

    td input, td select {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    td input[type="file"] {
        padding: 5px;
    }

    td img {
        border-radius: 5px;
        margin-bottom: 10px;
    }

    input[type="submit"] {
        padding: 15px 30px;
        font-size: 18px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        box-sizing: border-box;
        margin-top: 20px;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }

    .form-container {
        margin-top: 50px;
    }

    .form-container td {
        padding: 12px 20px;
    }

    .form-container td label {
        font-weight: bold;
    }

    .image-container {
        display: flex;
        align-items: center;
    }

    .image-container img {
        margin-right: 15px;
    }

    .hidden {
        display: none;
    }
</style>
</head>
<body>

<%
int proid = Integer.parseInt(request.getParameter("productId"));
ProductsDAO dao = new ProductDAOimpl();
List<Product_Details> list = dao.getAllProducts();
Product_Details currentn_Product = null;
for (Product_Details details : list) {
    if (proid == details.getId()) {
        currentn_Product = details;
    }
}
%>

<div class="form-container">
    <form action="Updateproduct" method="post" enctype="multipart/form-data">
        <h1>Apply Changes On Your Product</h1>
        <table>
            <tr>
                <td><label for="productImage">Image</label></td>
                <td>
                    <div class="image-container">
                        <img src="images/<%= currentn_Product.getImageurl() %>" alt="Product Image" width="100" height="100">
                        <input type="file" name="updateImg">
                    </div>
                    <input type="file" class="hidden" name="actualImg" value="<%= currentn_Product.getImageurl()%>">
                </td>
            </tr>
            <tr>
                <td><label for="productName">Name</label></td>
                <td><input type="text" id="productName" value="<%= currentn_Product.getName() %>" disabled></td>
            </tr>
            <tr>
                <td><label for="productBrand">Brand</label></td>
                <td><input type="text" id="productBrand" value="<%= currentn_Product.getBrand() %>" disabled></td>
            </tr>
            <tr>
                <td><label for="productPrice">Price</label></td>
                <td><input type="number" id="productPrice" value="<%= currentn_Product.getPrise() %>" name="productPrise"></td>
            </tr>
            <tr>
                <td><label for="stockAvailable">Stock Available</label></td>
                <td><input type="number" id="stockAvailable" value="<%= currentn_Product.getQuantity() %>" name="productQty"></td>
            </tr>
            <tr>
                <td><label for="productDiscount">Discount</label></td>
                <td><input type="number" id="productDiscount" value="<%= currentn_Product.getDiscount() %>" name="productDiss"></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <input type="number" hidden="true" value="<%= proid %>" name="productId">
                    <input type="submit" value="Update Product">
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
