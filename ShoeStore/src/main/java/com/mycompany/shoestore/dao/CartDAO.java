package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.CartItem;

import java.sql.*;
import java.util.*;

public class CartDAO {

    DBContext db = new DBContext();

    public String getDefaultVariantId(String productId) throws Exception {
        String sql = "SELECT TOP 1 id FROM product_variants WHERE product_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("id");
            }
        }
        return null;
    }

    public void addToCart(String userId, String variantId, int qty) throws Exception {
        try (Connection conn = db.getConnection()) {
            String check = "SELECT quantity FROM carts WHERE user_id = ? AND product_variant_id = ?";
            PreparedStatement ps = conn.prepareStatement(check);
            ps.setString(1, userId);
            ps.setString(2, variantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String update = "UPDATE carts SET quantity = quantity + ? WHERE user_id = ? AND product_variant_id = ?";
                PreparedStatement up = conn.prepareStatement(update);
                up.setInt(1, qty);
                up.setString(2, userId);
                up.setString(3, variantId);
                up.executeUpdate();
            } else {
                String insert = "INSERT INTO carts(id, user_id, product_variant_id, quantity) VALUES (NEWID(), ?, ?, ?)";
                PreparedStatement in = conn.prepareStatement(insert);
                in.setString(1, userId);
                in.setString(2, variantId);
                in.setInt(3, qty);
                in.executeUpdate();
            }
        }
    }

    public CartItem getCartItemByVariant(String userId, String variantId) throws Exception {
        String sql = "SELECT p.name, p.price, pv.id as variant_id, pv.size, pv.color, pi.image_url, c.quantity "
                + "FROM carts c "
                + "JOIN product_variants pv ON c.product_variant_id = pv.id "
                + "JOIN products p ON pv.product_id = p.id "
                + "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.sort_order = 1 "
                + "WHERE c.user_id = ? AND pv.id = ?";

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
        String sql = "SELECT p.name, p.price, pv.id as variant_id, pv.size, pv.color, pi.image_url, c.quantity " +
                     "FROM carts c " +
                     "JOIN product_variants pv ON c.product_variant_id = pv.id " +
                     "JOIN products p ON pv.product_id = p.id " +
                     "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.sort_order = 1 " +
                     "WHERE c.user_id = ?";

        List<CartItem> list = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public void removeItem(String userId, String variantId) throws Exception {
        String sql = "DELETE FROM carts WHERE user_id = ? AND product_variant_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public void increaseQuantity(String userId, String variantId) throws Exception {
        String sql = "UPDATE carts SET quantity = quantity + 1 WHERE user_id = ? AND product_variant_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public void decreaseQuantity(String userId, String variantId) throws Exception {
        String update = "UPDATE carts SET quantity = quantity - 1 WHERE user_id = ? AND product_variant_id = ? AND quantity > 1";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(update)) {
            ps.setString(1, userId);
            ps.setString(2, variantId);
            int rows = ps.executeUpdate();
            if (rows == 0) {
                String delete = "DELETE FROM carts WHERE user_id = ? AND product_variant_id = ?";
                PreparedStatement del = conn.prepareStatement(delete);
                del.setString(1, userId);
                del.setString(2, variantId);
                del.executeUpdate();
            }
        }
    }

    public void removeCartItem(String userId, String variantId) throws Exception {
        removeItem(userId, variantId);
    }

    public int getVariantStock(String variantId) throws Exception {
        String sql = "SELECT stock_quantity FROM product_variants WHERE id = ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
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
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public boolean updateProductNegativeStock(String variantId, int quantity) throws Exception {
        String sql = "UPDATE product_variants SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";
        try (Connection con = new DBContext().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setString(2, variantId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }
}
