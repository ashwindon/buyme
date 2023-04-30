package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import model.InterestModel;
import service.InterestService;

/**
 * Servlet implementation class UserInterest
 */
@WebServlet("/UserInterest")
public class UserInterest extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private InterestService interestSercvice = new InterestService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserInterest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserInterest.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String brand = request.getParameter("brand_search");
        String type = request.getParameter("type_search");
        String model = request.getParameter("model_search");
        String color = request.getParameter("color_search");
        String email = request.getParameter("email");

        InterestModel interestModel = new InterestModel(email, brand, type, color, model);
        
        int success = 0;
        try {
            System.out.println("Calling remove interested product");
			success = interestSercvice.removeInterestedProduct(interestModel);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(success>0)
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  
			out.println("window.location.href = \"/BuyMe/UserInterest\";");
			out.println("</script>;");
		}
		else
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  
			out.println("alert(\"Issue while removing. Retry!\");") ; 
			out.println("window.location.href = \"/BuyMe/UserInterest\";");
			out.println("</script>;");
		}
	}

}
