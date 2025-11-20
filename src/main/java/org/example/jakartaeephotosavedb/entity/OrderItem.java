package org.example.jakartaeephotosavedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderItem {
    private int id;
    private int orderId;
    private Product product;
    private int quantity;
}
