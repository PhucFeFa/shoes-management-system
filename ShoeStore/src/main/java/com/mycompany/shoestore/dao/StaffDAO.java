package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;

public class StaffDAO {

    public User checkLogin(String email, String password) throws Exception {
        String sql = "SELECT * FROM staffs WHERE email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String hash = rs.getString("password_hash");
                String status = rs.getString("status");
                
                if (!"Active".equalsIgnoreCase(status)) {
                    return null; // Blocked or inactive accounts cannot login
                }
                
                boolean isMatch = false;
                if (hash != null) {
                    if (hash.equals(password)) {
                        isMatch = true; // Legacy plain text
                    } else if (hash.startsWith("$2a$")) {
                        try {
                            isMatch = org.mindrot.jbcrypt.BCrypt.checkpw(password, hash);
                        } catch (Exception ignore) {}
                    }
                }
                
                if (isMatch) {
                    User user = new User();
                    user.setId(rs.getString("id"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setRoleName("Staff");
                    return user;
                }
            }
        }
        return null;
    }

    public java.util.List<com.mycompany.shoestore.models.Staff> getAllStaffs() throws Exception {
        java.util.List<com.mycompany.shoestore.models.Staff> staffs = new java.util.ArrayList<>();
        String sql = "SELECT * FROM staffs ORDER BY created_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                com.mycompany.shoestore.models.Staff staff = new com.mycompany.shoestore.models.Staff();
                staff.setId(rs.getString("id"));
                staff.setEmail(rs.getString("email"));
                staff.setFullName(rs.getString("full_name"));
                staff.setStatus(rs.getString("status"));
                staff.setCreatedAt(rs.getTimestamp("created_at"));
                staffs.add(staff);
            }
        }
        return staffs;
    }

    public boolean createStaff(com.mycompany.shoestore.models.Staff staff) throws Exception {
        String sql = "INSERT INTO staffs (email, password_hash, full_name, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staff.getEmail());
            ps.setString(2, staff.getPasswordHash());
            ps.setString(3, staff.getFullName());
            ps.setString(4, staff.getStatus() != null ? staff.getStatus() : "Active");
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStaff(com.mycompany.shoestore.models.Staff staff) throws Exception {
        boolean updatePassword = staff.getPasswordHash() != null && !staff.getPasswordHash().trim().isEmpty();
        String sql = updatePassword 
                ? "UPDATE staffs SET email = ?, full_name = ?, password_hash = ? WHERE id = ?"
                : "UPDATE staffs SET email = ?, full_name = ? WHERE id = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staff.getEmail());
            ps.setString(2, staff.getFullName());
            if (updatePassword) {
                ps.setString(3, staff.getPasswordHash());
                ps.setString(4, staff.getId());
            } else {
                ps.setString(3, staff.getId());
            }
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(String id, String status) throws Exception {
        String sql = "UPDATE staffs SET status = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean isEmailExist(String email, String excludeId) throws Exception {
        String sql = "SELECT id FROM staffs WHERE email = ? ";
        if (excludeId != null && !excludeId.isEmpty()) {
            sql += " AND id != ? ";
        }
        sql += " UNION SELECT id FROM users WHERE email = ?";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            if (excludeId != null && !excludeId.isEmpty()) {
                ps.setString(2, excludeId);
                ps.setString(3, email);
            } else {
                ps.setString(2, email);
            }
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
}
