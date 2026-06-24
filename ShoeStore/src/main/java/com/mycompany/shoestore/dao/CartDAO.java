package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.CartItem;
import java.sql.*;
import java.util.*;

public class CartDAO {

    DBContext db = new DBContext();

    public String getDefaultVariantId(String productId) throws Exception {
        String sql = "SELECT TOP 1 id FROM product_variants WHERE product_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("id");
            }
        }
        return null;
    }

    // GET CART ID
    public String getCartId(String userId) throws Exception {
        String sql = "SELECT id FROM carts WHERE user_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("id");
            }
        }
        return null;
    }

    // CREATE CART
    public String createCart(String userId) throws Exception {
        String cartId = UUID.randomUUID().toString();
        String sql = "INSERT INTO carts(id, user_id) VALUES (?, ?)";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cartId);
            ps.setString(2, userId);
            ps.executeUpdate();
        }
        return cartId;
    }

    // ADD TO CART
    public void addToCart(String userId, String variantId, int qty) throws Exception {
        String cartId = getCartId(userId);
        if (cartId == null) {
            cartId = createCart(userId);
        }

        try (Connection conn = db.getConnection()) {
            String check = "SELECT quantity FROM cart_items WHERE cart_id = ? AND product_variant_id = ?";
            PreparedStatement ps = conn.prepareStatement(check);
            ps.setString(1, cartId);
            ps.setString(2, variantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String update = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_id = ? AND product_variant_id = ?";
                PreparedStatement up = conn.prepareStatement(update);
                up.setInt(1, qty);
                up.setString(2, cartId);
                up.setString(3, variantId);
                up.executeUpdate();
            } else {
                String insert = "INSERT INTO cart_items(id, cart_id, product_variant_id, quantity) VALUES (NEWID(), ?, ?, ?)";
                PreparedStatement in = conn.prepareStatement(insert);
                in.setString(1, cartId);
                in.setString(2, variantId);
                in.setInt(3, qty);
                in.executeUpdate();
            }
        }
    }

    public CartItem getCartItemByVariant(String userId, String variantId) throws Exception {
        String sql = "SELECT p.name, p.price, pv.id AS variant_id, " +
                     "pv.size, pv.color, pi.image_url, ci.quantity " +
                     "FROM carts c " +
                     "JOIN cart_items ci ON c.id = ci.cart_id " +
                     "JOIN product_variants pv ON ci.product_variant_id = pv.id " +
                     "JOIN products p ON pv.product_id = p.id " +
                     "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.sort_order = 1 " +
                     "WHERE c.user_id = ? AND pv.id = ?";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new CartItem(
                            rs.getString("name"),
                            rs.getString("image_url"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            rs.getString("variant_id"),
                            rs.getString("size"),
                            rs.getString("color")
                    );
                }
            }
        }
        return null;
    }

    public List<CartItem> getCart(String userId) throws Exception {
        String sql = "SELECT p.name, p.price, pv.id AS variant_id, " +
                     "pv.size, pv.color, pi.image_url, ci.quantity " +
                     "FROM carts c " +
                     "JOIN cart_items ci ON c.id = ci.cart_id " +
                     "JOIN product_variants pv ON ci.product_variant_id = pv.id " +
                     "JOIN products p ON pv.product_id = p.id " +
                     "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.sort_order = 1 " +
                     "WHERE c.user_id = ?";

        List<CartItem> list = new ArrayList<>();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem(
                        rs.getString("name"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("variant_id"),
                        rs.getString("size"),
                        rs.getString("color")
                );
                list.add(item);
            }
        }
        return list;
    }

    public int getCartTotalQuantity(String userId) throws Exception {
        String sql = "SELECT SUM(quantity) as total FROM carts c "
                + "JOIN cart_items ci ON c.id = ci.cart_id "
                + "WHERE c.user_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    public void removeItem(String userId, String variantId) throws Exception {
        String cartId = getCartId(userId);
        if (cartId == null) return;

        String sql = "DELETE FROM cart_items WHERE cart_id = ? AND product_variant_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cartId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public void increaseQuantity(String userId, String variantId) throws Exception {
        String sql = "UPDATE ci SET ci.quantity = ci.quantity + 1 " +
                     "FROM cart_items ci JOIN carts c ON ci.cart_id = c.id " +
                     "WHERE c.user_id = ? AND ci.product_variant_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public void decreaseQuantity(String userId, String variantId) throws Exception {
        String update = "UPDATE ci SET ci.quantity = ci.quantity - 1 " +
                        "FROM cart_items ci JOIN carts c ON ci.cart_id = c.id " +
                        "WHERE c.user_id = ? AND ci.product_variant_id = ? AND ci.quantity > 1";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(update)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                String delete = "DELETE ci FROM cart_items ci " +
                                "JOIN carts c ON ci.cart_id = c.id " +
                                "WHERE c.user_id = ? AND ci.product_variant_id = ?";
                try (PreparedStatement del = conn.prepareStatement(delete)) {
                    del.setString(1, userId);
                    del.setString(2, variantId);
                    del.executeUpdate();
                }
            }
        }
    }

    public void removeCartItem(String userId, String variantId) throws Exception {
        String sql = "DELETE ci FROM cart_items ci " +
                     "JOIN carts c ON ci.cart_id = c.id " +
                     "WHERE c.user_id = ? AND ci.product_variant_id = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    /* ================== HÀM MỚI TỪ BRANCH PAYMENT_BY_COD ================== */
    public int getVariantStock(String variantId) throws Exception {
        String sql = "SELECT stock_quantity FROM product_variants WHERE id = ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, variantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock_quantity");
            }
        }
        return 0;
    }

    public void updateProductStock(String variantId, int quantity) throws Exception {
        String sql = "UPDATE product_variants SET stock_quantity = stock_quantity - ? WHERE id = ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public boolean updateProductNegativeStock(String variantId, int quantity) throws Exception {
        String sql = "UPDATE product_variants SET stock_quantity = stock_quantity - ? " +
                     "WHERE id = ? AND stock_quantity >= ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, variantId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }
}