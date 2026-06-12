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

    public List<Order> getOrdersByUser(String userId, String statusFilter, int page) {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * PAGE_SIZE;

        StringBuilder sql = new StringBuilder(
            "SELECT o.id, o.user_id, o.address_id, o.total_amount, o.status, o.voucher_id, o.created_at, "
          + "u.full_name AS customer_full_name, u.email AS customer_email "
          + "FROM orders o "
          + "JOIN users u ON o.user_id = u.id "
          + "WHERE o.user_id = ? "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }

        sql.append("ORDER BY o.created_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            ps.setString(idx++, userId);

            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter);
            }

            ps.setInt(idx++, offset);
            ps.setInt(idx, PAGE_SIZE);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setUserId(rs.getString("user_id"));
                order.setAddressId(rs.getString("address_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setVoucherId(rs.getString("voucher_id"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setCustomerFullName(rs.getString("customer_full_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public int countOrdersByUser(String userId, String statusFilter) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM orders o WHERE o.user_id = ? "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            ps.setString(idx++, userId);

            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx, statusFilter);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

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

            int idx = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx++, "%" + keyword + "%");
            }
            ps.setInt(idx++, offset);
            ps.setInt(idx, PAGE_SIZE);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setUserId(rs.getString("user_id"));
                order.setAddressId(rs.getString("address_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setVoucherId(rs.getString("voucher_id"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setCustomerFullName(rs.getString("customer_full_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public int countAllOrders(String statusFilter, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM orders o JOIN users u ON o.user_id = u.id WHERE 1=1 ");

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
        }

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
                ps.setString(idx, "%" + keyword + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
