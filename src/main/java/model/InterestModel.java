package model;

public class InterestModel {
	
	private String email;
    private String brand;
    private String type;
    private String color;
    private String model;

	public InterestModel(String email, String brand, String type, String color, String model) {
		super();
		this.email = email;
        this.brand = brand;
        this.type = type;
        this.color = color;
        this.model = model;
	}
	
	public String getEmail() {
        return email;
    }

    public String getBrand() {
        return brand;
    }

    public String getType() {
        return type;
    }

    public String getColor() {
        return color;
    }

    public String getModel() {
        return model;
    }

    // Setter methods
    public void setEmail(String email) {
        this.email = email;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setModel(String model) {
        this.model = model;
    }
}
