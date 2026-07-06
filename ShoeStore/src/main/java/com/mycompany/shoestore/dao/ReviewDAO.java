// Author: PhucLHCE191132
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // Lấy danh sách đánh giá của 1 sản phẩm
    public List<Review> getReviewsByProduct(String productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.product_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setId(rs.getString("id"));
                    r.setUserId(rs.getString("user_id"));
                    r.setProductId(rs.getString("product_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getString("comment"));
                    r.setPreviousComment(rs.getString("previous_comment"));
                    r.setUpdatedAt(rs.getTimestamp("updated_at"));
                    r.setUpdated(rs.getBoolean("is_updated"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    r.setUserName(rs.getString("full_name"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy đánh giá của một user cụ thể cho 1 sản phẩm (để check xem đã review chưa)
    public Review getReviewByUserAndProduct(String userId, String productId) {
        String sql = "SELECT * FROM reviews WHERE user_id = ? AND product_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Review r = new Review();
                    r.setId(rs.getString("id"));
                    r.setUserId(rs.getString("user_id"));
                    r.setProductId(rs.getString("product_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getString("comment"));
                    r.setPreviousComment(rs.getString("previous_comment"));
                    r.setUpdatedAt(rs.getTimestamp("updated_at"));
                    r.setUpdated(rs.getBoolean("is_updated"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    return r;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra xem user có được quyền review không (đã mua và đơn hàng hoàn thành)
    public boolean canUserReview(String userId, String productId) {
        String sql = "SELECT COUNT(*) FROM orders o " +
                     "JOIN order_items oi ON o.id = oi.order_id " +
                     "JOIN product_variants pv ON oi.product_variant_id = pv.variant_id " +
                     "WHERE o.user_id = ? AND pv.product_id = ? AND o.status = 'completed'";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setString(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm mới đánh giá
    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, product_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, review.getUserId());
            ps.setString(2, review.getProductId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật đánh giá
    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, comment = ?, previous_comment = ?, updated_at = SYSDATETIMEOFFSET(), is_updated = 1 WHERE id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setString(3, review.getPreviousComment());
            ps.setString(4, review.getId());
            ps.setString(5, review.getUserId()); // Đảm bảo chỉ người tạo mới được update
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa đánh giá
    public boolean deleteReview(String id, String userId) {
        String sql = "DELETE FROM reviews WHERE id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, userId); // Đảm bảo chỉ người tạo mới được xóa
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
