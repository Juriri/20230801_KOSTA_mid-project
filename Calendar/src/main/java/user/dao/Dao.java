package user.dao;

import model.User;

public interface Dao {
	
	void insert(User u);
	User select(String id);
	void update(User u);
	void delete(String id);

}
