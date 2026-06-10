// Author: PhucLHCE191132
package com.mycompany.shoestore.models;

import java.sql.Timestamp;

public class ProductImage {
    private String id;
    private String productId;
    private String imageUrl;
    private int sortOrder;
    private Timestamp createdAt;

    public ProductImage() {
    }

    public ProductImage(String id, String productId, String imageUrl, int sortOrder, Timestamp createdAt) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.sortOrder = sortOrder;
        this.createdAt = createdAt;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
