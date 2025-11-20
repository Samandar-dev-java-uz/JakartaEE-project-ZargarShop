package org.example.jakartaeephotosavedb.db;

import com.zaxxer.hikari.HikariDataSource;
import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.User;
import org.example.jakartaeephotosavedb.entity.enums.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDb {
    public static UserDb getUserDb;
    private UserDb() {
    }
    public static UserDb getInstance() {
        if (UserDb.getUserDb == null) {
            UserDb.getUserDb = new UserDb();

        }
        return getUserDb;

    }



    public static void saveUser(User user) throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("insert into users(name,email,password,role) values (?,?,?,?)");
        preparedStatement.setString(1, user.getName());
        preparedStatement.setString(2, user.getEmail());
        preparedStatement.setString(3, user.getPassword());
        preparedStatement.setString(4, user.getRole().name());
        preparedStatement.execute();
        connection.close();

    }

    public Optional<User> findUser(String email, String password) throws SQLException {
        Connection dbConfig =  DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = dbConfig.prepareStatement("select * from users where email=? and password=? and active = false");
        preparedStatement.setString(1, email);
        preparedStatement.setString(2, password);
        ResultSet resultSet = preparedStatement.executeQuery();
        User user = new User();
        if (resultSet.next()) {

            user.setId(resultSet.getInt("id"));
            user.setName(resultSet.getString("name"));
            user.setEmail(resultSet.getString("email"));
            user.setPassword(resultSet.getString("password"));
            user.setRole(Role.valueOf(resultSet.getString("role")));


        }
        return Optional.of(user);
    }
    public List<User> findAllUsers() throws SQLException {
        Connection connection = DbConfig.getDataSource().getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement("select * from users where active = false");
        ResultSet resultSet = preparedStatement.executeQuery();
        List<User> users = new ArrayList<>();
        while (resultSet.next()) {
            User user = new User();
            user.setId(resultSet.getInt("id"));
            user.setName(resultSet.getString("name"));
            user.setEmail(resultSet.getString("email"));
            user.setPassword(resultSet.getString("password"));
            user.setRole(Role.valueOf(resultSet.getString("role")));
            users.add(user);
        }
        return users;

    }
}
