package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jakartaeephotosavedb.db.UserDb;
import org.example.jakartaeephotosavedb.entity.Product;
import org.example.jakartaeephotosavedb.entity.User;
import org.example.jakartaeephotosavedb.entity.enums.Role;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class UserService {
    private UserService() {
    }
    private static UserService instance;
    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();

        }
        return instance;
    }

    public void save(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        User  user = User.builder()
                .email(req.getParameter("email"))
                .password(req.getParameter("password"))
                .name(req.getParameter("username"))
                .role(Role.USER)
                .build();
        UserDb userDb = UserDb.getInstance();
        userDb.saveUser(user);
        req.getRequestDispatcher("index.jsp").forward(req,resp);

    }

    public void findUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        UserDb userDb = UserDb.getInstance();
        Optional<User> user = userDb.findUser(email, password);
        if(user.isEmpty()){
            req.getRequestDispatcher("/Log-In.jsp").forward(req,resp);
        }
        else{
            if(user.get().getRole().equals(Role.ADMIN))
            {
                List<Product> allProducts = ProductService.getInstance().getAllProducts();

                req.setAttribute("products",allProducts);
                req.getRequestDispatcher("/Admin-Profile.jsp").forward(req,resp);
            }
            else
            {
                User user1 = user.get();
                HttpSession session = req.getSession();
                session.setAttribute("userId", user1.getId());

                List<Product> allProducts = ProductService.getInstance().getAllProducts();
                req.setAttribute("products",allProducts);
            req.getRequestDispatcher("/User-Profile.jsp").forward(req,resp);
            }
        }
    }
    public void findAllUsers(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        UserDb userDb = UserDb.getInstance();
        List<User> users = userDb.findAllUsers();
       req.setAttribute("users",users);
        req.getRequestDispatcher("/information-user.jsp").forward(req, resp);
    }
}
