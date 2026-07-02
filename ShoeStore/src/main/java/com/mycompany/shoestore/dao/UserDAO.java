
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.dto.UserDTO;
import com.mycompany.shoestore.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login(String email, String password) {
        String sql = "SELECT u.*, r.name AS role_name "
                   + "FROM users u "
                   + "JOIN roles r ON u.role_id = r.id "
                   + "WHERE u.email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                boolean isMatch = false;
                if (storedHash != null) {
                    if (storedHash.equals(password)) {
                        isMatch = true; // Match plain text (legacy)
                    } else if (storedHash.startsWith("$2a$")) {
                        try {
                            isMatch = org.mindrot.jbcrypt.BCrypt.checkpw(password, storedHash);
                        } catch (Exception ignore) {}
                    }
                }
                
                if (isMatch) {
                    User user = new User();
                    user.setId(rs.getString("id"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(storedHash);
                    user.setRoleId(rs.getString("role_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    user.setRoleName(rs.getString("role_name"));
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Mange User
    //View
    public List<UserDTO> getAllCustomers() {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT u.id, u.email, u.full_name, u.created_at, 'Active' AS status, r.name AS role_name "
                   + "FROM [users] u "
                   + "INNER JOIN [roles] r ON u.role_id = r.id "
                   + "WHERE r.name = 'Customer'";
        
        DBContext db = new DBContext();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                UserDTO dto = new UserDTO();
                dto.setId(rs.getString("id"));
                dto.setEmail(rs.getString("email"));
                dto.setFullName(rs.getString("full_name"));
                dto.setRoleName(rs.getString("role_name"));
                dto.setCreatedAt(rs.getTimestamp("created_at")); 
                dto.setStatus(rs.getString("status")); 
                
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //ChangeStatus
    public boolean changeStatus(String userId, String currentStatus) {
        // Feature disabled because 'status' column does not exist in 'users' table
        System.err.println("Cannot change status: 'status' column is missing in 'users' table.");
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(newPassword, org.mindrot.jbcrypt.BCrypt.gensalt());
        String sql = "UPDATE users SET password_hash = ? WHERE email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerUser(User user) {
        // Find the Customer role ID dynamically, assuming role name is Customer or User
        String getRoleSql = "SELECT TOP 1 id FROM roles WHERE name LIKE '%Customer%' OR name LIKE '%User%'";
        String roleId = null;
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement psRole = conn.prepareStatement(getRoleSql);
             ResultSet rs = psRole.executeQuery()) {
            if (rs.next()) {
                roleId = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (roleId == null) {
            roleId = "R03"; // fallback
        }

        String sql = "INSERT INTO users (id, email, password_hash, full_name, role_id) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(user.getPasswordHash(), org.mindrot.jbcrypt.BCrypt.gensalt());
            ps.setString(1, java.util.UUID.randomUUID().toString());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getFullName());
            ps.setString(5, roleId); 
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}