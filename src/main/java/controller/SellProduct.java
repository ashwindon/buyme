package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ProductModel;
import service.ProductService;

/**
 * Servlet implementation class SellProduct
 */
@WebServlet("/sell")
public class SellProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ProductService productSercvice = new ProductService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/SellProduct.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession session = request.getSession(false);
		String email = session.getAttribute("email").toString();
		String product_title = request.getParameter("product_title");
		String product_desc = request.getParameter("product_desc");
		String product_type = request.getParameter("product_type");
		String product_color = request.getParameter("product_color");
		String product_model = request.getParameter("product_model");
		double starting_bid_price = Double.parseDouble(request.getParameter("starting_bid_price"));
		double secret_min_price = Double.parseDouble(request.getParameter("secret_min_price"));
		double min_bid_increment = Double.parseDouble(request.getParameter("min_bid_increment"));
		
		ProductModel productModel = new ProductModel(email, product_title, product_desc, product_type, product_color, 
				product_model,starting_bid_price,secret_min_price,min_bid_increment);
		int success = 0;
		try {
			success = productSercvice.createNewProduct(productModel);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(success>0)
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Great Success!! Listing Added in the Database!\");") ; 
			out.println("window.location.href = \"/BuyMe/Dashboard\";");
			out.println("</script>;");
			//response.sendRedirect("/BuyMe/Dashboard");
			
		}
		else
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Issue while creating a new listing. Retry!\");") ; 
			out.println("window.location.href = \"/BuyMe/login\";");
			out.println("</script>;");
		}
		
		
	}

}
