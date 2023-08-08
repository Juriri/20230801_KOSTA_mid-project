package user.service;

import user.dao.Dao;
import model.User;
import user.dao.DaoImpl;

public class ServiceImpl implements Service{
	
	private Dao dao;
	
	public ServiceImpl() {
		this.dao = new DaoImpl();
	}

	@Override
	public void join(User u) {
		// TODO Auto-generated method stub
		dao.insert(u);
	}

	@Override
	public User getMember(String id) {
		// TODO Auto-generated method stub
		return dao.select(id);
	}

	@Override
	public void editMember(User u) {
		// TODO Auto-generated method stub
		dao.update(u);
	}

	@Override
	public void remMember(String id) {
		// TODO Auto-generated method stub
		dao.delete(id);
	}

	@Override
	public boolean login(String id, String pwd) {
		// TODO Auto-generated method stub
		User u = dao.select(id);
		if( u == null || !u.getPwd().equals(pwd)) {
			return false;
		}else {
			return true;
		}
	}

}
