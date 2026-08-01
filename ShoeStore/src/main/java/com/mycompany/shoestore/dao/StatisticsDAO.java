package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatisticsDAO {

    public double getMonthlyRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders " +
                     "WHERE status = 'completed' " +
                     "AND MONTH(created_at) = MONTH(SYSDATETIMEOFFSET()) " +
                     "AND YEAR(created_at) = YEAR(SYSDATETIMEOFFSET())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getMonthlyCost() {
        String sql = "SELECT SUM(TotalAmount) " +
                     "FROM imports " +
                     "WHERE Status IN ('REPORTED', 'ACCEPTED', 'COMPLETE') " +
                     "AND MONTH(OrderDate) = MONTH(SYSDATETIMEOFFSET()) " +
                     "AND YEAR(OrderDate) = YEAR(SYSDATETIMEOFFSET())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getMonthlyTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders " +
                     "WHERE MONTH(created_at) = MONTH(SYSDATETIMEOFFSET()) " +
                     "AND YEAR(created_at) = YEAR(SYSDATETIMEOFFSET())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getMonthlySuccessRate() {
        String sql = "SELECT " +
                     "COUNT(CASE WHEN status = 'completed' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0) " +
                     "FROM orders " +
                     "WHERE MONTH(created_at) = MONTH(SYSDATETIMEOFFSET()) " +
                     "AND YEAR(created_at) = YEAR(SYSDATETIMEOFFSET())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Map<String, Object>> getRevenueAndCostByMonth() {
        List<Map<String, Object>> data = new ArrayList<>();
        String sql = "WITH Months AS (" +
                     "    SELECT MONTH(DATEADD(MONTH, -m, SYSDATETIMEOFFSET())) as Month, " +
                     "           YEAR(DATEADD(MONTH, -m, SYSDATETIMEOFFSET())) as Year " +
                     "    FROM (VALUES (0), (1), (2), (3), (4), (5)) as M(m)" +
                     ") " +
                     "SELECT Months.Month, Months.Year, " +
                     "       ISNULL(SUM(O.total_amount), 0) as Revenue, " +
                     "       ISNULL(C.Cost, 0) as Cost " +
                     "FROM Months " +
                     "LEFT JOIN orders O ON MONTH(O.created_at) = Months.Month AND YEAR(O.created_at) = Months.Year AND O.status = 'completed' " +
                     "LEFT JOIN (" +
                     "    SELECT MONTH(OrderDate) as Month, YEAR(OrderDate) as Year, SUM(TotalAmount) as Cost " +
                     "    FROM imports " +
                     "    WHERE Status IN ('REPORTED', 'ACCEPTED', 'COMPLETE') " +
                     "    GROUP BY MONTH(OrderDate), YEAR(OrderDate)" +
                     ") C ON Months.Month = C.Month AND Months.Year = C.Year " +
                     "GROUP BY Months.Month, Months.Year, C.Cost " +
                     "ORDER BY Months.Year ASC, Months.Month ASC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("month", "Month " + rs.getInt("Month") + "/" + rs.getInt("Year"));
                row.put("revenue", rs.getDouble("Revenue"));
                row.put("cost", rs.getDouble("Cost"));
                data.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    public List<Map<String, Object>> getTopSellingItems() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "WITH MonthlySales AS (" +
                     "    SELECT " +
                     "        MONTH(o.created_at) as Month, " +
                     "        YEAR(o.created_at) as Year, " +
                     "        p.name as ProductName, " +
                     "        pv.size, " +
                     "        pv.color, " +
                     "        SUM(oi.quantity) as TotalSold, " +
                     "        RANK() OVER (PARTITION BY YEAR(o.created_at), MONTH(o.created_at) ORDER BY SUM(oi.quantity) DESC) as Rank " +
                     "    FROM order_items oi " +
                     "    JOIN orders o ON oi.order_id = o.id " +
                     "    JOIN product_variants pv ON oi.product_variant_id = pv.id " +
                     "    JOIN products p ON pv.product_id = p.id " +
                     "    WHERE o.status = 'completed' " +
                     "    GROUP BY YEAR(o.created_at), MONTH(o.created_at), p.name, pv.size, pv.color " +
                     ") " +
                     "SELECT * FROM MonthlySales WHERE Rank = 1 " +
                     "ORDER BY Year DESC, Month DESC";
        
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("month", rs.getInt("Month") + "/" + rs.getInt("Year"));
                item.put("productName", rs.getString("ProductName"));
                item.put("size", rs.getString("size"));
                item.put("color", rs.getString("color"));
                item.put("totalSold", rs.getInt("TotalSold"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
