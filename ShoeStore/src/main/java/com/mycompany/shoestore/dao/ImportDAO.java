package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.dto.ImportDTO;
import com.mycompany.shoestore.dto.ImportDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class ImportDAO {

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

    //Create Import
    public boolean createImport(ImportDTO importDTO) {
        String sqlImport = "INSERT INTO imports (Supplier, StaffID, TotalAmount, Status, Note, OrderDate) VALUES (?, ?, ?, ?, ?, SYSDATETIMEOFFSET())";
        String sqlDetail = "INSERT INTO import_details (ImportID, VariantID, ImportQuantity, ReceivedQuantity, UnitPrice) VALUES (?, ?, ?, ?, ?)";
        
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);
            
            int importID = -1;
            try (PreparedStatement ps = conn.prepareStatement(sqlImport, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setNString(1, importDTO.getSupplier());
                ps.setString(2, importDTO.getStaffID());
                ps.setBigDecimal(3, importDTO.getTotalAmount());
                ps.setString(4, "REQUESTING");
                ps.setNString(5, importDTO.getNote());
                
                ps.executeUpdate();
                
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        importID = rs.getInt(1);
                    }
                }
            }
            
            if (importID != -1 && importDTO.getDetails() != null) {
                try (PreparedStatement ps = conn.prepareStatement(sqlDetail)) {
                    for (ImportDetailDTO detail : importDTO.getDetails()) {
                        ps.setInt(1, importID);
                        ps.setString(2, detail.getVariantID());
                        ps.setInt(3, detail.getImportQuantity());
                        ps.setInt(4, 0); // Ban đầu thực nhận là 0
                        ps.setBigDecimal(5, detail.getUnitPrice());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
                conn.commit();
                return true;
            }
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { 
                    conn.setAutoCommit(true); 
                    conn.close(); 
                } catch (SQLException e) { 
                    e.printStackTrace(); 
                }
            }
        }
        return false;
    }

    public List<ImportDetailDTO> getAllVariantsForImport() {
        List<ImportDetailDTO> list = new ArrayList<>();
        String sql = "SELECT pv.variant_id, p.name as ProductName, pv.size, pv.color " +
                     "FROM product_variants pv " +
                     "JOIN products p ON pv.product_id = p.id " +
                     "WHERE p.status = 'active' " +
                     "ORDER BY p.name, pv.size, pv.color";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ImportDetailDTO d = new ImportDetailDTO();
                d.setVariantID(rs.getString("variant_id"));
                d.setProductName(rs.getNString("ProductName"));
                d.setSize(rs.getNString("size"));
                d.setColor(rs.getNString("color"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean updateImportStatus(int importID, String status, String note) {
        String sql = "UPDATE imports SET Status = ?, Note = ? WHERE ImportID = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setNString(2, note);
            ps.setInt(3, importID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
