package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.db.OrderDb;
import org.example.jakartaeephotosavedb.db.OrderItemDb;
import org.example.jakartaeephotosavedb.entity.Order;
import org.example.jakartaeephotosavedb.entity.OrderItem;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminService {
    private  static AdminService adminService ;
     protected AdminService(){}
    public static AdminService getAdminService(){
        if(adminService == null){
            adminService = new AdminService();
        }
        return adminService;
    }

    public void getAllOrder(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        OrderDb orderDb = OrderDb.getInstance();
        List<Order> OrdersAdmin = orderDb.getAllOrdersAdmin();
        req.setAttribute("orders",OrdersAdmin);
        req.getRequestDispatcher("/Admin-orders.jsp").forward(req,resp);

    }

    public void getOrderItem(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        OrderItemDb orderItemDb = OrderItemDb.getInstance();
        List<OrderItem> OrderItem = orderItemDb.getAllOrderItem(Integer.parseInt(req.getParameter("id")));
        req.setAttribute("orderItems",OrderItem);
        req.getRequestDispatcher("Admin-OrderItems.jsp").forward(req,resp);

    }

    public void getOrdersCancel(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
         OrderDb orderDb = OrderDb.getInstance();
        List<Order> cancels = orderDb.getAllOrderAdminCancels();
        req.setAttribute("orders",cancels);
        req.getRequestDispatcher("Admin-order-cancel.jsp").forward(req,resp);
    }

    public void getAllOrderItems(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        OrderItemDb orderItemDb = OrderItemDb.getInstance();
        List<OrderItem> OrderItem = orderItemDb.getAllOrderItem(Integer.parseInt(req.getParameter("id")));
        req.setAttribute("orderItems",OrderItem);
        req.getRequestDispatcher("Admin-OrderItems-view.jsp").forward(req,resp);
    }
}
