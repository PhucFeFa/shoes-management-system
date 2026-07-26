<%@page import="java.sql.*"%>
<%@page import="com.mycompany.shoestore.db.DBContext"%>
<%@page import="com.mycompany.shoestore.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Test DB</title>
    </head>
    <body>
        <h1>Test User Orders</h1>
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
                out.println("<p>No user logged in.</p>");
            } else {
                out.println("<p>Logged in as: " + currentUser.getEmail() + " (" + currentUser.getId() + ")</p>");
                
                String sql = "SELECT o.id, o.status, pv.product_id, pv.id as variant_id " +
                             "FROM orders o " +
                             "JOIN order_items oi ON o.id = oi.order_id " +
                             "JOIN product_variants pv ON oi.product_variant_id = pv.id " +
                             "WHERE o.user_id = ?";
                
                try (Connection conn = new DBContext().getConnection();
                     PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, currentUser.getId());
                    ResultSet rs = ps.executeQuery();
                    
                    out.println("<table border='1'><tr><th>Order ID</th><th>Status</th><th>Product ID</th><th>Variant ID</th></tr>");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("id") + "</td>");
                        out.println("<td>" + rs.getString("status") + "</td>");
                        out.println("<td>" + rs.getString("product_id") + "</td>");
                        out.println("<td>" + rs.getString("variant_id") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    out.println("<pre>" + e.getMessage() + "</pre>");
                }
            }
        %>
    </body>
</html>
