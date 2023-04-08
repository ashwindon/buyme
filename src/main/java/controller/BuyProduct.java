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
import service.BidService;

import java.sql.Timestamp;    
import java.util.Date; 


/**
 * Servlet implementation class BuyProduct
 */
@WebServlet("/BuyProduct")
public class BuyProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BidService bidservice = new BidService();   
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
		double max_bid_amnt = Double.parseDouble(request.getParameter("bid_amount"));
		double current_bid = Double.parseDouble(request.getParameter("current_bid"));
		
		
		Date date = new Date();  
        Timestamp ts=new Timestamp(date.getTime()); 
		System.out.println("BuyProduct Post Service <3 Email: "+ email + ", Product Id: "+ pid+", Max Bid amt: "+max_bid_amnt + ", Timestamp: "+ts);
		
		BidModel bidModel = new BidModel(pid,email, current_bid , max_bid_amnt, ts);
		int success = 0;
		try {
			success = bidservice.createNewBid(bidModel);
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
		
		
		//response.sendRedirect("/BuyMe/BuyProduct");
	}

}
