// Author: baolgce191178
package com.mycompany.shoestore.models;

import java.sql.Timestamp;

public class User {
    private String id;
    private String email;
    private String passwordHash;
    private String roleId;
    private String fullName;
    private Timestamp createdAt;
    private String roleName;
    private String status;

    public User() {
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getRoleId() { return roleId; }
    public void setRoleId(String roleId) { this.roleId = roleId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
