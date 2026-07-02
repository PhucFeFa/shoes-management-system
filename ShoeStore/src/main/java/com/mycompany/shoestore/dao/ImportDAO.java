package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext; // Giả định lớp chứa hàm getConnection() nằm ở đây
import com.mycompany.shoestore.dto.ImportDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.time.OffsetDateTime;

public class ImportDAO {

    // Hàm lấy toàn bộ danh sách phiếu nhập
    public List<ImportDTO> getAllImports() {
        List<ImportDTO> list = new ArrayList<>();
        String sql = "SELECT ImportID, StaffID, Supplier, TotalAmount, OrderDate, Status FROM [imports] ORDER BY ImportID DESC";
        
        // Sử dụng try-with-resources để tự động đóng kết nối tránh tràn bộ nhớ
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                ImportDTO dto = new ImportDTO();
                dto.setImportID(rs.getInt("ImportID"));
                dto.setStaffID(rs.getString("StaffID"));
                dto.setSupplier(rs.getNString("Supplier"));
                dto.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                
                // Đọc dữ liệu loại DATETIMEOFFSET từ SQL Server sang OffsetDateTime của Java
                Timestamp timestamp = rs.getTimestamp("OrderDate");
                if (timestamp != null) {
                    dto.setOrderDate(timestamp.toInstant().atOffset(java.time.ZoneOffset.ofHours(7)));
                }
                
                dto.setStatus(rs.getNString("Status"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
