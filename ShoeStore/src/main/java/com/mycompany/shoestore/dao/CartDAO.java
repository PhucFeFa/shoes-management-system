package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.CartItem;

import java.sql.*;
import java.util.*;

public class CartDAO {

    DBContext db = new DBContext();

    public String getDefaultVariantId(String productId) throws Exception {

        String sql
                = "SELECT TOP 1 id "
                + "FROM product_variants "
                + "WHERE product_id = ?";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try ( Connection conn = db.getConnection()) {

            String check = "SELECT quantity FROM cart_items\n"
                    + "                WHERE cart_id = ? AND product_variant_id = ?";

            PreparedStatement ps = conn.prepareStatement(check);
            ps.setString(1, cartId);
            ps.setString(2, variantId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String update = "UPDATE cart_items\n"
                        + "                    SET quantity = quantity + ?\n"
                        + "                    WHERE cart_id = ? AND product_variant_id = ?";

                PreparedStatement up = conn.prepareStatement(update);
                up.setInt(1, qty);
                up.setString(2, cartId);
                up.setString(3, variantId);
                up.executeUpdate();

            } else {

                String insert = "INSERT INTO cart_items(id, cart_id, product_variant_id, quantity)\n"
                        + "                    VALUES (NEWID(), ?, ?, ?)";

                PreparedStatement in = conn.prepareStatement(insert);
                in.setString(1, cartId);
                in.setString(2, variantId);
                in.setInt(3, qty);
                in.executeUpdate();
            }
        }
    }

    // GET CART ITEMS
    public List<CartItem> getCart(String userId) throws Exception {

        String sql = "SELECT p.name, p.price, pv.id AS variant_id,\n"
                + "                   pi.image_url, ci.quantity\n"
                + "            FROM carts c\n"
                + "            JOIN cart_items ci ON c.id = ci.cart_id\n"
                + "            JOIN product_variants pv ON ci.product_variant_id = pv.id\n"
                + "            JOIN products p ON pv.product_id = p.id\n"
                + "            LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.sort_order = 1\n"
                + "            WHERE c.user_id = ?";

        List<CartItem> list = new ArrayList<>();

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(new CartItem(
                        rs.getString("name"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("variant_id")
                ));
            }
        }

        return list;
    }

    // GET CART TOTAL QUANTITY
    public int getCartTotalQuantity(String userId) throws Exception {
        String sql = "SELECT SUM(quantity) as total FROM carts c " +
                     "JOIN cart_items ci ON c.id = ci.cart_id " +
                     "WHERE c.user_id = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    // REMOVE ITEM
    public void removeItem(String userId, String variantId) throws Exception {

        String cartId = getCartId(userId);

        String sql = "DELETE FROM cart_items\n"
                + "            WHERE cart_id = ? AND product_variant_id = ?";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cartId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        }
    }

    public void increaseQuantity(String userId,
            String variantId) throws Exception {

        String sql
                = "UPDATE ci "
                + "SET ci.quantity = ci.quantity + 1 "
                + "FROM cart_items ci "
                + "JOIN carts c ON ci.cart_id = c.id "
                + "WHERE c.user_id = ? "
                + "AND ci.product_variant_id = ?";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, variantId);

            ps.executeUpdate();
        }
    }

    public void decreaseQuantity(String userId,
            String variantId) throws Exception {

        String update
                = "UPDATE ci "
                + "SET ci.quantity = ci.quantity - 1 "
                + "FROM cart_items ci "
                + "JOIN carts c ON ci.cart_id = c.id "
                + "WHERE c.user_id = ? "
                + "AND ci.product_variant_id = ? "
                + "AND ci.quantity > 1";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(update)) {

            ps.setString(1, userId);
            ps.setString(2, variantId);

            int rows = ps.executeUpdate();

            if (rows == 0) {

                String delete
                        = "DELETE ci "
                        + "FROM cart_items ci "
                        + "JOIN carts c ON ci.cart_id = c.id "
                        + "WHERE c.user_id = ? "
                        + "AND ci.product_variant_id = ?";

                PreparedStatement del
                        = conn.prepareStatement(delete);

                del.setString(1, userId);
                del.setString(2, variantId);

                del.executeUpdate();
            }
        }
    }
    public void removeCartItem(String userId,
                           String variantId) throws Exception {

    String sql =
        "DELETE ci " +
        "FROM cart_items ci " +
        "JOIN carts c ON ci.cart_id = c.id " +
        "WHERE c.user_id = ? " +
        "AND ci.product_variant_id = ?";

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, userId);
        ps.setString(2, variantId);

        ps.executeUpdate();
    }
}
}
