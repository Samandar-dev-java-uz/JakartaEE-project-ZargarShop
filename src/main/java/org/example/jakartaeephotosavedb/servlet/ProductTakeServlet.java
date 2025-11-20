package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.service.CartService;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/product-take")
@MultipartConfig
public class ProductTakeServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService productService = ProductService.getInstance();
        Product product = productService.findID(Integer.parseInt(req.getParameter("id")));
        req.setAttribute("product", product);
        req.getRequestDispatcher("product-take.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            CartService cartService = CartService.getCartService();
        try {
            cartService.AddCart(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
