package org.example.jakartaeephotosavedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Product {
    private Integer category_id;
    private Integer id;
    private String name ;
    private Double price;
    private Integer quantity;
    private Boolean active;
    private byte[] image;
}
