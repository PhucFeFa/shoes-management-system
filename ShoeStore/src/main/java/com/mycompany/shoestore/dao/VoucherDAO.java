package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Voucher;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {

    private final DBContext db = new DBContext();

    // ==========================================
    // Checkout / Customer operations (uses Voucher)
    // ==========================================

    public List<Voucher> getAvailableVouchers() throws Exception {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM vouchers WHERE quantity > 0 AND GETDATE() BETWEEN start_date AND end_date";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Voucher v = new Voucher();
                v.setId(rs.getString("id"));
                v.setCode(rs.getString("code"));
                v.setDiscountType(rs.getString("discount_type"));
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

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public Voucher getVoucherById(String voucherId) throws Exception {
        String sql = "SELECT * FROM vouchers WHERE id = ? AND quantity > 0 AND start_date <= SYSDATETIMEOFFSET() AND end_date >= SYSDATETIMEOFFSET()";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getString("id"));
                    voucher.setCode(rs.getString("code"));
                    voucher.setDiscountType(rs.getString("discount_type"));
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
                        rs.getDouble("discount_value"),
                        rs.getObject("max_discount_amount") != null ? rs.getDouble("max_discount_amount") : null,
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date"),
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

    public boolean createVoucher(VoucherDTO voucher) {
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_type], [discount_value], [max_discount_amount], [start_date], [end_date], [quantity], [used_quantity]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";
        String uniqueId = java.util.UUID.randomUUID().toString();

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, uniqueId);
            ps.setString(2, voucher.getCode().toUpperCase().trim());
            ps.setString(3, voucher.getDiscountType());
            ps.setDouble(4, voucher.getDiscountValue());
            if (voucher.getMaxDiscountAmount() != null) {
                ps.setDouble(5, voucher.getMaxDiscountAmount());
            } else {
                ps.setNull(5, java.sql.Types.DECIMAL);
            }
            ps.setTimestamp(6, voucher.getStartDate());
            ps.setTimestamp(7, voucher.getEndDate());
            ps.setInt(8, voucher.getQuantity());

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
                            rs.getDouble("discount_value"),
                            rs.getObject("max_discount_amount") != null ? rs.getDouble("max_discount_amount") : null,
                            rs.getTimestamp("start_date"),
                            rs.getTimestamp("end_date"),
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

    public boolean updateVoucher(VoucherDTO voucher) {
        String sql = "UPDATE [vouchers] SET [code] = ?, [discount_type] = ?, [discount_value] = ?, [max_discount_amount] = ?, [start_date] = ?, [end_date] = ?, [quantity] = ? WHERE [id] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase().trim());
            ps.setString(2, voucher.getDiscountType());
            ps.setDouble(3, voucher.getDiscountValue());
            if (voucher.getMaxDiscountAmount() != null) {
                ps.setDouble(4, voucher.getMaxDiscountAmount());
            } else {
                ps.setNull(4, java.sql.Types.DECIMAL);
            }
            ps.setTimestamp(5, voucher.getStartDate());
            ps.setTimestamp(6, voucher.getEndDate());
            ps.setInt(7, voucher.getQuantity());
            ps.setString(8, voucher.getId());

            return ps.executeUpdate() > 0;
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
