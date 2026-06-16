/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.dto;

import java.sql.Timestamp;

public class UserDTO {
    private String id;
    private String email;
    private String fullName;
    private String roleName;
    private Timestamp createdAt;

    public UserDTO() {
    }

    public UserDTO(String id, String email, String fullName, String roleName, Timestamp createdAt) {
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.roleName = roleName;
        this.createdAt = createdAt;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
