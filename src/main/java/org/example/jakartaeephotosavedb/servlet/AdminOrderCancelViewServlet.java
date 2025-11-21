package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.service.AdminService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/Admin-order-cancel-view")
public class AdminOrderCancelViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AdminService adminService = AdminService.getAdminService();
        try {
            adminService.getAllOrderItems(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
