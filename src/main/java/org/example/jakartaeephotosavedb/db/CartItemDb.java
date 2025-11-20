package org.example.jakartaeephotosavedb.db;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartItemDb {

    private static CartItemDb cartItemDb;
    private CartItemDb(){}
    public static CartItemDb getCartItem() {
        if (cartItemDb == null) {
            cartItemDb = new CartItemDb();
        }
        return cartItemDb;
    }
    public void save(Integer quantity, Integer productId, Integer cartId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO cartItem (cart_id,product_id,quantity) VALUES (?,?,?)");
        preparedStatement.setInt(1, cartId);
        preparedStatement.setInt(2, productId);
        preparedStatement.setInt(3, quantity);
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
    }


    public List<CartItem> getAllCart(Integer cartId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM cartItem WHERE cart_id = ? and status =false ");
        preparedStatement.setInt(1, cartId);
        ResultSet resultSet = preparedStatement.executeQuery();
        ProductDb instance = ProductDb.getInstance();
        while (resultSet.next()) {

            CartItem cartItem = new CartItem();
            cartItem.setId(resultSet.getInt("id"));
            cartItem.setCart_id(resultSet.getInt("cart_id"));
            cartItem.setQuantity(resultSet.getInt("quantity"));
            cartItem.setProduct(instance.getProduct(resultSet.getInt("product_id")).get());
            cartItems.add(cartItem);
        }
        preparedStatement.close();
        connection.close();
        return cartItems;

    }

    public void remove(Integer cartItemId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE cartItem SET status = TRUE WHERE id = ?");
        preparedStatement.setInt(1, cartItemId);
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
    }

    public void getCartUp(Integer cartId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE cartItem set status = true where cart_id = ?");
        preparedStatement.setInt(1, cartId);
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();
    }
}
