// Author: baolgce191178
package com.mycompany.shoestore.models;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private String id;
    private String userId;
    private String addressId;
    private BigDecimal totalAmount;
    private String status;
    private String voucherId;
    private Timestamp createdAt;
    private String customerFullName;
    private String customerEmail;

    public Order() {}

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getAddressId() { return addressId; }
    public void setAddressId(String addressId) { this.addressId = addressId; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getVoucherId() { return voucherId; }
    public void setVoucherId(String voucherId) { this.voucherId = voucherId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getCustomerFullName() { return customerFullName; }
    public void setCustomerFullName(String customerFullName) { this.customerFullName = customerFullName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
}
