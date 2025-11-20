package org.example.jakartaeephotosavedb.db;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.Category;
import org.example.jakartaeephotosavedb.servlet.CategoryServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDb {
    private static CategoryDb categoryDb;
    private CategoryDb(){
    }
    public static CategoryDb getInstance(){
        if(categoryDb == null){
            categoryDb = new CategoryDb();
        }

        return categoryDb;
    }
    public void create(Category category) throws ServletException, IOException, SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO category (name) VALUES (?)");
        preparedStatement.setString(1,category.getName());
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();

    }
    public List<Category> getCategories() throws ServletException, IOException, SQLException {

        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM category where active = false");
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Category> categories = new ArrayList<>();
        while(resultSet.next()){
            Category category = new Category();
            category.setId(resultSet.getInt("id"));
            category.setName(resultSet.getString("name"));
            categories.add(category);
        }
        return  categories;
    }
    public void update(Category category) throws ServletException, IOException, SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE category SET name = ? WHERE id = ?");
        preparedStatement.setString(1,category.getName());
        preparedStatement.setInt(2,category.getId());
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();

    }
    public void delete(Category category) throws ServletException, IOException, SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE category SET active = true WHERE id = ?");
        preparedStatement.setInt(1,category.getId());
        preparedStatement.execute();
    }



}
