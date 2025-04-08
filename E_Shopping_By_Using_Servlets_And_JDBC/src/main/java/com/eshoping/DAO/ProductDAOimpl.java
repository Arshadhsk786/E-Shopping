package com.eshoping.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.eshoping.modeal.Product_Details;

public class ProductDAOimpl implements ProductsDAO
{
	private static final String url="jdbc:mysql://localhost:3306/e_shoping?user=root&password=Root";
	private static final String insert="insert into product_details(Category, Brand, Name, Prise, Discount, Quality, imageurl)"
			+ "values(?,?,?,?,?,?,?)";
	private static final String select="select * from product_details";
	private static final String delete="delete from product_details where id=?";
	private static final String update="UPDATE product_details SET Quality = ?, Discount = ?, Prise = ?, imageurl = ? WHERE id = ?";
	private static final String filter="SELECT * FROM e_shoping.product_details where Category like ? or brand like ? or Name like ?";
	private static final String updateProduct="UPDATE product_details SET Quality = ? WHERE id = ?";
	@Override
	public boolean AddProducts(Product_Details details) 
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(insert);
			pstm.setString(1, details.getCategory());
			pstm.setString(2, details.getBrand());
			pstm.setString(3, details.getName());
			pstm.setDouble(4, details.getPrise());
			pstm.setInt(5, details.getDiscount());
			pstm.setInt(6, details.getQuantity());
			pstm.setString(7, details.getImageurl());
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		} 
		catch (ClassNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	@Override
	public List<Product_Details> getAllProducts()
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(select);
			ResultSet res=pstm.executeQuery();
			List<Product_Details> list=new ArrayList<Product_Details>();
			while(res.next())
			{
				Product_Details details=new Product_Details();
				details.setId(res.getInt("id"));
				details.setCategory(res.getString("Category"));
				details.setBrand(res.getString("Brand"));
				details.setName(res.getString("Name"));
				details.setPrise(res.getDouble("Prise"));
				details.setDiscount(res.getInt("Discount"));
				details.setQuantity(res.getInt("Quality"));
				details.setImageurl(res.getString("imageurl"));
				list.add(details);
			}
			return list;
		}
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public List<Product_Details> Applyfilter(String value) 
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(filter);
			pstm.setString(1,("%"+value+"%") );
			pstm.setString(2,("%"+value+"%") );
			pstm.setString(3,("%"+value+"%") );
			ResultSet res= pstm.executeQuery();
			List<Product_Details> list=new ArrayList<Product_Details>();
			while(res.next())
			{
				Product_Details details=new Product_Details();
				details.setId(res.getInt("id"));
				details.setCategory(res.getString("Category"));
				details.setBrand(res.getString("Brand"));
				details.setName(res.getString("Name"));
				details.setPrise(res.getDouble("Prise"));
				details.setDiscount(res.getInt("Discount"));
				details.setQuantity(res.getInt("Quality"));
				details.setImageurl(res.getString("imageurl"));
				list.add(details);
			}
			return list;
		} 
		catch (ClassNotFoundException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public boolean deleteProduct(Product_Details details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(delete);
			pstm.setInt(1, details.getId());
			if(pstm.executeUpdate()>0)
				return true;
			else
				return false;
		} 
		catch 
		(ClassNotFoundException e)
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
	public boolean updateproduct(Product_Details details)
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(update);
			pstm.setInt(1, details.getQuantity());
			pstm.setInt(2, details.getDiscount());
			pstm.setDouble(3, details.getPrise());
			pstm.setString(4, details.getImageurl());
			pstm.setInt(5, details.getId());
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
	public boolean updateQuantityAfterPayment(Product_Details details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(updateProduct);
			pstm.setInt(1, details.getQuantity());
			pstm.setInt(2, details.getId());
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
