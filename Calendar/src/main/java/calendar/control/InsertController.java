package calendar.control;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import calendar.service.Service;
import calendar.service.ServiceImpl;
import model.CalendarEvent;

/**
 * Servlet implementation class insertController
 */
@WebServlet("/calendar/Insert")
public class InsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action  = request.getParameter("action");
		String path = "";
		Service service = new ServiceImpl();
		/*일정 등록 과정 
		 * 1) 달력에서 date 클릭 -> InsertController 호출 -> insert.jsp 이동
		 * 2) insert.jsp에서 title 및 description 입력 후 일정 등록 클릭 -> InsertdoController 호출
		 * 3) InsertdoController에서 DB에 해당 데이터 저장 후 action=insertDone 호출 -> Insertcontroller 호출
		 */
		
		
		//1. InsertdoController에서 일정 등록 완료되면 action=insertDone 호출
		if (action != null && action.equals("insertDone")) {
			request.setAttribute("msg", "일정이 등록되었습니다. ");
			
			HttpSession session = request.getSession(false);
			Date currentDate = (Date) session.getAttribute("currentDate");
			request.setAttribute("currentDate",currentDate);

		}
		
		//2. calendar.jsp에서 달력 일자 클릭 시 해당일에 일정 등록하는 jsp 호출
		else {
			String currentDate_str = request.getParameter("selectedDate");
			java.sql.Date currentDate = java.sql.Date.valueOf(currentDate_str);
			request.setAttribute("currentDate", currentDate);
			
			List<CalendarEvent> events = service.getAllBydate(currentDate);
			request.setAttribute("events", events);
			
		}
		
		path = "/calendar/Insert_schedule.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		if (dispatcher != null) {
			dispatcher.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
