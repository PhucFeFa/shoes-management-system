/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.models;

/**
 *
 * @author pts03
 */
public class CartItem {

    private String productName;
    private String imageUrl;
    private double price;
    private int quantity;
    private String productVariantId;

    public CartItem() {}

    public CartItem(String productName, String imageUrl, double price, int quantity, String productVariantId) {
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
        this.productVariantId = productVariantId;
    }

    public String getProductName() { return productName; }
    public String getImageUrl() { return imageUrl; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public String getProductVariantId() { return productVariantId; }

    public void setQuantity(int quantity) { this.quantity = quantity; }
}