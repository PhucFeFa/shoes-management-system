/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.models;


import java.math.BigDecimal;

public class ImportDetail {
    private int importDetailID;   // Khớp với ImportDetailID (INT IDENTITY)
    private int importID;         // Khớp với ImportID (INT - Khóa ngoại nối sang bảng imports)
    private String productID;     // Khớp với ProductID (UNIQUEIDENTIFIER -> String)
    private int importQuantity;   // Khớp với ImportQuantity (INT)
    private int receivedQuantity; // Khớp với ReceivedQuantity (INT)
    private BigDecimal unitPrice; // Khớp với UnitPrice (DECIMAL)

    // Constructor không tham số
    public ImportDetail() {
    }

    // Constructor có tham số
    public ImportDetail(int importDetailID, int importID, String productID, int importQuantity, int receivedQuantity, BigDecimal unitPrice) {
        this.importDetailID = importDetailID;
        this.importID = importID;
        this.productID = productID;
        this.importQuantity = importQuantity;
        this.receivedQuantity = receivedQuantity;
        this.unitPrice = unitPrice;
    }

    // Getter và Setter
    public int getImportDetailID() {
        return importDetailID;
    }

    public void setImportDetailID(int importDetailID) {
        this.importDetailID = importDetailID;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getImportQuantity() {
        return importQuantity;
    }

    public void setImportQuantity(int importQuantity) {
        this.importQuantity = importQuantity;
    }

    public int getReceivedQuantity() {
        return receivedQuantity;
    }

    public void setReceivedQuantity(int importQuantity) {
        this.receivedQuantity = importQuantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return "ImportDetail{" +
                "importDetailID=" + importDetailID +
                ", importID=" + importID +
                ", productID='" + productID + '\'' +
                ", importQuantity=" + importQuantity +
                ", receivedQuantity=" + receivedQuantity +
                ", unitPrice=" + unitPrice +
                '}';
    }
}
