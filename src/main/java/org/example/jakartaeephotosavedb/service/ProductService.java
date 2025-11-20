package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.nio.charset.StandardCharsets;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.db.ProductDb;
import org.example.jakartaeephotosavedb.entity.Category;
import org.example.jakartaeephotosavedb.entity.Product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductService {
    private static ProductService productService;
    private ProductService() {}
    public static ProductService getInstance() {
        if (productService == null) {
            productService = new ProductService();
        }
        return productService;
    }





// ...

    public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        req.setCharacterEncoding("UTF-8");

        // Text fieldlarni olish (multipart bo‘lgani uchun getPart ishlatamiz)
        String name = new String(req.getPart("name").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        String priceStr = new String(req.getPart("price").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        String quantityStr = new String(req.getPart("quantity").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        String categoryIdStr = new String(req.getPart("categoryId").getInputStream().readAllBytes(), StandardCharsets.UTF_8);

        double price = Double.parseDouble(priceStr.trim());
        int quantity = Integer.parseInt(quantityStr.trim());
        int categoryId = Integer.parseInt(categoryIdStr.trim());

        byte[] imageBytes = req.getPart("file").getInputStream().readAllBytes();

        Product product = Product.builder()
                .name(name)
                .price(price)
                .quantity(quantity)
                .image(imageBytes)
                .category_id(categoryId)
                .active(false)
                .build();

        ProductDb productDb = ProductDb.getInstance();
        productDb.saveProduct(product);

        CategoryService categoryService = CategoryService.getInstance();
        List<Category> allCategories = categoryService.getAllCategories();
        req.setAttribute("categories", allCategories);
        req.getRequestDispatcher("/product-add.jsp").forward(req, resp);
    }



    public List<Product> getAllProducts( ) throws ServletException, IOException, SQLException {
         List<Product> products = new ArrayList<>();
        Connection connection = DbConfig.getConnection().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM productphoto where active = false order by id asc ");
        preparedStatement.execute();
        ResultSet resultSet = preparedStatement.getResultSet();
        while (resultSet.next()) {
           Product product = new  Product();
           product.setName(resultSet.getString("name"));
           product.setQuantity(resultSet.getInt("quantity"));
           product.setPrice(resultSet.getDouble("price"));
           product.setId(resultSet.getInt("id"));
           product.setCategory_id(resultSet.getInt("category_id"));
           products.add(product);
        }
        return products;
    }

    public Product findID(Integer productId) throws SQLException {
        ProductDb productDb = ProductDb.getInstance();
        Optional<Product> product = productDb.getProduct(productId);
        if (product.isPresent()) {
            return product.get();
        }
        return null;

    }


    public void productEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        ProductDb productDb = ProductDb.getInstance();
        Product product = new  Product();
        product.setName(req.getParameter("name"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
        product.setCategory_id(Integer.parseInt(req.getParameter("categoryId")));
        product.setImage(req.getPart("file").getInputStream().readAllBytes());
        product.setId(Integer.parseInt(req.getParameter("id")));
        product.setActive(false);
        productDb.updateProduct(product);
        resp.sendRedirect("/homeAdmin");
    }

    public void productDelete(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String productId = req.getParameter("id");
        ProductDb productDb = ProductDb.getInstance();
        productDb.deleteProduct(Integer.valueOf(productId));
        resp.sendRedirect("/homeAdmin");
    }


    public void productUpdate(Integer id, Integer quantity) throws SQLException {
        ProductDb productDb = ProductDb.getInstance();
        productDb.updateProductId(id,quantity);

    }
}
