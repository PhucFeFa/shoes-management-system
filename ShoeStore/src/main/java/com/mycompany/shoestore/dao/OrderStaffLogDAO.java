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
}
