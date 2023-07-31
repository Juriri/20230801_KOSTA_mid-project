package calender;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class calController
 */
@WebServlet("/calender/Cal")
public class calController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public calController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action = request.getParameter("action");
		LocalDate currentDate = LocalDate.parse(request.getParameter("currentDate"));

		int year = currentDate.getYear();
        int month = currentDate.getMonthValue();
        int date = currentDate.getDayOfMonth();
        
        
		if (action.equals("previous")) {
	        // 이전 달 계산
	        if (month == 1) {
	        	year = year - 1;
	        	month = 12;
	        } else {
	        	month = month - 1;
	        }	
	        
		} else if (action.equals("next")) {     
	        // 다음 달 계산
	        if (month == 12) {
	        	year = year + 1;
	        	month = 1;
	        } else {
	        	month = month + 1;
	        }
		}
	

		//가장 마지막 date 28 or 30 or 31 계산
        if (month == 2) {
            // February has a special case, so handle it separately
            if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
                // Leap year
                date = 29;
            } else {
                date = 28;
            }
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            // 30-day month
            date = Math.min(date, 30);
        } else {
            // 31-day month
            date = Math.min(date, 31);
        }
        
		//전달 혹은 다음달 날짜 전달
		HttpSession session = request.getSession();
		String new_month = "";
		if (0<month && month< 10)
			new_month = "0"+Integer.toString(month);
		else
			new_month = Integer.toString(month);
		
		//str -> LocalDate로 변경
		String new_str = year+"-"+new_month+"-"+date;
		LocalDate nextDate = LocalDate.parse(new_str);
		
		session.setAttribute("nextDate", nextDate);
		
		String path = "/calender/calender.jsp";
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
