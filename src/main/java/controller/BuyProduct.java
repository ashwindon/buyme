package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BidModel;
import model.InterestModel;
import service.BidService;
import service.InterestService;
import service.UserNotificationManager;

import java.sql.Timestamp;    
import java.util.Date; 


/**
 * Servlet implementation class BuyProduct
 */
@WebServlet("/BuyProduct")
public class BuyProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BidService bidservice = new BidService();
	private InterestService interestSercvice = new InterestService();
    private UserNotificationManager userNotificationManager = new UserNotificationManager();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("save") != null) {
			String brand = request.getParameter("brand_search");
			String type = request.getParameter("type_search");
			String model = request.getParameter("model_search");
			String color = request.getParameter("color_search");
			String email = request.getSession().getAttribute("email").toString();;

			InterestModel interestModel = new InterestModel(email, brand, type, color, model);
			
			int success = 0;
			try {
				System.out.println("Calling add interested product");
				success = interestSercvice.addInterestedProduct(interestModel);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/BuyProducts.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		int pid = Integer.parseInt(request.getParameter("pid"));
		String email = request.getSession().getAttribute("email").toString();
		//String maximum_bid_amt = request.getParameter("bid_amount");
		double max_bid_amnt;
		//System.out.println(request.getParameter("bid_amount"));
		if(request.getParameter("bid_amount").isEmpty())
			max_bid_amnt = -1;
		else
			max_bid_amnt = Double.parseDouble(request.getParameter("bid_amount"));
		double current_bid = Double.parseDouble(request.getParameter("current_bid"));
		String buttonClicked = request.getParameter("bid_action");
		double min_amount_you_must_bid = Double.parseDouble(request.getParameter("min_amount_you_must_bid"));
		System.out.println(max_bid_amnt + " " + min_amount_you_must_bid);
		if(max_bid_amnt < min_amount_you_must_bid)
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Error!! Entered Bid should be atleast as much as Min amount\");") ; 
			out.println("window.location.href = \"/BuyMe/BuyProduct\";");
			out.println("</script>;");
		}
		else
		{
			Date date = new Date();  
	        Timestamp ts=new Timestamp(date.getTime()); 
			System.out.println("BuyProduct Post Service <3 Email: "+ email + ", Product Id: "+ pid+", Max Bid amt: "+max_bid_amnt + ", Bid Action:" + buttonClicked + ", Timestamp: "+ts);
			System.out.println("Min Amt You must bid: " + min_amount_you_must_bid);
			BidModel bidModel;
			if("Auto Bid".equals(buttonClicked))
			{
				 bidModel = new BidModel(pid,email, min_amount_you_must_bid , max_bid_amnt, ts);
			}
			else 
			{
				 bidModel = new BidModel(pid,email, min_amount_you_must_bid , min_amount_you_must_bid, ts);
			}
			int success = 0;
			try {
				success = bidservice.createNewBid(bidModel);
				success = bidservice.updateBids();
				userNotificationManager.SendNotifications(pid, email);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(success>0)
			{
				PrintWriter out = response.getWriter();
				out.println("<script type=\"text/javascript\">");  
	
				out.println("alert(\"Great Success!! New Bidding Added in the Database!\");") ; 
				out.println("window.location.href = \"/BuyMe/BuyProduct\";");
				out.println("</script>;");
				//response.sendRedirect("/BuyMe/Dashboard");
				
			}
			else
			{
				PrintWriter out = response.getWriter();
				out.println("<script type=\"text/javascript\">");  
	
				out.println("alert(\"Issue while creating a new bidding. Retry!\");") ; 
				out.println("window.location.href = \"/BuyMe/login\";");
				out.println("</script>;");
			}
		}
		
		//response.sendRedirect("/BuyMe/BuyProduct");
	}

}
