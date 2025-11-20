package org.example.jakartaeephotosavedb.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jakartaeephotosavedb.db.CartDb;
import org.example.jakartaeephotosavedb.db.CartItemDb;
import org.example.jakartaeephotosavedb.db.ProductDb;
import org.example.jakartaeephotosavedb.entity.Cart;
import org.example.jakartaeephotosavedb.entity.CartItem;
import org.example.jakartaeephotosavedb.entity.Product;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CartService {
        private static CartService cartService;
        private CartService() {}
        public static CartService getCartService() {
            if (cartService == null) {
                cartService = new CartService();

            }
            return cartService;
        }
    public void AddCart(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {

        Integer userId = UserId(req,resp);
        Integer quantity = Integer.parseInt(req.getParameter("quantity"));
        Integer productId = Integer.parseInt(req.getParameter("id"));
        CartDb cartDb = CartDb.getInstance();
        Integer cartId = cartDb.AddCart(userId);
        CartItemDb cartItemDb = CartItemDb.getCartItem();
        cartItemDb.save(quantity,productId,cartId);
        ProductService productService = ProductService.getInstance();
        productService.productUpdate(productId,quantity);
        resp.sendRedirect("/homeUser");

    }
    private Integer UserId(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect("index.jsp");

        }
        Integer userId = (Integer) session.getAttribute("userId");
        return userId;
    }


    public void getAllTakeProduct(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        Integer userId = UserId(req, resp);
        CartDb cartDb = CartDb.getInstance();
        Integer cartId = cartDb.AddCart(userId);
        CartItemDb cartItemDb = CartItemDb.getCartItem();
        List<CartItem> carts = cartItemDb.getAllCart(cartId);
        Cart cart = new Cart();
        cart.setCartItems(carts);
        cart.setId(cartId);
        cart.setUser_id(userId);
        req.setAttribute("cart",cart);
        req.getRequestDispatcher("user-cart.jsp").forward(req,resp);
        return;
    }

    public void remove(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String id = req.getParameter("cartItemId");
        Integer cartItemId = Integer.parseInt(id);
        String quantity = req.getParameter("quantity");
        Integer quantity1 = Integer.parseInt(quantity);
        String id1 = req.getParameter("productId");
        Integer productId = Integer.parseInt(id1);
        ProductDb productDb = ProductDb.getInstance();
        productDb.updateProductAdd(productId,quantity1);
        CartItemDb cartItemDb = CartItemDb.getCartItem();
        cartItemDb.remove(cartItemId);
        resp.sendRedirect("/product-cart");

    }
}
