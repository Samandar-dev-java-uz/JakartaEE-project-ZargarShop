package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Category;
import org.example.jakartaeephotosavedb.service.CategoryService;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/product-add")
@MultipartConfig
public class ProductAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CategoryService instance = CategoryService.getInstance();
        try {
            List<Category> allCategories = instance.getAllCategories();
            req.setAttribute("categories",allCategories);
            req.getRequestDispatcher("product-add.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     ProductService service = ProductService.getInstance();
     service.save(req,resp);


    }
}
