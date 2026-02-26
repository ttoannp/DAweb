package bo;

import bean.User;
import dao.UserDAO;

import java.util.List;

public class UserBO {
    private UserDAO userDAO;
    
    public UserBO() {
        userDAO = new UserDAO();
    }
    
    public boolean register(User user) {
        // Kiểm tra username đã tồn tại chưa
        if (userDAO.checkUsernameExists(user.getUsername())) {
            return false;
        }
        
        // Kiểm tra email đã tồn tại chưa
        if (userDAO.checkEmailExists(user.getEmail())) {
            return false;
        }
        
        // Thực hiện đăng ký
        return userDAO.register(user);
    }
    
    public User login(String username, String password) {
        return userDAO.login(username, password);
    }
    
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public boolean checkUsernameExists(String username) {
        return userDAO.checkUsernameExists(username);
    }
    
    public boolean checkEmailExists(String email) {
        return userDAO.checkEmailExists(email);
    }
    
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    public boolean validatePassword(int userId, String password) {
        return userDAO.validatePassword(userId, password);
    }
    
    public List<User> getUsersWithMostListings(int limit) {
        return userDAO.getUsersWithMostListings(limit);
    }
} 