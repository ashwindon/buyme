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

import service.UserService;

/**
 * Servlet implementation class RaiseProductDeleteRequestController
 */
@WebServlet("/RaiseProductDeleteRequest")
public class RaiseProductDeleteRequestController extends HttpServlet {
	private UserService userService = new UserService();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RaiseProductDeleteRequestController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserHistory.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		int success = 0;
		String email = session.getAttribute("email").toString();
		int pid = Integer.parseInt(request.getParameter("pid"));
		success = userService.RaiseProductDeleteRequest( pid,email);
		if(success>0)
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Great Success!! Product Deletion Request has been raised!\");") ; 
			out.println("window.location.href = \"/BuyMe/RaiseProductDeleteRequest\";");
			out.println("</script>;");
			//response.sendRedirect("/BuyMe/Dashboard");
			
		}
		else
		{
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Issue while raising product deletion request. Retry!\");") ; 
			out.println("window.location.href = \"/BuyMe/login\";");
			out.println("</script>;");
		}
	}

}
