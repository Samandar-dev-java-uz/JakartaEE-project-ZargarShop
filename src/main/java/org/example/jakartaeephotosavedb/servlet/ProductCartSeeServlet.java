package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Cart;
import org.example.jakartaeephotosavedb.service.CartService;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/product-cart")
public class ProductCartSeeServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     CartService cartService = CartService.getCartService();
     cartService.getAllTakeProduct(req,resp);

    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CartService cartService = CartService.getCartService();
        cartService.remove(req,resp);
    }
}
