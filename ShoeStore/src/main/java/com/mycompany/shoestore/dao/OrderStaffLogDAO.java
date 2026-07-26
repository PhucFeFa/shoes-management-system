package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.OrderStaffLog;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderStaffLogDAO {

    public boolean insertLog(String orderId, String staffId, String action) {
        String sql = "INSERT INTO order_staff_logs (order_id, staff_id, action) VALUES (?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.setString(2, staffId);
            ps.setString(3, action);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public java.util.List<OrderStaffLog> getLogs(String searchQuery) {
        java.util.List<OrderStaffLog> list = new java.util.ArrayList<>();
        String sql = "SELECT l.*, s.full_name, s.email " +
                     "FROM order_staff_logs l " +
                     "JOIN staffs s ON l.staff_id = s.id ";
        
        boolean hasSearch = searchQuery != null && !searchQuery.trim().isEmpty();
        if (hasSearch) {
            sql += "WHERE s.full_name LIKE ? OR s.email LIKE ? ";
        }
        
        sql += "ORDER BY l.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (hasSearch) {
                ps.setString(1, "%" + searchQuery.trim() + "%");
                ps.setString(2, "%" + searchQuery.trim() + "%");
            }
            
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderStaffLog log = new OrderStaffLog();
                    log.setId(rs.getString("id"));
                    log.setOrderId(rs.getString("order_id"));
                    log.setStaffId(rs.getString("staff_id"));
                    log.setAction(rs.getString("action"));
                    log.setCreatedAt(rs.getTimestamp("created_at"));
                    log.setStaffName(rs.getString("full_name"));
                    log.setStaffEmail(rs.getString("email"));
                    list.add(log);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
