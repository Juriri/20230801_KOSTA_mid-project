package calendar.dao;

import model.CalendarEvent;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import conn.DBConnect;

public class DaoImpl implements Dao{
	private DBConnect db;
	
	public DaoImpl() {
		this.db = DBConnect.getInstance();
	}
	
	@Override
	public void insert(CalendarEvent cal) {
		// TODO Auto-generated method stub
		/*event_id: 일정 고유 ID (Primary Key)
		event_title: 일정 제목
		event_date: 일정 날짜와 시간
		event_description: 일정 설명*/

		Connection conn = db.getConnection();
		
		String sql = "insert into CalendarEvent values(?,?,?,?)";
		PreparedStatement pstmt = null;
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, makeNum(getAll()));
			pstmt.setString(2, cal.getEvent_title());
			pstmt.setDate(3, cal.getEvent_date());
			pstmt.setString(4, cal.getEvent_description());
	
			pstmt.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			try {
				
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public List<CalendarEvent> getAll() {
		// TODO Auto-generated method stub
		List<CalendarEvent> list = new ArrayList<CalendarEvent>();
		ResultSet rs = null;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "select * from CalendarEvent";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int event_id = rs.getInt(1);
				String event_title = rs.getString(2);
				Date event_date = rs.getDate(3);
				String event_description = rs.getString(4);
				
				list.add(new CalendarEvent(event_id, event_title, event_date, event_description));		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public int makeNum(List<CalendarEvent> list) {
		// TODO Auto-generated method stub
		List<Integer> number_list = new ArrayList<>();
		
		
		ResultSet rs = null;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "select event_id from CalendarEvent";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int event_id = rs.getInt(1);
				number_list.add(event_id);		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		Collections.sort(number_list);
		
		int next_num = 1;
		int num_len = number_list.size();
		
		for (int i=0; i<num_len; i++) {
			int currentNum = number_list.get(i);
            if (currentNum != next_num) {
                // 현재 숫자와 다음 숫자가 연속적이지 않다면, 현재 숫자가 존재하지 않는 가장 작은 숫자임
                break;
            }
            next_num++;
		}
		
		return next_num;
	}

	@Override
	public List<CalendarEvent> getAllBymonth(int year, int month) {
		// TODO Auto-generated method stub		
		List<CalendarEvent> list = new ArrayList<CalendarEvent>();
		ResultSet rs = null;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String year_str = Integer.toString(year).substring(2, 4);
		String month_str = Integer.toString(month);
		month_str = month_str.length()>=2? month_str:"0"+month_str;
	
		String sql = "SELECT * FROM CalendarEvent WHERE event_date LIKE '%" + year_str + "/"+ month_str+ "%'";

		try {
			pstmt = conn.prepareStatement(sql);
			//pstmt.setInt(1, cal.getEvent_date());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int event_id = rs.getInt(1);
				String event_title = rs.getString(2);
				Date event_date = rs.getDate(3);
				String event_description = rs.getString(4);
				
				list.add(new CalendarEvent(event_id, event_title, event_date, event_description));		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public List<CalendarEvent> getAllBydate(Date date) {
		// TODO Auto-generated method stub
		List<CalendarEvent> list = new ArrayList<CalendarEvent>();
		ResultSet rs = null;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy/MM/dd");
		String formattedDate = outputFormat.format(date);
		String sql = "SELECT * FROM CalendarEvent WHERE event_date = '" + formattedDate + "'";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int event_id = rs.getInt(1);
				String event_title = rs.getString(2);
				Date event_date = rs.getDate(3);
				String event_description = rs.getString(4);
				
				list.add(new CalendarEvent(event_id, event_title, event_date, event_description));		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public void deleteEvent(int event_id) {
		// TODO Auto-generated method stub
		Connection conn = db.getConnection();
		
		String sql = "delete CalendarEvent where event_id=?";
		PreparedStatement pstmt = null;
		System.out.println("dao에서 삭제 들어감");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, event_id);
			pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			try {
				
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
