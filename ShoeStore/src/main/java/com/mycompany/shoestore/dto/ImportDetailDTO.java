package com.mycompany.shoestore.dto;

import java.math.BigDecimal;

public class ImportDetailDTO {
    private int importDetailID;
    private int importID;
    private String variantID;
    private int importQuantity;
    private int receivedQuantity;
    private BigDecimal unitPrice;
    
    // Optional: Fields for display (joining with Product/Variant tables)
    private String productName;
    private String size;
    private String color;

    public ImportDetailDTO() {
    }

    public ImportDetailDTO(int importDetailID, int importID, String variantID, int importQuantity, int receivedQuantity, BigDecimal unitPrice) {
        this.importDetailID = importDetailID;
        this.importID = importID;
        this.variantID = variantID;
        this.importQuantity = importQuantity;
        this.receivedQuantity = receivedQuantity;
        this.unitPrice = unitPrice;
    }

    // Getters and Setters
    public int getImportDetailID() { return importDetailID; }
    public void setImportDetailID(int importDetailID) { this.importDetailID = importDetailID; }

    public int getImportID() { return importID; }
    public void setImportID(int importID) { this.importID = importID; }

    public String getVariantID() { return variantID; }
    public void setVariantID(String variantID) { this.variantID = variantID; }

    public int getImportQuantity() { return importQuantity; }
    public void setImportQuantity(int importQuantity) { this.importQuantity = importQuantity; }

    public int getReceivedQuantity() { return receivedQuantity; }
    public void setReceivedQuantity(int receivedQuantity) { this.receivedQuantity = receivedQuantity; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}
