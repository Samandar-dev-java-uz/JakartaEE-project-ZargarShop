package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.db.CartDb;
import org.example.jakartaeephotosavedb.db.CartItemDb;
import org.example.jakartaeephotosavedb.db.OrderDb;
import org.example.jakartaeephotosavedb.db.OrderItemDb;
import org.example.jakartaeephotosavedb.entity.CartItem;
import org.example.jakartaeephotosavedb.entity.Order;
import org.example.jakartaeephotosavedb.entity.OrderItem;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private static OrderService instance;
    private OrderService() {}
    public static OrderService getInstance() {
        if (instance == null) {
            instance = new OrderService();
        }
        return instance;
    }
    private Integer userId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getSession().getAttribute("userId").toString();
        return Integer.parseInt(userId);

    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        Integer Id = userId(req, resp);
        String str = req.getParameter("total_price");
        Double price = Double.parseDouble(str);
        CartDb cartDb = CartDb.getInstance();
        Integer cartId = cartDb.AddCart(Id);
        CartItemDb cartItem = CartItemDb.getCartItem();
        List<CartItem> cartItems = cartItem.getAllCart(cartId);
        cartItem.getCartUp(cartId);
        OrderDb orderDb = OrderDb.getInstance();
        Integer orderId =  orderDb.save(Id,price);
        OrderItemDb orderItemDb =OrderItemDb.getInstance();
        orderItemDb.save(orderId,cartItems);
       resp.sendRedirect("/homeUser");




    }

    public void getAllOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        Integer Id = userId(req, resp);
        OrderDb orderDb = OrderDb.getInstance();
        List<Order> allOrders = orderDb.getAllOrders(Id);
        req.setAttribute("orders", allOrders);
        req.getRequestDispatcher("/orders.jsp").forward(req, resp);

    }

    public void getAllOrderItems(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        Integer orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderItemDb orderItemDb = OrderItemDb.getInstance();
        List<OrderItem> OrderItems = orderItemDb.getAllOrderItem(orderId);
        req.setAttribute("orderItems", OrderItems);
        req.getRequestDispatcher("orderItem.jsp").forward(req,resp);

    }

    public void returnOrder(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        Integer orderId = Integer.parseInt(req.getParameter("orderId"));
        OrderDb orderDb = OrderDb.getInstance();
        orderDb.returnOrder(orderId);
        resp.sendRedirect("/orders-view");
    }
}
