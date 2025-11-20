package org.example.jakartaeephotosavedb.db;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDb {
    private static OrderDb instance;
    public static OrderDb getInstance() {
        if (instance == null) {
            instance = new OrderDb();
        }
        return instance;
    }
    private OrderDb() {}


    public Integer save(Integer Id, Double price) throws SQLException {

            Integer newOrderId = null;
            String sql = "INSERT INTO orders (user_id, total_price) VALUES (?, ?)";

            try (Connection connection = DbConfig.getDataSource().getConnection();
                 PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, Id);
                ps.setDouble(2, price);
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    newOrderId = rs.getInt(1);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            return newOrderId;
        }


    public List<Order> getAllOrders(Integer id) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM orders WHERE user_id =?  and status =false");
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        List<Order> orders = new ArrayList<>();
        while (resultSet.next()) {
            Order order = new Order();
            order.setId(resultSet.getInt("id"));
            order.setUserId(resultSet.getInt("user_id"));
            order.setDate(resultSet.getDate("date").toLocalDate().atStartOfDay());
            order.setStatus(resultSet.getBoolean("status"));
            order.setTotal(resultSet.getDouble("total_price"));
            orders.add(order);

        }
        return orders;
    }

    public void returnOrder(Integer orderId) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("UPDATE orders SET status =true WHERE id = ?");
        preparedStatement.setInt(1, orderId);
        preparedStatement.executeUpdate();
        preparedStatement.close();
        connection.close();

    }
}
