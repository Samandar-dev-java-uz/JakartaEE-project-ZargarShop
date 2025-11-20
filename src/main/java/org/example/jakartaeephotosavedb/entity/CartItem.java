package org.example.jakartaeephotosavedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.jakartaeephotosavedb.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CartItem {
    private Integer id;
    private Integer cart_id;
    private Product product;
    private Integer quantity;

}
