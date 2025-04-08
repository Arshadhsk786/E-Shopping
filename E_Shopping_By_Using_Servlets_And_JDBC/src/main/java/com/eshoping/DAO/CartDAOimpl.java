package com.eshoping.DAO;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpSession;

import com.eshoping.modeal.Cart_Details;
import com.eshoping.modeal.Product_Details;
import com.mysql.cj.jdbc.result.ResultSetMetaData;

public class CartDAOimpl implements CartDAO
{
	private static final String url="jdbc:mysql://localhost:3306/e_shoping?user=root&password=Root";
	private static final String countCustomerId="select count(Customer_Id) from cart where Customer_Id=?";
	private static final String checkCart="select * from cart where Product_Id=? and Customer_Id=?";
	private static final String insert="insert into cart(Customer_Id, Product_Id)values(?,?)";
	private static final String currentCart="SELECT * FROM e_shoping.product_details p "
			+ "join e_shoping.cart c on p.id=c.Product_Id where Customer_Id=?";
	private static final String deleteFromCart="delete from cart where Product_Id=? and Customer_Id=?";
	
	@Override
	public int getCustomerCartCount(int customerID) 
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(countCustomerId);
			pstm.setInt(1, customerID);
			ResultSet res=pstm.executeQuery();
			if(res.next())
			{
				ResultSetMetaData metadata=(ResultSetMetaData) res.getMetaData();
				int columnCount=metadata.getColumnCount();
				System.out.println("column count in Buffer Memory: "+columnCount);
				System.out.println("column Name in Buffer Memory: "+metadata.getCatalogName(1));
				return res.getInt(1);
			}
			else
			{
				return 0;
			}
		}
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int AddToCart(Cart_Details cart_Details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement ps=con.prepareStatement(checkCart);
			ps.setInt(1, cart_Details.getProduct_Id());
			ps.setInt(2, cart_Details.getCustomer_Id());
			ResultSet r=ps.executeQuery();
			if(r.isBeforeFirst())
			{
				return 0;
			}
			else
			{
				PreparedStatement pstm=con.prepareStatement(insert);
				pstm.setInt(1, cart_Details.getCustomer_Id());
				pstm.setInt(2, cart_Details.getProduct_Id());
				return pstm.executeUpdate();
			}
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<Product_Details> getCart(int customerID) 
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(currentCart);
			pstm.setInt(1, customerID);
			List<Product_Details> Product_details=new ArrayList<Product_Details>();
			ResultSet res=pstm.executeQuery();
			while(res.next())
			{
				Product_Details details=new Product_Details();
				details.setId(res.getInt("id"));
				details.setCategory(res.getString("Category"));
				details.setBrand(res.getString("Brand"));
				details.setName(res.getString("Name"));
				details.setPrise(res.getDouble("Prise"));
				details.setDiscount(res.getInt("Discount"));
				details.setQuantity(res.getInt("Discount"));
				details.setImageurl(res.getString("imageurl"));
				Product_details.add(details);
			}
			return Product_details;
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
		// TODO Auto-generated method stub
	}

	@Override
	public boolean deleteFRomCart(Cart_Details cart_Details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(deleteFromCart);
			pstm.setInt(1, cart_Details.getProduct_Id());
			pstm.setInt(2, cart_Details.getCustomer_Id());
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
