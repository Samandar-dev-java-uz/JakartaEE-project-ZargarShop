package org.example.jakartaeephotosavedb.db;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.CartItem;
import org.example.jakartaeephotosavedb.entity.OrderItem;
import org.example.jakartaeephotosavedb.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class OrderItemDb {
    private  static OrderItemDb orderItemDb;
    private OrderItemDb() {
    }
    public static OrderItemDb getInstance() {
        if (orderItemDb == null) {
            orderItemDb = new OrderItemDb();
        }
        return orderItemDb;
    }


    public void save(Integer orderId, List<CartItem> cartItems) {
        String sql = "INSERT INTO ordersitems (order_id, product_id, quantity) VALUES (?, ?, ?)";

        try (Connection connection = DbConfig.getDataSource().getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            for (CartItem item : cartItems) {
                Product product = item.getProduct();
                ps.setInt(1, orderId);
                    ps.setInt(2, product.getId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();

            }

            ps.executeBatch();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderItem> getAllOrderItem(Integer orderId) throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();

        try (Connection connection = DbConfig.getDataSource().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT * FROM ordersitems WHERE order_id = ?"
             )) {

            preparedStatement.setInt(1, orderId);


            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setId(resultSet.getInt("id"));
                    orderItem.setQuantity(resultSet.getInt("quantity"));

                    // Productni olish va null tekshirish
                    Optional<Product> productOpt = ProductDb.getInstance().getProduct(resultSet.getInt("product_id"));
                    productOpt.ifPresent(orderItem::setProduct);

                    orderItems.add(orderItem);
                }

            }
        }

        return orderItems;
    }

}
