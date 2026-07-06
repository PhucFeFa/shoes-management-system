package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.dto.ImportDTO;
import com.mycompany.shoestore.dto.ImportDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class ImportDAO {

    // 1. Lấy danh sách phiếu nhập (kèm tên nhân viên)
    public List<ImportDTO> getAllImports() {
        List<ImportDTO> list = new ArrayList<>();
        String sql = "SELECT i.*, s.full_name as StaffName " +
                     "FROM imports i " +
                     "JOIN staffs s ON i.StaffID = s.id " +
                     "ORDER BY i.OrderDate DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ImportDTO dto = mapImport(rs);
                dto.setStaffName(rs.getNString("StaffName"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy chi tiết một phiếu nhập (bao gồm cả Header và List Details)
    public ImportDTO getImportByID(int importID) {
        ImportDTO dto = null;
        String sqlHeader = "SELECT i.*, s.full_name as StaffName FROM imports i " +
                          "JOIN staffs s ON i.StaffID = s.id WHERE i.ImportID = ?";
        
        String sqlDetails = "SELECT id.*, p.name as ProductName, pv.size, pv.color " +
                           "FROM import_details id " +
                           "JOIN product_variants pv ON id.VariantID = pv.variant_id " +
                           "JOIN products p ON pv.product_id = p.id " +
                           "WHERE id.ImportID = ?";

        try (Connection conn = new DBContext().getConnection()) {
            // Lấy Header
            try (PreparedStatement ps = conn.prepareStatement(sqlHeader)) {
                ps.setInt(1, importID);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        dto = mapImport(rs);
                        dto.setStaffName(rs.getNString("StaffName"));
                    }
                }
            }

            if (dto != null) {
                // Lấy Details
                List<ImportDetailDTO> details = new ArrayList<>();
                try (PreparedStatement ps = conn.prepareStatement(sqlDetails)) {
                    ps.setInt(1, importID);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            ImportDetailDTO detail = new ImportDetailDTO();
                            detail.setImportDetailID(rs.getInt("ImportDetailID"));
                            detail.setImportID(rs.getInt("ImportID"));
                            detail.setVariantID(rs.getString("VariantID"));
                            detail.setImportQuantity(rs.getInt("ImportQuantity"));
                            detail.setReceivedQuantity(rs.getInt("ReceivedQuantity"));
                            detail.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                            detail.setProductName(rs.getNString("ProductName"));
                            detail.setSize(rs.getNString("size"));
                            detail.setColor(rs.getNString("color"));
                            details.add(detail);
                        }
                    }
                }
                dto.setDetails(details);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    //ViewRequset
    public List<ImportDTO> ViewRequset(String staffID) {
        List<ImportDTO> list = new ArrayList<>();
        String sql = "SELECT i.*, s.full_name as StaffName FROM imports i " +
                     "JOIN staffs s ON i.StaffID = s.id " +
                     "WHERE i.StaffID = ? " +
                     "ORDER BY i.OrderDate DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staffID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImportDTO dto = mapImport(rs);
                    dto.setStaffName(rs.getNString("StaffName"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method để map dữ liệu từ ResultSet sang DTO
    private ImportDTO mapImport(ResultSet rs) throws Exception {
        ImportDTO dto = new ImportDTO();
        dto.setImportID(rs.getInt("ImportID"));
        dto.setStaffID(rs.getString("StaffID"));
        dto.setSupplier(rs.getNString("Supplier"));
        dto.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        dto.setStatus(rs.getNString("Status"));
        dto.setNote(rs.getNString("Note"));
        dto.setOrderDate(rs.getTimestamp("OrderDate"));
        return dto;
    }
}
