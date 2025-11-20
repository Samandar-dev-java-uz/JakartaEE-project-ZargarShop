package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.service.UserService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/userLogUp")
public class UserLogUpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Log-Up.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = UserService.getInstance();
        try {
            userService.findUser(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
