/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.models;


import java.math.BigDecimal;
import java.time.OffsetDateTime;

public class Import {
    private int importID;       // Khớp với ImportID (INT IDENTITY)
    private String supplier;    // Khớp với Supplier (NVARCHAR)
    private String userID;      // Khớp với UserID (UNIQUEIDENTIFIER -> String trong Java)
    private OffsetDateTime orderDate; // Khớp với OrderDate (DATETIMEOFFSET)
    private BigDecimal totalAmount;   // Khớp với TotalAmount (DECIMAL)
    private String status;      // Khớp với Status (NVARCHAR)
    private String note;        // Khớp với Note (NVARCHAR(MAX))

    // Constructor không tham số (Bắt buộc phải có)
    public Import() {
    }

    // Constructor có tham số để tiện khởi tạo nhanh
    public Import(int importID, String supplier, String userID, OffsetDateTime orderDate, BigDecimal totalAmount, String status, String note) {
        this.importID = importID;
        this.supplier = supplier;
        this.userID = userID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.note = note;
    }

    // Getter và Setter
    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public OffsetDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(OffsetDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Import{" +
                "importID=" + importID +
                ", supplier='" + supplier + '\'' +
                ", userID='" + userID + '\'' +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", note='" + note + '\'' +
                '}';
    }
}
