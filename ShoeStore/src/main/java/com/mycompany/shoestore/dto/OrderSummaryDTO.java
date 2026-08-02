package com.mycompany.shoestore.dto;

import com.mycompany.shoestore.models.Order;

public class OrderSummaryDTO extends Order {
    private String paymentMethod;
    private String paymentStatus;

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public String getFullAddress() {
        return getShippingAddress();
    }
}
