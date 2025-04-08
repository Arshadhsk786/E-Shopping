package com.eshoping.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.eshoping.modeal.Admin_Details;

public class adminDAOImpl implements adminDAO
{
	private static final String url="jdbc:mysql://localhost:3306/e_shoping?user=root&password=Root";
	private static final String check="select * from admin where admin_EmailId=? and admin_Password=?";
	@Override
	public boolean adminLoginCheck(Admin_Details admin_Details)
	{
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			PreparedStatement pstm=con.prepareStatement(check);
			pstm.setString(1, admin_Details.getAdmin_EmailId());
			pstm.setString(2, admin_Details.getAdmin_Password());
			ResultSet res=pstm.executeQuery();
			if(res.isBeforeFirst())
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

}
