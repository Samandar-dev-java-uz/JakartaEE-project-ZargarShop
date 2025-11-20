package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/photoSee")
public class PhotoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductService service = ProductService.getInstance();
         Integer id = Integer.parseInt(  req.getParameter("productId"));
        try {
            Product product = service.findID(id);
            resp.getOutputStream().write(product.getImage());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
