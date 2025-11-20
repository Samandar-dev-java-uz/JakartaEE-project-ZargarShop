package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/homeUser")
public class UserHomeServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = ProductService.getInstance();
        List<Product> products = productService.getAllProducts();
        req.setAttribute("products", products);
        req.getRequestDispatcher("User-Profile.jsp").forward(req, resp);
    }
}
