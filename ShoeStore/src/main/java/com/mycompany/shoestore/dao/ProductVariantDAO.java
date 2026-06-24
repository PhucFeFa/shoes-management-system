package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.ProductVariant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO {

    /**
     * Lấy tất cả variants của một sản phẩm (dùng cho Product Detail)
     */
    public List<ProductVariant> getVariantsByProductId(String productId) throws Exception {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT id, product_id, size, color, stock_quantity " +
                     "FROM product_variants WHERE product_id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setId(rs.getString("id"));
                v.setProductId(rs.getString("product_id"));
                v.setSize(rs.getString("size"));
                v.setColor(rs.getString("color"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                list.add(v);
            }
        }
        return list;
    }

    /**
     * Lấy thông tin chi tiết 1 variant theo ID
     */
    public ProductVariant getVariantById(String variantId) throws Exception {
        String sql = "SELECT id, product_id, size, color, stock_quantity " +
                     "FROM product_variants WHERE id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, variantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ProductVariant v = new ProductVariant();
                v.setId(rs.getString("id"));
                v.setProductId(rs.getString("product_id"));
                v.setSize(rs.getString("size"));
                v.setColor(rs.getString("color"));
                v.setStockQuantity(rs.getInt("stock_quantity"));
                return v;
            }
        }
        return null;
    }

    /**
     * Lấy stock quantity theo variant ID
     */
    public int getStockByVariant(String variantId) throws Exception {
        String sql = "SELECT stock_quantity FROM product_variants WHERE id = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, variantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("stock_quantity");
            }
        }
        return 0;
    }

    /**
     * Cập nhật stock sau khi đặt hàng (trừ stock)
     */
    public boolean updateProductStock(String variantId, int quantity) throws Exception {
        String sql = "UPDATE product_variants " +
                     "SET stock_quantity = stock_quantity - ? " +
                     "WHERE id = ? AND stock_quantity >= ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setString(2, variantId);
            ps.setInt(3, quantity);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * Tìm variant ID theo product + size + color (dự phòng)
     */
    public String findVariantId(String productId, String size, String color) throws Exception {
        String sql = "SELECT id FROM product_variants " +
                     "WHERE product_id = ? AND size = ? AND color = ?";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, size);
            ps.setString(3, color);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("id");
            }
        }
        return null;
    }

    /**
     * Kiểm tra variant có tồn tại và còn hàng không
     */
    public boolean isVariantAvailable(String variantId, int requiredQuantity) throws Exception {
        int stock = getStockByVariant(variantId);
        return stock >= requiredQuantity;
    }
}