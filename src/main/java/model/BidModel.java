package model;

import java.sql.Timestamp;    
import java.util.Date; 

public class BidModel {
	
	private int pid;
	private String email;
	private double current_bid;
	private double max_bid_limit;
	private Timestamp bid_time;

	public BidModel(int pid, String email, double current_bid, double max_bid_limit, Timestamp bid_time) {
		super();
		this.pid = pid;
		this.email = email;
		this.bid_time = bid_time;
		this.current_bid = current_bid;
		this.max_bid_limit = max_bid_limit;
	}
	
	public int getPid() {
		return pid;
	}
	
	public void setPid(int pid) {
		this.pid = pid;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public double getCurrent_bid() {
		return current_bid;
	}
	
	public void setCurrent_bid(double current_bid) {
		this.current_bid = current_bid;
	}
	
	public double getMax_bid_limit() {
		return max_bid_limit;
	}
	
	public void setMax_bid_limit(double max_bid_limit) {
		this.max_bid_limit = max_bid_limit;
	}
	
	public Timestamp getBid_time() {
		return bid_time;
	}

	public void setBid_time(Timestamp bid_time) {
		this.bid_time = bid_time;
	}
	
}
