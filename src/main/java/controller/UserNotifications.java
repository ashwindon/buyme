package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import service.UserNotificationManager;


/**
 * Servlet implementation class UserNotifications
 */
@WebServlet("/UserNotifications")
public class UserNotifications extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserNotificationManager userNotificationManager = new UserNotificationManager();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserNotifications() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserNotifications.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int pid = Integer.parseInt(request.getParameter("pid"));
		userNotificationManager.MarkAsRead(pid);
		PrintWriter out = response.getWriter();
		out.println("<script type=\"text/javascript\">");   
		out.println("window.location.href = \"/BuyMe/UserNotifications\";");
		out.println("</script>;");
	}

}
