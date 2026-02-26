package bo;

import bean.Category;
import dao.CategoryDAO;

import java.util.List;

public class CategoryBO {
    private CategoryDAO categoryDAO;
    
    public CategoryBO() {
        categoryDAO = new CategoryDAO();
    }
    
    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
    
    public Category getCategoryById(int id) {
        return categoryDAO.getCategoryById(id);
    }
    
    public boolean addCategory(Category category) {
        return categoryDAO.addCategory(category);
    }
    
    public boolean updateCategory(int id, String name) {
        return categoryDAO.updateCategory(id, name);
    }
    
    public boolean deleteCategory(int id) {
        return categoryDAO.deleteCategory(id);
    }
} 