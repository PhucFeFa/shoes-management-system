
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {


    public List<VoucherDTO> getAllVouchers() {
        List<VoucherDTO> list = new ArrayList<>();
        String sql = "SELECT [id], [code], [discount_percent], [max_discount_amount], [start_date], [end_date], [quantity] FROM [vouchers]";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VoucherDTO dto = new VoucherDTO(
                        rs.getString("id"),
                        rs.getString("code"),
                        rs.getDouble("discount_percent"),
                        rs.getDouble("max_discount_amount"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date"),
                        rs.getInt("quantity")
                );
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Create
    public boolean createVoucher(VoucherDTO voucher) {
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_percent], [max_discount_amount], [start_date], [end_date], [quantity]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String uniqueId = java.util.UUID.randomUUID().toString();

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uniqueId);
            ps.setString(2, voucher.getCode().toUpperCase().trim());
            ps.setDouble(3, voucher.getDiscountPercent());
            ps.setDouble(4, voucher.getMaxDiscountAmount());
            ps.setTimestamp(5, voucher.getStartDate());
            ps.setTimestamp(6, voucher.getEndDate());
            ps.setInt(7, voucher.getQuantity());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check trùng mã Voucher Code
    public boolean isCodeExist(String code) {
        String sql = "SELECT COUNT(*) FROM [vouchers] WHERE [code] = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

