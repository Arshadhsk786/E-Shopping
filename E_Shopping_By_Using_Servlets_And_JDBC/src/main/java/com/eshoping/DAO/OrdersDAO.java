package com.eshoping.DAO;

import java.util.List;

import com.eshoping.modeal.Order_Details;
public interface OrdersDAO 
{
	List<Order_Details>getAllOrders();
	boolean UpdateOrderStatus(Order_Details details);
	boolean cancelOrder(Order_Details details);
}
