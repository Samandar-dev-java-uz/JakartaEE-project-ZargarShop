package org.example.jakartaeephotosavedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {
    private Integer id;
    private Integer userId;
    private List<OrderItem> items;
    private double total;
    private boolean status;
    private LocalDateTime date;

}
