package com.shoping.Exception;

public class CustomerException extends RuntimeException
{
	private String msg;
	
	public CustomerException(String msg)
	{
		super();
		this.msg = msg;
	}

	public String getMsg() {
		return msg;
	}
}
