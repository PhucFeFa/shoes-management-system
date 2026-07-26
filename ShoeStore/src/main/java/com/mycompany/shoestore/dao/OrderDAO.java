package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Order;
import com.mycompany.shoestore.dto.OrderDetailDTO;
import com.mycompany.shoestore.dto.OrderSummaryDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class OrderDAO {

    private static final int PAGE_SIZE = 10;

    public List<Order> getOrdersByUser(String userId, String statusFilter, int page) {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * PAGE_SIZE;

        StringBuilder sql = new StringBuilder(
                "SELECT o.id, o.user_id, o.address_id, o.total_amount, o.status, o.payment_method, o.payment_status, o.voucher_id, o.created_at, "
                + "u.full_name AS customer_full_name, u.email AS customer_email "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.id "
                + "WHERE o.user_id = ? "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }

        sql.append("ORDER BY o.created_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            ps.setString(idx++, userId);

            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter);
            }

            ps.setInt(idx++, offset);
            ps.setInt(idx, PAGE_SIZE);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setUserId(rs.getString("user_id"));
                order.setAddressId(rs.getString("address_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setVoucherId(rs.getString("voucher_id"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setCustomerFullName(rs.getString("customer_full_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                orders.add(order);
            }
        } catch (Exception e) {
            System.err.println("Error getOrdersByUser: " + e.getMessage());
            e.printStackTrace();
        }

        return orders;
    }

    public int countOrdersByUser(String userId, String statusFilter) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM orders o WHERE o.user_id = ? "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            ps.setString(idx++, userId);

            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx, statusFilter);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println("Error countOrdersByUser: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    public List<Order> getAllOrders(String statusFilter, String keyword, int page, String sortBy, String sortOrder) {
        List<Order> orders = new ArrayList<>();
        int offset = (page - 1) * PAGE_SIZE;

        StringBuilder sql = new StringBuilder(
                "SELECT o.id, o.user_id, o.address_id, o.total_amount, o.status, o.payment_method, o.payment_status, o.voucher_id, o.created_at, "
                + "u.full_name AS customer_full_name, u.email AS customer_email "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.id "
                + "WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR o.id LIKE ?) ");
        }

        if ("amount".equals(sortBy)) {
            sql.append("ORDER BY o.total_amount ");
        } else {
            sql.append("ORDER BY o.created_at ");
        }

        if ("asc".equalsIgnoreCase(sortOrder)) {
            sql.append("ASC ");
        } else {
            sql.append("DESC ");
        }

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, statusFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                String idLike = "%" + keyword.trim().replace("#", "") + "%";
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, idLike);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, PAGE_SIZE);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getString("id"));
                    o.setUserId(rs.getString("user_id"));
                    o.setAddressId(rs.getString("address_id"));
                    o.setTotalAmount(rs.getBigDecimal("total_amount"));
                    o.setStatus(rs.getString("status"));
                    o.setPaymentMethod(rs.getString("payment_method"));
                    o.setPaymentStatus(rs.getString("payment_status"));
                    o.setVoucherId(rs.getString("voucher_id"));
                    o.setCreatedAt(rs.getTimestamp("created_at"));
                    o.setCustomerFullName(rs.getString("customer_full_name"));
                    o.setCustomerEmail(rs.getString("customer_email"));
                    orders.add(o);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getAllOrders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    public int countAllOrders(String statusFilter, String keyword) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.id "
                + "WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR o.id LIKE ?) ");
        }

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(paramIndex++, statusFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                String idLike = "%" + keyword.trim().replace("#", "") + "%";
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, like);
                ps.setString(paramIndex++, idLike);
            }

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.err.println("Error countAllOrders: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getPageSize() {
        return PAGE_SIZE;
    }

    public OrderSummaryDTO getOrderSummaryById(String orderId) {
        String sql = "SELECT o.id, o.user_id, o.address_id, o.total_amount, o.status, o.voucher_id, o.created_at, "
                + "u.full_name AS customer_full_name, u.email AS customer_email, "
                + "a.address_line, a.ward, a.district, a.city, "
                + "o.payment_method, o.payment_status "
                + "FROM orders o "
                + "JOIN users u ON o.user_id = u.id "
                + "LEFT JOIN addresses a ON o.address_id = a.id "
                + "WHERE o.id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    OrderSummaryDTO summary = new OrderSummaryDTO();
                    summary.setId(rs.getString("id"));
                    summary.setUserId(rs.getString("user_id"));
                    summary.setAddressId(rs.getString("address_id"));
                    summary.setTotalAmount(rs.getBigDecimal("total_amount"));
                    summary.setStatus(rs.getString("status"));
                    summary.setVoucherId(rs.getString("voucher_id"));
                    summary.setCreatedAt(rs.getTimestamp("created_at"));
                    summary.setCustomerFullName(rs.getString("customer_full_name"));
                    summary.setCustomerEmail(rs.getString("customer_email"));

                    summary.setAddressLine(rs.getString("address_line"));
                    summary.setWard(rs.getString("ward"));
                    summary.setDistrict(rs.getString("district"));
                    summary.setCity(rs.getString("city"));
                    summary.setPaymentMethod(rs.getString("payment_method"));
                    summary.setPaymentStatus(rs.getString("payment_status"));
                    return summary;
                }
            }
        } catch (Exception e) {
            System.err.println("Error getOrderSummaryById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetailDTO> getOrderItemsByOrderId(String orderId) {
        List<OrderDetailDTO> items = new ArrayList<>();
        String sql = "SELECT oi.quantity, oi.price_at_purchase, "
                + "pv.size, pv.color, "
                + "p.id AS product_id, p.name AS product_name, "
                + "b.name AS brand_name, "
                + "c.name AS category_name, "
                + "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id ORDER BY sort_order ASC) AS image_url "
                + "FROM order_items oi "
                + "JOIN product_variants pv ON oi.product_variant_id = pv.id "
                + "JOIN products p ON pv.product_id = p.id "
                + "LEFT JOIN brands b ON p.brand_id = b.id "
                + "LEFT JOIN categories c ON p.category_id = c.id "
                + "WHERE oi.order_id = ?";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO item = new OrderDetailDTO();
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPriceAtPurchase(rs.getBigDecimal("price_at_purchase"));
                    item.setSize(rs.getString("size"));
                    item.setColor(rs.getString("color"));
                    item.setProductId(rs.getString("product_id"));
                    item.setProductName(rs.getString("product_name"));
                    item.setBrandName(rs.getString("brand_name"));
                    item.setCategoryName(rs.getString("category_name"));
                    item.setImageUrl(rs.getString("image_url"));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getOrderItemsByOrderId: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }

    public boolean updateOrderStatus(String orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error updateOrderStatus: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public int getCustomerCancellationCountLast30Days(String userId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ? AND status = 'cancelled' AND created_at >= DATEADD(day, -30, SYSDATETIMEOFFSET())";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getCustomerCancellationCountLast30Days: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public boolean cancelOrderWithTracking(String orderId, String userId, String reason) {
        String updateStatusSql = "UPDATE orders SET status = 'cancelled' WHERE id = ?";
        String restoreStockSql = "UPDATE pv "
                + "SET pv.stock_quantity = pv.stock_quantity + oi.quantity "
                + "FROM product_variants pv "
                + "JOIN order_items oi ON pv.id = oi.product_variant_id "
                + "WHERE oi.order_id = ?";

        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            try ( PreparedStatement psUpdate = conn.prepareStatement(updateStatusSql)) {
                psUpdate.setString(1, orderId);
                int updated = psUpdate.executeUpdate();
                if (updated == 0) {
                    conn.rollback();
                    return false;
                }
            }

            try ( PreparedStatement psRestore = conn.prepareStatement(restoreStockSql)) {
                psRestore.setString(1, orderId);
                psRestore.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception re) {
                    re.printStackTrace();
                }
            }
            System.err.println("Error cancelOrderWithTracking: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (Exception ce) {
                    ce.printStackTrace();
                }
            }
        }
        return false;
    }

    public boolean restoreStockForOrder(String orderId) {
        String sql = "UPDATE pv "
                + "SET pv.stock_quantity = pv.stock_quantity + oi.quantity "
                + "FROM product_variants pv "
                + "JOIN order_items oi ON pv.id = oi.product_variant_id "
                + "WHERE oi.order_id = ?";
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error restoreStockForOrder: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelOrderWithStockRestore(String orderId) {
        OrderSummaryDTO summary = getOrderSummaryById(orderId);
        if (summary == null) {
            return false;
        }
        String status = summary.getStatus().toLowerCase();
        if (status.equals("cancelled") || status.equals("completed") || status.equals("delivered")) {
            return false;
        }

        boolean statusUpdated = updateOrderStatus(orderId, "cancelled");
        if (statusUpdated) {
            restoreStockForOrder(orderId);
            return true;
        }
        return false;
    }

    public String createOrder(String userId, String addressId, double totalAmount) {
        String orderId = UUID.randomUUID().toString();
        String sql = "INSERT INTO orders (id, user_id, address_id, total_amount, status, payment_method, payment_status) "
                + "VALUES (?, ?, ?, ?, 'pending', 'cod', 'pending')";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setString(2, userId);
            ps.setString(3, addressId);
            ps.setDouble(4, totalAmount);

            ps.executeUpdate();
            return orderId;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void addOrderItem(String orderId, String variantId, int quantity, double price) throws Exception {
        String sql = "INSERT INTO order_items (id, order_id, product_variant_id, quantity, price_at_purchase) "
                + "VALUES (NEWID(), ?, ?, ?, ?)";

        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setString(2, variantId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);

            ps.executeUpdate();
        }
    }

    public void clearCartAfterOrder(String userId, String variantId) {
        String sql = "DELETE FROM carts " +
                "WHERE user_id = ? " +
                "AND product_variant_id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, variantId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String createOrder(String userId, String addressId, double totalAmount, String voucherId, String paymentMethod) {
        String orderId = java.util.UUID.randomUUID().toString();

        // Giữ nguyên GETDATE() của bạn và thêm cột voucher_id
        String sql = "INSERT INTO orders (id, user_id, address_id, total_amount, voucher_id, status, payment_method, payment_status, created_at) "
                + "VALUES (?, ?, ?, ?, ?, 'pending', ?, 'pending', GETDATE())";

        // Khởi tạo kết nối bằng new DBContext().getConnection() giống hàm mẫu
        try ( Connection conn = new DBContext().getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setString(2, userId);
            ps.setString(3, addressId);
            ps.setDouble(4, totalAmount);

            // Xử lý voucherId nếu bị null hoặc rỗng
            if (voucherId == null || voucherId.isEmpty()) {
                ps.setNull(5, java.sql.Types.VARCHAR);
            } else {
                ps.setString(5, voucherId);
            }
            ps.setString(6, paymentMethod != null ? paymentMethod : "cod");

            ps.executeUpdate();
            return orderId; // Trả về orderId khi thành công

        } catch (Exception e) {
            e.printStackTrace();
            return null; // Trả về null nếu xảy ra lỗi giống hàm mẫu
        }
    }
    public boolean updateProductStock(
        String variantId,
        int quantity) throws Exception {

    String sql =
            "UPDATE product_variants "
            + "SET stock_quantity = stock_quantity - ? "
            + "WHERE id = ? "
            + "AND stock_quantity >= ?";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, quantity);
        ps.setString(2, variantId);
        ps.setInt(3, quantity);

        return ps.executeUpdate() > 0;
    }
}
   
}
