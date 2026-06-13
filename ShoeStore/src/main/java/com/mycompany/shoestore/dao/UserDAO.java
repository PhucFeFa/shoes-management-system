// Author: PhucLHCE191132
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setRoleId(rs.getString("role_id"));
                user.setFullName(rs.getString("full_name"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Mange User
// View
}
