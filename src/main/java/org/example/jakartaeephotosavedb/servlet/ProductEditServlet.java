package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Category;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.service.CategoryService;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/product-edit")
@MultipartConfig
public class ProductEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = ProductService.getInstance();
        try {
            Product product = productService.findID(Integer.parseInt(req.getParameter("id")));
            CategoryService categoryService = CategoryService.getInstance();
            List<Category> categories = categoryService.getAllCategories();
            req.setAttribute("categories",categories);
            req.setAttribute("product", product);
             req.getRequestDispatcher("product-edit.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = ProductService.getInstance();
        productService.productEdit(req,resp);
    }
}
