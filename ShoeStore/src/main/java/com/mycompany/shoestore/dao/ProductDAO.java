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
import java.util.Collections;

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

    /**
     * Get product detail by ID
     */
    public Product getProductById(String productId) {
        String sql = "SELECT p.*, "
                + "(SELECT TOP 1 image_url "
                + " FROM product_images pi "
                + " WHERE pi.product_id = p.id "
                + " ORDER BY pi.sort_order) AS first_image, "
                + "c.name AS category_name, "
                + "b.name AS brand_name "
                + "FROM products p "
                + "LEFT JOIN categories c ON p.category_id = c.id "
                + "LEFT JOIN brands b ON p.brand_id = b.id "
                + "WHERE p.id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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

                    Category c = new Category(
                            rs.getString("category_id"),
                            rs.getString("category_name")
                    );
                    Brand b = new Brand(
                            rs.getString("brand_id"),
                            rs.getString("brand_name")
                    );
                    p.setCategory(c);
                    p.setBrand(b);
                    return p;
                }
            }
        } catch (Exception e) {
            System.out.println("Error getProductById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name FROM categories ORDER BY name ASC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(rs.getString("id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT id, name FROM brands ORDER BY name ASC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                brands.add(new Brand(rs.getString("id"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public int countSearchAndFilterProducts(String query, String[] categoryIds, String[] brandIds, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) "
            + "FROM products p "
            + "WHERE p.status = 'active'"
        );
        List<Object> parameters = new ArrayList<>();
        if (query != null && !query.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ?");
            parameters.add("%" + query.trim() + "%");
        }
        if (categoryIds != null && categoryIds.length > 0) {
            sql.append(" AND p.category_id IN (");
            sql.append(String.join(",", Collections.nCopies(categoryIds.length, "?")));
            sql.append(")");
            for (String id : categoryIds) { parameters.add(id); }
        }
        if (brandIds != null && brandIds.length > 0) {
            sql.append(" AND p.brand_id IN (");
            sql.append(String.join(",", Collections.nCopies(brandIds.length, "?")));
            sql.append(")");
            for (String id : brandIds) { parameters.add(id); }
        }
        if (minPrice != null) {
            sql.append(" AND p.price >= ?");
            parameters.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND p.price <= ?");
            parameters.add(maxPrice);
        }
        int count = 0;
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Product> searchAndFilterProducts(String query, String[] categoryIds, String[] brandIds, Double minPrice, Double maxPrice, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, "
            + "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id ORDER BY sort_order ASC) as first_image, "
            + "c.name as category_name, b.name as brand_name "
            + "FROM products p "
            + "LEFT JOIN categories c ON p.category_id = c.id "
            + "LEFT JOIN brands b ON p.brand_id = b.id "
            + "WHERE p.status = 'active'"
        );
        List<Object> parameters = new ArrayList<>();
        if (query != null && !query.trim().isEmpty()) {
            sql.append(" AND p.name LIKE ?");
            parameters.add("%" + query.trim() + "%");
        }
        if (categoryIds != null && categoryIds.length > 0) {
            sql.append(" AND p.category_id IN (");
            sql.append(String.join(",", Collections.nCopies(categoryIds.length, "?")));
            sql.append(")");
            for (String id : categoryIds) {
                parameters.add(id);
            }
        }
        if (brandIds != null && brandIds.length > 0) {
            sql.append(" AND p.brand_id IN (");
            sql.append(String.join(",", Collections.nCopies(brandIds.length, "?")));
            sql.append(")");
            for (String id : brandIds) {
                parameters.add(id);
            }
        }
        if (minPrice != null) {
            sql.append(" AND p.price >= ?");
            parameters.add(minPrice);
        }
        if (maxPrice != null) {
            sql.append(" AND p.price <= ?");
            parameters.add(maxPrice);
        }
        sql.append(" ORDER BY p.created_at DESC");
       
        // Pagination logic for MS SQL Server
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        parameters.add((page - 1) * pageSize);
        parameters.add(pageSize);
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
           
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
           
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
                   
                    p.setCategory(new Category(p.getCategoryId(), rs.getString("category_name")));
                    p.setBrand(new Brand(p.getBrandId(), rs.getString("brand_name")));
                   
                    products.add(p);
                }
            }
        } catch (Exception e) {
            System.err.println("Error searchAndFilterProducts: " + e.getMessage());
            e.printStackTrace();
        }
        return products;
    }
}