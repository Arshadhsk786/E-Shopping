package com.eshoping.DAO;

import java.util.List;

import com.eshoping.modeal.Product_Details;

public interface ProductsDAO 
{
	boolean AddProducts(Product_Details details);
	List<Product_Details> getAllProducts();
	List<Product_Details> Applyfilter(String value);
	boolean deleteProduct(Product_Details details);
	boolean updateproduct(Product_Details details);
	boolean updateQuantityAfterPayment(Product_Details details);
}
