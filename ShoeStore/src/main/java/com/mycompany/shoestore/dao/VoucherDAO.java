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
                v.setDiscountPercent(rs.getDouble("discount_percent"));
                list.add(v);
            }
        }
        return list;
    }

    public boolean decreaseVoucherQuantity(String voucherId) throws Exception {
        String sql = "UPDATE vouchers SET quantity = quantity - 1 WHERE id = ? AND quantity > 0";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public Voucher getVoucherById(String voucherId) throws Exception {
        String sql = "SELECT id, code, discount_percent FROM vouchers WHERE id = ? AND quantity > 0 AND start_date <= SYSDATETIMEOFFSET() AND end_date >= SYSDATETIMEOFFSET()";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucherId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getString("id"));
                    voucher.setCode(rs.getString("code"));
                    voucher.setDiscountPercent(rs.getDouble("discount_percent"));
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
        String sql = "SELECT [id], [code], [discount_percent], [max_discount_amount], [start_date], [end_date], [quantity] FROM [vouchers]";

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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

    public boolean createVoucher(VoucherDTO voucher) {
        String sql = "INSERT INTO [vouchers] ([id], [code], [discount_percent], [max_discount_amount], [start_date], [end_date], [quantity]) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String uniqueId = java.util.UUID.randomUUID().toString();

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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
        String sql = "SELECT [id], [code], [discount_percent], [max_discount_amount], [start_date], [end_date], [quantity] FROM [vouchers] WHERE [id] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new VoucherDTO(
                            rs.getString("id"),
                            rs.getString("code"),
                            rs.getDouble("discount_percent"),
                            rs.getDouble("max_discount_amount"),
                            rs.getTimestamp("start_date"),
                            rs.getTimestamp("end_date"),
                            rs.getInt("quantity")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateVoucher(VoucherDTO voucher) {
        String sql = "UPDATE [vouchers] SET [code] = ?, [discount_percent] = ?, [max_discount_amount] = ?, [start_date] = ?, [end_date] = ?, [quantity] = ? WHERE [id] = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, voucher.getCode().toUpperCase().trim());
            ps.setDouble(2, voucher.getDiscountPercent());
            ps.setDouble(3, voucher.getMaxDiscountAmount());
            ps.setTimestamp(4, voucher.getStartDate());
            ps.setTimestamp(5, voucher.getEndDate());
            ps.setInt(6, voucher.getQuantity());
            ps.setString(7, voucher.getId());

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
