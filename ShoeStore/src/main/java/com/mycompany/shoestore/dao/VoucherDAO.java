package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Voucher;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {

    private final DBContext db = new DBContext();

    // ==========================================
    // Admin operations (uses VoucherDTO)
    // ==========================================

    //View list
    public List<VoucherDTO> getAllVouchers() {
        List<VoucherDTO> list = new ArrayList<>();
        String sql = "SELECT [id], [code], [discount_type], [discount_value], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity] FROM [vouchers]";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VoucherDTO dto = new VoucherDTO(
                        rs.getString("id"),
                        rs.getString("code"),
                        rs.getString("discount_type"),
                        rs.getBigDecimal("discount_value"),
                        rs.getBigDecimal("max_discount_amount"),
                        rs.getObject("start_date", OffsetDateTime.class),
                        rs.getObject("end_date", OffsetDateTime.class),
                        rs.getInt("quantity"),
                        rs.getInt("used_quantity")
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
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_type], [discount_value], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";
        String uniqueId = java.util.UUID.randomUUID().toString();

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uniqueId);
            ps.setString(2, voucher.getCode().toUpperCase().trim());
            ps.setString(3, voucher.getDiscountType());
            ps.setBigDecimal(4, voucher.getDiscountValue());
            ps.setBigDecimal(5, voucher.getMaxDiscountAmount());
            ps.setObject(6, voucher.getStartDate());
            ps.setObject(7, voucher.getEndDate());
            ps.setInt(8, voucher.getQuantity());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //Detail
    public VoucherDTO getVoucherDTOById(String id) {
        String sql = "SELECT [id], [code], [discount_type], [discount_value], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity] FROM [vouchers] WHERE [id] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new VoucherDTO(
                            rs.getString("id"),
                            rs.getString("code"),
                            rs.getString("discount_type"),
                            rs.getBigDecimal("discount_value"),
                            rs.getBigDecimal("max_discount_amount"),
                            rs.getObject("start_date", OffsetDateTime.class),
                            rs.getObject("end_date", OffsetDateTime.class),
                            rs.getInt("quantity"),
                            rs.getInt("used_quantity")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Update
    public boolean updateVoucher(VoucherDTO voucher) {
        String sql = "UPDATE [vouchers] SET [code] = ?, [discount_type] = ?, [discount_value] = ?, [max_discount_amount] = ?, [start_date] = ?, [end_date] = ?, [quantity] = ? WHERE [id] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase().trim());
            ps.setString(2, voucher.getDiscountType());
            ps.setBigDecimal(3, voucher.getDiscountValue());
            ps.setBigDecimal(4, voucher.getMaxDiscountAmount());
            ps.setObject(5, voucher.getStartDate());
            ps.setObject(6, voucher.getEndDate());
            ps.setInt(7, voucher.getQuantity());
            ps.setString(8, voucher.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isCodeExist(String code) {
        String sql = "SELECT COUNT(*) FROM [vouchers] WHERE [code] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isCodeExistForUpdate(String code, String currentId) {
        String sql = "SELECT COUNT(*) FROM [vouchers] WHERE [code] = ? AND [id] <> ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            ps.setString(2, currentId);
            try (ResultSet rs = ps.executeQuery()) {
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
