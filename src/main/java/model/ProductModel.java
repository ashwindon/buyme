package model;
import java.util.*;

public class ProductModel {
	

	private String email;
	private String product_title;
	private String product_desc;
	private String product_type;
	private String product_brand;
	private String product_color;
	private String product_model;
	private double starting_bid_price;
	private double secret_min_price;
	private double min_bid_increment;
	private String status;
	private Date end_date;
	private String end_time;
	
	
	public ProductModel(String email, String product_title, String product_desc, String product_type, String product_brand,
			String product_color, String product_model, double starting_bid_price, double secret_min_price,
			double min_bid_increment, Date end_date, String end_time) {
		super();
		this.email = email;
		this.product_title = product_title;
		this.product_desc = product_desc;
		this.product_type = product_type;
		this.product_brand = product_brand;
		this.product_color = product_color;
		this.product_model = product_model;
		this.starting_bid_price = starting_bid_price;
		this.secret_min_price = secret_min_price;
		this.min_bid_increment = min_bid_increment;
		this.end_date = end_date;
		this.end_time = end_time;
		this.status = "active";
	}
	
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public String getProduct_desc() {
		return product_desc;
	}

	public void setProduct_desc(String product_desc) {
		this.product_desc = product_desc;
	}

	public String getProduct_type() {
		return product_type;
	}

	public void setProduct_type(String product_type) {
		this.product_type = product_type;
	}

	public String getProduct_color() {
		return product_color;
	}

	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}

	public String getProduct_model() {
		return product_model;
	}

	public void setProduct_model(String product_model) {
		this.product_model = product_model;
	}

	public double getStarting_bid_price() {
		return starting_bid_price;
	}

	public void setStarting_bid_price(double starting_bid_price) {
		this.starting_bid_price = starting_bid_price;
	}

	public double getSecret_min_price() {
		return secret_min_price;
	}

	public void setSecret_min_price(double secret_min_price) {
		this.secret_min_price = secret_min_price;
	}

	public double getMin_bid_increment() {
		return min_bid_increment;
	}

	public void setMin_bid_increment(double min_bid_increment) {
		this.min_bid_increment = min_bid_increment;
	}
	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Date getEnd_date() {
		return end_date;
	}


	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}


	public String getEnd_time() {
		return end_time;
	}


	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	
	public String getProduct_brand() {
		return product_brand;
	}


	public void setProduct_brand(String product_brand) {
		this.product_brand = product_brand;
	}
}
