package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.service.OrderService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/order-product-view")
public class OrderItemServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderService orderService =OrderService.getInstance();
        orderService.getAllOrderItems(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        OrderService instance = OrderService.getInstance();
        try {
            instance.returnOrder(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
