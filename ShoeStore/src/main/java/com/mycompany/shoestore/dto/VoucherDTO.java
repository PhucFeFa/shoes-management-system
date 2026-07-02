/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.dto;


import java.io.Serializable;
import java.sql.Timestamp;

public class VoucherDTO implements Serializable {
    private String id;
    private String code;
    private String discountType;
    private double discountValue;
    private Double maxDiscountAmount;
    private Timestamp startDate;
    private Timestamp endDate;
    private int quantity;
    private int usedQuantity;

    public VoucherDTO() {
    }

    public VoucherDTO(String id, String code, String discountType, double discountValue, Double maxDiscountAmount, Timestamp startDate, Timestamp endDate, int quantity, int usedQuantity) {
        this.id = id;
        this.code = code;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.maxDiscountAmount = maxDiscountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.quantity = quantity;
        this.usedQuantity = usedQuantity;
    }

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

    public Timestamp getStartDate() { return startDate; }
    public void setStartDate(Timestamp startDate) { this.startDate = startDate; }

    public Timestamp getEndDate() { return endDate; }
    public void setEndDate(Timestamp endDate) { this.endDate = endDate; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getUsedQuantity() { return usedQuantity; }
    public void setUsedQuantity(int usedQuantity) { this.usedQuantity = usedQuantity; }
}