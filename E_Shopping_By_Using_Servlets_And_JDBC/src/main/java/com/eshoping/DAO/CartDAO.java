package com.eshoping.DAO;

import java.util.List;

import com.eshoping.modeal.Cart_Details;
import com.eshoping.modeal.Product_Details;

public interface CartDAO
{
	int getCustomerCartCount(int customerID);
	int AddToCart(Cart_Details cart_Details);
	List<Product_Details> getCart(int customerID);
	boolean deleteFRomCart(Cart_Details cart_Details);
}
