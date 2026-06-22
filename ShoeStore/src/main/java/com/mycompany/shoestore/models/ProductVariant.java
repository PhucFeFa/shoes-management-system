package com.mycompany.shoestore.models;

import java.sql.Timestamp;

public class ProductVariant {

    private String id;
    private String productId;
    private String size;
    private String color;
    private int stockQuantity;
    private Timestamp createdAt;

    public ProductVariant() {
    }

    public ProductVariant(String id,
                          String productId,
                          String size,
                          String color,
                          int stockQuantity,
                          Timestamp createdAt) {

        this.id = id;
        this.productId = productId;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
        this.createdAt = createdAt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}