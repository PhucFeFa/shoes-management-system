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
        String sql = "SELECT * FROM vouchers WHERE quantity > used_quantity AND is_deleted = 0 AND SYSDATETIMEOFFSET() BETWEEN start_date AND end_date";

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
        String sql = "UPDATE vouchers SET used_quantity = used_quantity + 1 WHERE id = ? AND quantity > used_quantity";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public Voucher getVoucherById(String voucherId) throws Exception {
        String sql = "SELECT * FROM vouchers WHERE id = ? AND quantity > used_quantity AND is_deleted = 0 AND start_date <= SYSDATETIMEOFFSET() AND end_date >= SYSDATETIMEOFFSET()";

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
        String sql = "SELECT [id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [is_deleted] FROM [vouchers] WHERE ([is_deleted] = 0 OR [is_deleted] IS NULL)";

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                OffsetDateTime startDate = rs.getObject("start_date", OffsetDateTime.class);
                OffsetDateTime endDate = rs.getObject("end_date", OffsetDateTime.class);

                VoucherDTO dto = new VoucherDTO(
                        rs.getString("id"),
                        rs.getString("code"),
                        rs.getBigDecimal("discount_value"),
                        rs.getBigDecimal("min_order_amount"),
                        rs.getBigDecimal("max_discount_amount"),
                        startDate,
                        endDate,
                        rs.getInt("quantity"),
                        rs.getInt("used_quantity"),
                        rs.getInt("is_deleted")
                );
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Create
    public boolean createVoucher(VoucherDTO voucher) throws Exception {
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [is_deleted]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, 0)";
        String uniqueId = java.util.UUID.randomUUID().toString();

        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uniqueId);
            ps.setString(2, voucher.getCode().toUpperCase().trim());
            ps.setBigDecimal(3, voucher.getDiscountValue());
            ps.setBigDecimal(4, voucher.getMinOrderAmount());
            ps.setBigDecimal(5, voucher.getMaxDiscountAmount());
            ps.setTimestamp(6, voucher.getStartDate() != null ? java.sql.Timestamp.from(voucher.getStartDate().toInstant()) : null);
            ps.setTimestamp(7, voucher.getEndDate() != null ? java.sql.Timestamp.from(voucher.getEndDate().toInstant()) : null);
            ps.setInt(8, voucher.getQuantity());

            int rows = ps.executeUpdate();
            System.out.println("[createVoucher] rows inserted: " + rows);
            return rows > 0;
        }
    }

    //Detail
    public VoucherDTO getVoucherDTOById(String id) {
        String sql = "SELECT [id], [code], [discount_value], [min_order_amount], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity], [is_deleted] FROM [vouchers] WHERE [id] = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OffsetDateTime startDate = rs.getObject("start_date", OffsetDateTime.class);
                    OffsetDateTime endDate = rs.getObject("end_date", OffsetDateTime.class);

                    VoucherDTO dto = new VoucherDTO(
                            rs.getString("id"),
                            rs.getString("code"),
                            rs.getBigDecimal("discount_value"),
                            rs.getBigDecimal("min_order_amount"),
                            rs.getBigDecimal("max_discount_amount"),
                            startDate,
                            endDate,
                            rs.getInt("quantity"),
                            rs.getInt("used_quantity"),
                            rs.getInt("is_deleted")
                    );
                    return dto;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Update
    public boolean updateVoucher(VoucherDTO voucher) throws Exception {
        String sql = "UPDATE [vouchers] SET [code] = ?, [discount_value] = ?, [min_order_amount] = ?, [max_discount_amount] = ?, [start_date] = ?, [end_date] = ?, [quantity] = ? WHERE [id] = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase().trim());
            ps.setBigDecimal(2, voucher.getDiscountValue());
            ps.setBigDecimal(3, voucher.getMinOrderAmount());
            ps.setBigDecimal(4, voucher.getMaxDiscountAmount());
            ps.setTimestamp(5, voucher.getStartDate() != null ? java.sql.Timestamp.from(voucher.getStartDate().toInstant()) : null);
            ps.setTimestamp(6, voucher.getEndDate() != null ? java.sql.Timestamp.from(voucher.getEndDate().toInstant()) : null);
            ps.setInt(7, voucher.getQuantity());
            ps.setString(8, voucher.getId());

            int rows = ps.executeUpdate();
            System.out.println("[updateVoucher] rows affected: " + rows + " for id: " + voucher.getId());
            return rows > 0;
        }
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
        String sql = "UPDATE [vouchers] SET [is_deleted] = 1 WHERE [id] = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}