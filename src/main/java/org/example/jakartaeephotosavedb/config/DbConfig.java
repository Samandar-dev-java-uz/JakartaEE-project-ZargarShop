package org.example.jakartaeephotosavedb.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import lombok.Getter;

public class DbConfig {
    @Getter
    private static  HikariDataSource dataSource;
    private DbConfig () {

    }

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:postgresql://localhost:5432/photosavedb");
        config.setUsername("postgres");
        config.setPassword("root123");
        config.setMinimumIdle(100);
        config.setMaximumPoolSize(1000);
        config.setConnectionTimeout(60000);
        config.setDriverClassName("org.postgresql.Driver");
        dataSource = new HikariDataSource(config);
    }
    public static HikariDataSource getConnection() {
      if (dataSource == null) {
          dataSource = new HikariDataSource();
      }
      return dataSource;
    }
}
