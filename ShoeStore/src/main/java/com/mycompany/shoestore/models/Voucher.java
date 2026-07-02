/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.models;

/**
 *
 * @author pts03
 */
public class Voucher {
    private String id;
    private String code;
    private String discountType;
    private double discountValue;
    private Double maxDiscountAmount; // using Double to allow null
    private java.sql.Timestamp startDate;
    private java.sql.Timestamp endDate;
    private int quantity;
    private int usedQuantity;

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public Double getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(Double maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }

    public java.sql.Timestamp getStartDate() { return startDate; }
    public void setStartDate(java.sql.Timestamp startDate) { this.startDate = startDate; }

    public java.sql.Timestamp getEndDate() { return endDate; }
    public void setEndDate(java.sql.Timestamp endDate) { this.endDate = endDate; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getUsedQuantity() { return usedQuantity; }
    public void setUsedQuantity(int usedQuantity) { this.usedQuantity = usedQuantity; }
}
