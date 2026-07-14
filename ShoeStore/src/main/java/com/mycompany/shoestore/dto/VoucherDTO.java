package com.mycompany.shoestore.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

public class VoucherDTO implements Serializable {
    private String id;
    private String code;
    private String discountType; // PERCENTAGE or FIXED_AMOUNT
    private BigDecimal discountValue;
    private BigDecimal maxDiscountAmount;
    private OffsetDateTime startDate;
    private OffsetDateTime endDate;
    private int quantity;
    private int usedQuantity;

    public VoucherDTO() {
    }

    public VoucherDTO(String id, String code, String discountType, BigDecimal discountValue, BigDecimal maxDiscountAmount, OffsetDateTime startDate, OffsetDateTime endDate, int quantity, int usedQuantity) {
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

    public BigDecimal getDiscountValue() { return discountValue; }
    public void setDiscountValue(BigDecimal discountValue) { this.discountValue = discountValue; }

    public BigDecimal getMaxDiscountAmount() { return maxDiscountAmount; }
    public void setMaxDiscountAmount(BigDecimal maxDiscountAmount) { this.maxDiscountAmount = maxDiscountAmount; }

    public OffsetDateTime getStartDate() { return startDate; }
    public void setStartDate(OffsetDateTime startDate) { this.startDate = startDate; }

    public OffsetDateTime getEndDate() { return endDate; }
    public void setEndDate(OffsetDateTime endDate) { this.endDate = endDate; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getUsedQuantity() { return usedQuantity; }
    public void setUsedQuantity(int usedQuantity) { this.usedQuantity = usedQuantity; }
}
