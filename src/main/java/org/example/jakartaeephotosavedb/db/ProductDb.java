package org.example.jakartaeephotosavedb.db;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDb {
    public static ProductDb productDb;
    private ProductDb() {}
  public static ProductDb getInstance() {
      if (productDb == null) {
          productDb = new ProductDb();
      }
      return productDb;
  }
  public void saveProduct(Product product) throws SQLException {
      Connection connection = DbConfig.getDataSource().getConnection();
      PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO productphoto (name, price,quantity,active,photo,category_id) VALUES (?, ?, ?,?,?,?)");
      preparedStatement.setString(1, product.getName());
      preparedStatement.setDouble(2, product.getPrice());
      preparedStatement.setInt(3, product.getQuantity());
      preparedStatement.setBoolean(4,product.getActive());
      preparedStatement.setBytes(5,product.getImage());
      preparedStatement.setInt(6,product.getCategory_id());
      preparedStatement.execute();
      preparedStatement.close();
      connection.close();

  }
  public List<Product> getAllProducts() throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM productphoto where active=false");
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Product> products = new ArrayList<>();
        while (resultSet.next()) {
            Product product = new Product();
            product.setName(resultSet.getString("name"));
            product.setPrice(resultSet.getDouble("price"));
            product.setQuantity(resultSet.getInt("quantity"));
            product.setActive(resultSet.getBoolean("active"));
            product.setImage(resultSet.getBytes("photo"));
            product.setCategory_id(resultSet.getInt("category_id"));
            product.setId(resultSet.getInt("id"));
            products.add(product);
        }
        return products;
  }
  public void updateProduct(Product product) throws SQLException {Connection connection = DbConfig.getDataSource().getConnection();
      PreparedStatement preparedStatement = connection.prepareStatement("UPDATE productphoto set name=?, price=?, quantity=?, active=?,photo=? where id=?");
      preparedStatement.setString(1, product.getName());
      preparedStatement.setDouble(2, product.getPrice());
      preparedStatement.setInt(3, product.getQuantity());
      preparedStatement.setBoolean(4,product.getActive());
      preparedStatement.setBytes(5,product.getImage());
      preparedStatement.setInt(6,product.getId());
      preparedStatement.execute();
      preparedStatement.close();
      connection.close();
  }
  public void deleteProduct(Integer productId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("update productphoto SET active =true where id=?");
        preparedStatement.setInt(1, productId);
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();
  }
  public Optional<Product> getProduct(Integer productId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM productphoto where id=?");
        preparedStatement.setInt(1, productId);
        ResultSet resultSet = preparedStatement.executeQuery();
      Product product = new Product();
        if (resultSet.next()) {
            product.setName(resultSet.getString("name"));
            product.setPrice(resultSet.getDouble("price"));
            product.setQuantity(resultSet.getInt("quantity"));
            product.setActive(resultSet.getBoolean("active"));
            product.setImage(resultSet.getBytes("photo"));
            product.setCategory_id(resultSet.getInt("category_id"));
            product.setId(resultSet.getInt("id"));

        }
        if (productId == null) {
            return Optional.empty();
        }
      return Optional.of(product);
  }


    public void updateProductId(Integer id, Integer quantity) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE productphoto SET quantity=quantity-?,active=? where id=?");
        preparedStatement.setInt(1, quantity);
        preparedStatement.setBoolean(2, false);
        preparedStatement.setInt(3, id);
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();
    }

    public void updateProductAdd(Integer productId, Integer quantity) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("update productphoto set quantity=quantity+? where id=?");
        preparedStatement.setInt(1, quantity);
        preparedStatement.setInt(2, productId);
        preparedStatement.execute();
        preparedStatement.close();
        connection.close();

    }
}
