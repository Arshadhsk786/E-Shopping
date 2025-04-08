package com.eshoping.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.eshoping.modeal.Order_Details;
import com.eshoping.modeal.Product_Details;

public class OrdersDAOimpl implements OrdersDAO
{
	private static final String url="jdbc:mysql://localhost:3306/e_shoping?user=root&password=Root";
	private static final String ordersSelect="SELECT * FROM e_shoping.order_details o join e_shoping.product_details p on o.Product_Id=p.id";
	private static final String updateOrderStatus="update order_details set Status=? where Order_id=?";

	@Override	
	public List<Order_Details> getAllOrders()
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(ordersSelect);
			ResultSet res=pstm.executeQuery();
			List<Order_Details> list=new ArrayList<Order_Details>();
			while(res.next())
			{
				Order_Details details=new Order_Details();
				details.setOrder_id(res.getInt("Order_id"));
				details.setCustomer_Id(res.getInt("Customer_Id"));
				details.setProduct_Id(res.getInt("Product_Id"));
				details.setPayment_Id(res.getInt("Payment_Id"));
				details.setPurchase_Quantity(res.getInt("Purchase_Quantity"));
				details.setPurchase_Date(res.getDate("Purchase_Date").toLocalDate());
				details.setPurchase_Time(res.getTime("Purchase_Time").toLocalTime());
				details.setTotal_Purchase_Prise(res.getDouble("Total_Purchase_Prise"));
				details.setStatus(res.getString("Status"));
				details.setImg(res.getString("imageurl"));
				list.add(details);
			}
			return list;
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public boolean UpdateOrderStatus(Order_Details details) 
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(updateOrderStatus);
			pstm.setString(1, details.getStatus());
			pstm.setInt(2, details.getOrder_id());
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		}
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean cancelOrder(Order_Details details)
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(updateOrderStatus);
			pstm.setString(1, details.getStatus());
			pstm.setInt(2, details.getOrder_id());
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		} 
		catch (ClassNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

}
