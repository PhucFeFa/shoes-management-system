package com.mycompany.shoestore.dto;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

public class ImportDTO {
    private int importID;
    private String staffID;       // ID người nhập đơn
    private String supplier;     // Nhà cung cấp
    private BigDecimal totalAmount; // Tổng tiền
    private OffsetDateTime orderDate; // Ngày nhập đơn
    private String status;       // Trạng thái đơn

    public ImportDTO() {
    }

    public ImportDTO(int importID, String staffID, String supplier, BigDecimal totalAmount, OffsetDateTime orderDate, String status) {
        this.importID = importID;
        this.staffID = staffID;
        this.supplier = supplier;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
    }

    // Getter và Setter
    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }

    public String getStaffID() { return staffID; }
    public void setStaffID(String staffID) { this.staffID = staffID; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public OffsetDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(OffsetDateTime orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}