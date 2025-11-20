package org.example.jakartaeephotosavedb.db;

import org.example.jakartaeephotosavedb.config.DbConfig;
import org.example.jakartaeephotosavedb.entity.Cart;
import org.example.jakartaeephotosavedb.entity.Product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDb {
    private static CartDb cartDb;
     private CartDb() {}
    public static CartDb getInstance() {
         if (cartDb == null) {
            cartDb = new CartDb();

         }
         return cartDb;
    }



    public Integer AddCart(Integer userId) throws SQLException {

            Connection connection = DbConfig.getDataSource().getConnection();

            PreparedStatement ps = connection.prepareStatement(
                    "SELECT id FROM cart WHERE user_id = ?"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Integer cartId = rs.getInt("id");
                rs.close();
                ps.close();
                connection.close();
                return cartId;
            }


            PreparedStatement insertPs = connection.prepareStatement(
                    "INSERT INTO cart (user_id) VALUES (?) RETURNING id"
            );
            insertPs.setInt(1, userId);
            ResultSet insertResult = insertPs.executeQuery();

            Integer newCartId = null;
            if (insertResult.next()) {
                newCartId = insertResult.getInt("id");
            }

            insertResult.close();
            insertPs.close();
            connection.close();

            return newCartId;


    }


}
