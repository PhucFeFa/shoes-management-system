package com.mycompany.shoestore.models;

public class CartItem {
    
    private String productName;
    private String imageUrl;
    private double price;
    private int quantity;
    private String productVariantId;
    private String size;
    private String color;

    public CartItem() {
    }

    public CartItem(String productName,
                    String imageUrl,
                    double price,
                    int quantity,
                    String productVariantId,
                    String size,
                    String color) {
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
        this.productVariantId = productVariantId;
        this.size = size;
        this.color = color;
    }

    // ================== GETTERS & SETTERS ==================

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(String productVariantId) {
        this.productVariantId = productVariantId;
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

    // Helper method
    public double getTotalPrice() {
        return price * quantity;
    }
}