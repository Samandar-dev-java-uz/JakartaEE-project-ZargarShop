package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/product-delete")
public class ProductDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = ProductService.getInstance();
        try {
            productService.productDelete(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
