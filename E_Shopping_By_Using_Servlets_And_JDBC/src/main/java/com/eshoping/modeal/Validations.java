package com.eshoping.modeal;

public class Validations 
{
	public boolean emailCheck(String value)
	{
		String rev="";
		int dotCount=0;
		int atTheRateCount=0;
		if(value.length()>=13)
		{
			for(int i=0;i<value.length();i++)
			{
				char ch=value.charAt(i);
				if(ch=='@')
					atTheRateCount++;
				if(ch=='.')
					dotCount++;
			}
			for(int i=value.length()-1;i>=0;i--)
			{
				rev+=value.charAt(i);
			}
			rev=rev.substring(0, 10);
		}
		return (rev.equalsIgnoreCase("moc.liamg@") && atTheRateCount==1 && dotCount==1)?true:false;
	}
	
	public boolean validateMobile(long value)
	{
		return(value>=6000000000l && value<=9999999999l)?true:false;
	}
}
