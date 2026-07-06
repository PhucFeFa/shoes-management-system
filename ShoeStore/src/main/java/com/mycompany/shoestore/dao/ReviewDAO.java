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

    // Lấy danh sách đánh giá của 1 sản phẩm (chỉ hiển thị những đánh giá VISIBLE)
    public List<Review> getReviewsByProduct(String productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name AS user_name, s.full_name AS replier_name " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "LEFT JOIN staffs s ON r.replied_by = s.id " +
                     "WHERE r.product_id = ? AND r.moderation_status = 'VISIBLE' " +
                     "ORDER BY r.created_at DESC";
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
                    r.setUserName(rs.getString("user_name"));
                    r.setModerationStatus(rs.getString("moderation_status"));
                    r.setHideReason(rs.getString("hide_reason"));
                    r.setReplyComment(rs.getString("reply_comment"));
                    r.setRepliedBy(rs.getString("replied_by"));
                    r.setReplyUpdatedAt(rs.getTimestamp("reply_updated_at"));
                    r.setReplierName(rs.getString("replier_name"));
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
                    r.setModerationStatus(rs.getString("moderation_status"));
                    r.setHideReason(rs.getString("hide_reason"));
                    r.setReplyComment(rs.getString("reply_comment"));
                    r.setRepliedBy(rs.getString("replied_by"));
                    r.setReplyUpdatedAt(rs.getTimestamp("reply_updated_at"));
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
                     "JOIN product_variants pv ON oi.product_variant_id = pv.id " +
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

    // Xóa đánh giá (chỉ người tạo mới được xóa, hoặc Admin qua hàm khác)
    public boolean deleteReview(String id, String userId) {
        String sql = "DELETE FROM reviews WHERE id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // --- Review Management Methods (Admin/Staff) ---

    // Lấy tất cả đánh giá cho trang quản lý
    public List<Review> getAllReviews(String filterStatus) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name AS user_name, s.full_name AS replier_name, p.name AS product_name, " +
                     "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id ORDER BY sort_order ASC) AS product_image " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN products p ON r.product_id = p.id " +
                     "LEFT JOIN staffs s ON r.replied_by = s.id ";
        if (filterStatus != null && !filterStatus.isEmpty() && !filterStatus.equals("ALL")) {
            sql += "WHERE r.moderation_status = ? ";
        }
        sql += "ORDER BY r.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (filterStatus != null && !filterStatus.isEmpty() && !filterStatus.equals("ALL")) {
                ps.setString(1, filterStatus);
            }
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
                    r.setUserName(rs.getString("user_name"));
                    r.setProductName(rs.getString("product_name"));
                    r.setProductImage(rs.getString("product_image"));
                    r.setModerationStatus(rs.getString("moderation_status"));
                    r.setHideReason(rs.getString("hide_reason"));
                    r.setReplyComment(rs.getString("reply_comment"));
                    r.setRepliedBy(rs.getString("replied_by"));
                    r.setReplyUpdatedAt(rs.getTimestamp("reply_updated_at"));
                    r.setReplierName(rs.getString("replier_name"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái kiểm duyệt (ẩn/duyệt)
    public boolean updateReviewModeration(String reviewId, String status, String reason) {
        String sql = "UPDATE reviews SET moderation_status = ?, hide_reason = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, reason);
            ps.setString(3, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật câu trả lời của cửa hàng
    public boolean updateStoreReply(String reviewId, String replyComment, String staffId) {
        String sql = "UPDATE reviews SET reply_comment = ?, replied_by = ?, reply_updated_at = SYSDATETIMEOFFSET() WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, replyComment);
            ps.setString(2, staffId);
            ps.setString(3, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Admin xóa vĩnh viễn đánh giá
    public boolean deleteReviewByAdmin(String reviewId) {
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
