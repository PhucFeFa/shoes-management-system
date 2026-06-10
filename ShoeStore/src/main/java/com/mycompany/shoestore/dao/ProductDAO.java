// Author: PhucLHCE191132
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Product;
import com.mycompany.shoestore.models.Category;
import com.mycompany.shoestore.models.Brand;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getLatestProducts(int limit) {
        List<Product> products = new ArrayList<>();
        // Query to get latest active products with their first image
        String sql = "SELECT TOP (?) p.*, "
                   + "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id) as first_image, "
                   + "c.name as category_name, b.name as brand_name "
                   + "FROM products p "
                   + "LEFT JOIN categories c ON p.category_id = c.id "
                   + "LEFT JOIN brands b ON p.brand_id = b.id "
                   + "WHERE p.status = 'active' "
                   + "ORDER BY p.created_at DESC";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getString("id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setCategoryId(rs.getString("category_id"));
                    p.setBrandId(rs.getString("brand_id"));
                    p.setStatus(rs.getString("status"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    p.setFirstImageUrl(rs.getString("first_image"));
                    
                    Category c = new Category(p.getCategoryId(), rs.getString("category_name"));
                    Brand b = new Brand(p.getBrandId(), rs.getString("brand_name"));
                    p.setCategory(c);
                    p.setBrand(b);
                    
                    products.add(p);
                }
            }
        } catch (Exception e) {
            System.err.println("Error getLatestProducts: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }
}
