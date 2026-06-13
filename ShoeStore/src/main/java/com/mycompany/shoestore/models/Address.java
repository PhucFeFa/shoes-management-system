/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.models;

/**
 *
 * @author pts03
 */
public class Address {
    private String id;
    private String userId;
    private String city;
    private String district;
    private String ward;
    private String addressLine;

    public Address() {
    }

    public Address(String id, String userId, String city, String district, String ward, String addressLine) {
        this.id = id;
        this.userId = userId;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.addressLine = addressLine;
    }

    

    public Address(String userId, String city, String district, String ward, String addressLine) {
        this.userId = userId;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.addressLine = addressLine;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    

    

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    

    
}
