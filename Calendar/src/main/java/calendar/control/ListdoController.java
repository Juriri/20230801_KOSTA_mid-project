package calendar.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import calendar.service.Service;
import calendar.service.ServiceImpl;
import model.CalendarEvent;
/**
 * Servlet implementation class ListController
 */
@WebServlet("/calendar/List.do")
public class ListdoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListdoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action = request.getParameter("action");
		Service service = new ServiceImpl();
		List<CalendarEvent> events = null;
		
		if(action.equals("title")) {
			int currentYear = Integer.parseInt(request.getParameter("currentYear"));
			int currentMonth = Integer.parseInt(request.getParameter("currentMonth"));
			//현재 월을 DB의 current month와 비교하여 title을 가지고옴
			events = service.getAllBymonth(currentYear, currentMonth);

			String json = new Gson().toJson(events);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		}
		
		request.setAttribute("title", events);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
