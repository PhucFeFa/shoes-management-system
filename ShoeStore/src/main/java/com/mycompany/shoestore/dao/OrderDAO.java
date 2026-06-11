// Author: baolgce191178
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final int PAGE_SIZE = 10;

    public List<Order> getAllOrders(String statusFilter, String keyword, int page) {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * PAGE_SIZE;

        StringBuilder sql = new StringBuilder(
            "SELECT o.id, o.user_id, o.address_id, o.total_amount, o.status, o.voucher_id, o.created_at, "
          + "u.full_name AS customer_full_name, u.email AS customer_email "
          + "FROM orders o "
          + "JOIN users u ON o.user_id = u.id "
          + "WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
        }

        sql.append("ORDER BY o.created_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, statusFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, like);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, PAGE_SIZE);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getString("id"));
                    o.setUserId(rs.getString("user_id"));
                    o.setAddressId(rs.getString("address_id"));
                    o.setTotalAmount(rs.getDouble("total_amount"));
                    o.setStatus(rs.getString("status"));
                    o.setVoucherId(rs.getString("voucher_id"));
                    o.setCreatedAt(rs.getTimestamp("created_at"));
                    o.setCustomerFullName(rs.getString("customer_full_name"));
                    o.setCustomerEmail(rs.getString("customer_email"));
                    orders.add(o);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getAllOrders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    public int countAllOrders(String statusFilter, String keyword) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) "
          + "FROM orders o "
          + "JOIN users u ON o.user_id = u.id "
          + "WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, statusFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex, like);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.err.println("Error countAllOrders: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getPageSize() {
        return PAGE_SIZE;
    }
}
