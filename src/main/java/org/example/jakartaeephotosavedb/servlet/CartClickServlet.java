package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.service.CartService;
import org.example.jakartaeephotosavedb.service.OrderService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/click-cart")
public class CartClickServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderService orderService = OrderService.getInstance();
        try {
            orderService.save(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
