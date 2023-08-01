package calendar.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import calendar.dao.*;
import conn.DBConnect;
import model.CalendarEvent;

public class ServiceImpl implements Service{
	private Dao dao;
	
	public ServiceImpl() {
		this.dao = new DaoImpl();
	}
	

	@Override
	public void insert(CalendarEvent cal) {
		// TODO Auto-generated method stub
		dao.insert(cal);
	}

	@Override
	public List<CalendarEvent> getAll() {
		// TODO Auto-generated method stub
		return dao.getAll();
	}


	@Override
	public List<CalendarEvent> getAllBymonth(int year, int month) {
		// TODO Auto-generated method stub
		return dao.getAllBymonth(year, month);
	}


	@Override
	public List<CalendarEvent> getAllBydate(Date date) {
		// TODO Auto-generated method stub
		return dao.getAllBydate(date);
	}
	

	
}