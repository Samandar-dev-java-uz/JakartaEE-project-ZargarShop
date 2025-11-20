package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.db.CategoryDb;
import org.example.jakartaeephotosavedb.entity.Category;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CategoryService
{
    private  static CategoryService categoryService;
    private CategoryService() {}
    public static CategoryService getInstance()
    {
        if (categoryService == null)
        {
            categoryService = new CategoryService();
        }
        return categoryService;
    }


    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, SQLException, IOException {
        Category category =Category.builder()
                .name(req.getParameter("name"))
                .build();

        CategoryDb.getInstance().create(category);
        req.getRequestDispatcher("category-create.jsp").forward(req,resp);
    }
    public List<Category> getAllCategories() throws SQLException, IOException, ServletException {
        CategoryDb categoryDb = CategoryDb.getInstance();
        List<Category> categories = categoryDb.getCategories();
        return categories;
    }
}
