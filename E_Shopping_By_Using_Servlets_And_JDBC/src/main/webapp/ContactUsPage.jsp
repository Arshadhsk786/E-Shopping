<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: black;
            color: goldenrod;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #1a1a1a;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px goldenrod;
            width: 600px;
            height: 450px;
        }
        .form-container h1 {
            text-align: center;
            color: goldenrod;
            margin-bottom: 20px;
            cursor: pointer;
        }
        .form-container h1:hover {
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select, input[type="text"], textarea, button {
            width: 100%;
            padding: 10px;
            border: 1px solid goldenrod;
            border-radius: 5px;
            background-color: black;
            color: goldenrod;
        }
        select {
            appearance: none; /* Removes default styling */
            -webkit-appearance: none;
            -moz-appearance: none;
            background-color: black;
            color: goldenrod;
            border: 1px solid goldenrod;
            cursor: pointer;
        }
        select:focus {
            outline: none;
            border-color: orange;
            box-shadow: 0 0 5px orange;
        }
        textarea {
            resize: none;
            width: 96%;
        }
        #customerId {
            width: 96%;
        }
        button {
            margin-top: 10px;
            background-color: goldenrod;
            color: black;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #d4af37;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Contact Us</h1>
        <form action="ContactUsData">
        <input hidden="true" value=<%=request.getParameter("preUrl")%> name="preUrl">
            <div class="form-group">
                <label for="regarding">Regarding</label>
                <select id="regarding" name="regarding" required>
                	<option value="" disabled selected>Select The Type Of Hessel</option>
                    <option value="payment">Payment</option>
                    <option value="interface">Interface</option>
                    <option value="cart">Cart</option>
                    <option value="technical">Technical</option>
                </select>
            </div>
            <div class="form-group">
                <label for="customerId">Customer ID</label>
                <input type="text" id="customerId" value=<%=Integer.parseInt(request.getParameter("CustomerId")) %> name="custId" readonly required>
            </div>
            <div class="form-group">
                <label for="hassel">Hassel(issue)</label>
                <textarea id="hassel" name="hassel" rows="5" maxlength="500" placeholder="Describe your issue (max 500 characters)" required></textarea>
            </div>
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
