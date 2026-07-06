package com.mycompany.shoestore.models;

import java.sql.Timestamp;

public class OrderStaffLog {
    private String id;
    private String orderId;
    private String staffId;
    private String action;
    private Timestamp createdAt;
    
    // Join fields
    private String staffName;
    private String staffEmail;

    public OrderStaffLog() {}

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getStaffId() { return staffId; }
    public void setStaffId(String staffId) { this.staffId = staffId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }

    public String getStaffEmail() { return staffEmail; }
    public void setStaffEmail(String staffEmail) { this.staffEmail = staffEmail; }
}
