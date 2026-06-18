package com.mycompany.shoestore.dto;

import com.mycompany.shoestore.models.Order;

public class OrderSummaryDTO extends Order {
    private String addressLine;
    private String ward;
    private String district;
    private String city;
    private String paymentMethod;
    private String paymentStatus;

    public String getAddressLine() { return addressLine; }
    public void setAddressLine(String addressLine) { this.addressLine = addressLine; }

    public String getWard() { return ward; }
    public void setWard(String ward) { this.ward = ward; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public String getFullAddress() {
        return String.format("%s, %s, %s, %s", addressLine, ward, district, city);
    }
}
