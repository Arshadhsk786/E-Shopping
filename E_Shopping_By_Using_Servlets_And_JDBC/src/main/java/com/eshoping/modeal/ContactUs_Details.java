package com.eshoping.modeal;

import java.time.LocalDate;
import java.time.LocalTime;


public class ContactUs_Details 
{
	private int conId;
	private String conType;
	private int custId;
	private String hassel;
	private LocalDate currentDate;
	private LocalTime currentTime;
	private String status;
	
	public ContactUs_Details() {
		// TODO Auto-generated constructor stub
	}
	
	public ContactUs_Details(int conId, String conType, int custId, String hassel, LocalDate currentDate,
			LocalTime currentTime, String status) {
		super();
		this.conId = conId;
		this.conType = conType;
		this.custId = custId;
		this.hassel = hassel;
		this.currentDate = currentDate;
		this.currentTime = currentTime;
		this.status = status;
	}

	public int getConId() {
		return conId;
	}

	public void setConId(int conId) {
		this.conId = conId;
	}

	public String getConType() {
		return conType;
	}

	public void setConType(String conType) {
		this.conType = conType;
	}

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public String getHassel() {
		return hassel;
	}

	public void setHassel(String hassel) {
		this.hassel = hassel;
	}

	public LocalDate getCurrentDate() {
		return currentDate;
	}

	public void setCurrentDate(LocalDate currentDate) {
		this.currentDate = currentDate;
	}

	public LocalTime getCurrentTime() {
		return currentTime;
	}

	public void setCurrentTime(LocalTime currentTime) {
		this.currentTime = currentTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ContactUs_Details [conId=" + conId + ", conType=" + conType + ", custId=" + custId + ", hassel="
				+ hassel + ", currentDate=" + currentDate + ", currentTime=" + currentTime + ", status=" + status + "]";
	}
	
	
	
}
