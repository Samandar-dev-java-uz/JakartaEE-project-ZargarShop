package org.example.jakartaeephotosavedb.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.jakartaeephotosavedb.entity.enums.Role;

import java.util.UUID;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private Integer id ;
    private String name ;
    private String email ;
    private String password ;
    private Role role;
}

