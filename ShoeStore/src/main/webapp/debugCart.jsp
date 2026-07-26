<%@page import="java.util.List"%>
<%@page import="com.mycompany.shoestore.dao.CartDAO"%>
<%@page import="com.mycompany.shoestore.models.CartItem"%>
<%@page import="com.mycompany.shoestore.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <h1>Debug CartDAO</h1>
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                CartDAO dao = new CartDAO();
                List<CartItem> cart = dao.getCart(currentUser.getId());
                out.println("<p>Cart size: " + cart.size() + "</p>");
                for(CartItem item : cart) {
                    out.println("<p>Item: " + item.getProductName() + ", Image: " + item.getImageUrl() + "</p>");
                }
            } else {
                out.println("<p>Not logged in</p>");
            }
        %>
    </body>
</html>
