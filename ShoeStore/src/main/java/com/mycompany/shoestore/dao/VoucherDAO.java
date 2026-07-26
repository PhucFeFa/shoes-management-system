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
    // Checkout / Customer operations (uses Voucher)
    // ==========================================

    public List<Voucher> getAvailableVouchers() throws Exception {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM vouchers WHERE quantity > 0 AND status = 'ACTIVE' AND SYSDATETIMEOFFSET() BETWEEN start_date AND end_date";

        try ( Connection con = db.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Voucher v = new Voucher();
                v.setId(rs.getString("id"));
                v.setCode(rs.getString("code"));
                // Note: Voucher model still uses double/Timestamp, might need update later if requested
                v.setDiscountValue(rs.getDouble("discount_value"));
                if (rs.getObject("max_discount_amount") != null) {
                    v.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                }
                v.setStartDate(rs.getTimestamp("start_date"));
                v.setEndDate(rs.getTimestamp("end_date"));
                v.setQuantity(rs.getInt("quantity"));
                v.setUsedQuantity(rs.getInt("used_quantity"));
                list.add(v);
            }
        }
        return list;
    }

    public boolean decreaseVoucherQuantity(String voucherId) throws Exception {
        String sql = "UPDATE vouchers SET quantity = quantity - 1, used_quantity = used_quantity + 1 WHERE id = ? AND quantity > 0";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public Voucher getVoucherById(String voucherId) throws Exception {
        String sql = "SELECT * FROM vouchers WHERE id = ? AND quantity > 0 AND status = 'ACTIVE' AND start_date <= SYSDATETIMEOFFSET() AND end_date >= SYSDATETIMEOFFSET()";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getString("id"));
                    voucher.setCode(rs.getString("code"));
                    voucher.setDiscountValue(rs.getDouble("discount_value"));
                    if (rs.getObject("max_discount_amount") != null) {
                        voucher.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                    }
                    voucher.setStartDate(rs.getTimestamp("start_date"));
                    voucher.setEndDate(rs.getTimestamp("end_date"));
                    voucher.setQuantity(rs.getInt("quantity"));
                    voucher.setUsedQuantity(rs.getInt("used_quantity"));
                    return voucher;
                }
            }
        }
        return null;
    }
    // ==========================================
    // Admin operations (uses VoucherDTO)
    // ==========================================
    //View list
    public List<VoucherDTO> getAllVouchers() {
        List<VoucherDTO> list = new ArrayList<>();
        String sql = "SELECT [id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [status] FROM [vouchers] WHERE [status] = 'ACTIVE'";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VoucherDTO dto = new VoucherDTO(
                        rs.getString("id"),
                        rs.getString("code"),
                        rs.getBigDecimal("discount_value"),
                        rs.getBigDecimal("min_order_amount"),
                        rs.getBigDecimal("max_discount_amount"),
                        rs.getObject("start_date", OffsetDateTime.class),
                        rs.getObject("end_date", OffsetDateTime.class),
                        rs.getInt("quantity"),
                        rs.getInt("used_quantity"),
                        rs.getString("status")
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
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [status]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, 'ACTIVE')";
        String uniqueId = java.util.UUID.randomUUID().toString();

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uniqueId);
            ps.setString(2, voucher.getCode().toUpperCase().trim());
            ps.setBigDecimal(3, voucher.getDiscountValue());
            ps.setBigDecimal(4, voucher.getMinOrderAmount());
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
        String sql = "SELECT [id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [status] FROM [vouchers] WHERE [id] = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new VoucherDTO(
                            rs.getString("id"),
                            rs.getString("code"),
                            rs.getBigDecimal("discount_value"),
                            rs.getBigDecimal("min_order_amount"),
                            rs.getBigDecimal("max_discount_amount"),
                            rs.getObject("start_date", OffsetDateTime.class),
                            rs.getObject("end_date", OffsetDateTime.class),
                            rs.getInt("quantity"),
                            rs.getInt("used_quantity"),
                            rs.getString("status")
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
        String sql = "UPDATE [vouchers] SET [code] = ?, [discount_value] = ?, [min_order_amount] = ?, [max_discount_amount] = ?, [start_date] = ?, [end_date] = ?, [quantity] = ? WHERE [id] = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase().trim());
            ps.setBigDecimal(2, voucher.getDiscountValue());
            ps.setBigDecimal(3, voucher.getMinOrderAmount());
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
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public boolean isCodeExistForUpdate(String code, String currentId) {
        String sql = "SELECT COUNT(*) FROM [vouchers] WHERE [code] = ? AND [id] <> ?";
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            ps.setString(2, currentId);
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
        // Xoamem
    public boolean deleteVoucher(String id) {
        String sql = "UPDATE [vouchers] SET [status] = 'INACTIVE' WHERE [id] = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
