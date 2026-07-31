package com.mycompany.shoestore.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class ImportDTO {
    // From 'imports' table
    private int importID;
    private String staffID;       
    private String supplier;     
    private BigDecimal totalAmount; 
    private Timestamp orderDate; // Đổi sang Timestamp để dễ format trên JSP
    private String status;       
    private String note;         

    private String staffName;    
    private List<ImportDetailDTO> details;

    public ImportDTO() {
    }

    public ImportDTO(int importID, String staffID, String supplier, BigDecimal totalAmount, Timestamp orderDate, String status, String note) {
        this.importID = importID;
        this.staffID = staffID;
        this.supplier = supplier;
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.status = status;
        this.note = note;
    }

    // Getters and Setters
    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }

    public String getStaffID() { return staffID; }
    public void setStaffID(String staffID) { this.staffID = staffID; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getFormattedOrderDate() {
        if (orderDate != null) {
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm");
            return orderDate.format(formatter);
        }
        return "";
    }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }

    public List<ImportDetailDTO> getDetails() { return details; }
    public void setDetails(List<ImportDetailDTO> details) { this.details = details; }
}
