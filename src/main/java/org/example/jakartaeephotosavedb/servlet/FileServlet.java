package org.example.jakartaeephotosavedb.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.service.ProductService;

import java.io.IOException;
import java.util.List;

@MultipartConfig
@WebServlet("/seeProduct")
public class FileServlet extends HttpServlet {
    @SneakyThrows
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            ProductService service =ProductService.getInstance();
        List<Product> allProducts = service.getAllProducts();
        req.setAttribute("products", allProducts);
        req.getRequestDispatcher("photo-see.jsp").forward(req, resp);
        
    }

    @SneakyThrows
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        ProductService service = ProductService.getInstance();
        service.save(req,resp);
    }
}
