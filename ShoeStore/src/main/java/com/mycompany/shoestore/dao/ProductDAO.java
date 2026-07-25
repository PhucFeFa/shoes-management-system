// Author: PhucLHCE191132
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Product;
import com.mycompany.shoestore.models.Category;
import com.mycompany.shoestore.models.Brand;
import com.mycompany.shoestore.models.ProductVariant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.Set;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name, b.name as brand_name " +
                "FROM products p " +
                "LEFT JOIN categories c ON p.category_id = c.id " +
                "LEFT JOIN brands b ON p.brand_id = b.id " +
                "ORDER BY p.name ASC";

        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getString("category_id"));
                product.setBrandId(rs.getString("brand_id"));
                product.setStatus(rs.getString("status"));

                Category c = new Category();
                c.setName(rs.getString("category_name"));
                product.setCategory(c);

                Brand b = new Brand();
                b.setName(rs.getString("brand_name"));
                product.setBrand(b);

                // Get one image for the product
                String imageSql = "SELECT TOP 1 image_url FROM product_images WHERE product_id = ? ORDER BY sort_order";
                try (PreparedStatement ips = conn.prepareStatement(imageSql)) {
                    ips.setString(1, product.getId());
                    try (ResultSet irs = ips.executeQuery()) {
                        if (irs.next()) {
                            product.setFirstImageUrl(irs.getString("image_url"));
                        }
                    }
                }

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getLatestProducts(int limit) {
        List<Product> products = new ArrayList<>();
        // Query to get latest active products with their first image
        String sql = "SELECT TOP (?) p.*, "
                + "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id) as first_image, "
                + "ISNULL((SELECT AVG(CAST(rating AS FLOAT)) FROM reviews r WHERE r.product_id = p.id), 0) as avg_rating, "
                + "(SELECT COUNT(*) FROM reviews r WHERE r.product_id = p.id) as review_count, "
                + "c.name as category_name, b.name as brand_name "
                + "FROM products p "
                + "LEFT JOIN categories c ON p.category_id = c.id "
                + "LEFT JOIN brands b ON p.brand_id = b.id "
                + "WHERE p.status = 'active' "
                + "ORDER BY p.created_at DESC";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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
                    p.setAverageRating(rs.getDouble("avg_rating"));
                    p.setReviewCount(rs.getInt("review_count"));

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
                + "ISNULL((SELECT AVG(CAST(rating AS FLOAT)) FROM reviews r WHERE r.product_id = p.id), 0) as avg_rating, "
                + "(SELECT COUNT(*) FROM reviews r WHERE r.product_id = p.id) as review_count, "
                + "c.name AS category_name, "
                + "b.name AS brand_name "
                + "FROM products p "
                + "LEFT JOIN categories c ON p.category_id = c.id "
                + "LEFT JOIN brands b ON p.brand_id = b.id "
                + "WHERE p.id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
                    p.setAverageRating(rs.getDouble("avg_rating"));
                    p.setReviewCount(rs.getInt("review_count"));
                    p.setFirstImageUrl(rs.getString("first_image"));

                    Category c = new Category(
                            rs.getString("category_id"),
                            rs.getString("category_name"));
                    Brand b = new Brand(
                            rs.getString("brand_id"),
                            rs.getString("brand_name"));
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

    public String getOrCreateCategory(String categoryName) {
        String checkSql = "SELECT id FROM categories WHERE name = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setString(1, categoryName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getString("id");
            }
            String insertSql = "INSERT INTO categories (id, name) VALUES (NEWID(), ?)";
            try (PreparedStatement psIns = conn.prepareStatement(insertSql)) {
                psIns.setString(1, categoryName);
                if (psIns.executeUpdate() > 0) {
                    try (PreparedStatement psSel = conn.prepareStatement(checkSql)) {
                        psSel.setString(1, categoryName);
                        try (ResultSet rs2 = psSel.executeQuery()) {
                            if (rs2.next())
                                return rs2.getString("id");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getOrCreateBrand(String brandName) {
        String checkSql = "SELECT id FROM brands WHERE name = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setString(1, brandName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getString("id");
            }
            String insertSql = "INSERT INTO brands (id, name) VALUES (NEWID(), ?)";
            try (PreparedStatement psIns = conn.prepareStatement(insertSql)) {
                psIns.setString(1, brandName);
                if (psIns.executeUpdate() > 0) {
                    try (PreparedStatement psSel = conn.prepareStatement(checkSql)) {
                        psSel.setString(1, brandName);
                        try (ResultSet rs2 = psSel.executeQuery()) {
                            if (rs2.next())
                                return rs2.getString("id");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String insertProduct(Product p, String imageUrl) {
        String newId = java.util.UUID.randomUUID().toString();
        p.setId(newId);
        String sql = "INSERT INTO products (id, name, description, price, category_id, brand_id, status) VALUES (?, ?, ?, ?, ?, ?, 'inactive')";

        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newId);
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setString(5, p.getCategoryId());
            ps.setString(6, p.getBrandId());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    String imgSql = "INSERT INTO product_images (product_id, image_url, sort_order) VALUES (?, ?, 1)";
                    try (PreparedStatement psImg = conn.prepareStatement(imgSql)) {
                        psImg.setString(1, newId);
                        psImg.setString(2, imageUrl);
                        psImg.executeUpdate();
                    }
                }
                return newId;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertProductImage(String productId, String imageUrl, int sortOrder) {
        String sql = "INSERT INTO product_images (product_id, image_url, sort_order) VALUES (?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, imageUrl);
            ps.setInt(3, sortOrder);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteProductImagesByProductId(String productId) {
        String sql = "DELETE FROM product_images WHERE product_id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            return ps.executeUpdate() >= 0; // return true even if 0 rows deleted
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProduct(Product p) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, category_id = ?, brand_id = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getCategoryId());
            ps.setString(5, p.getBrandId());
            ps.setString(6, p.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean toggleProductStatus(String productId) {
        String sql = "UPDATE products SET status = CASE WHEN status = 'active' THEN 'inactive' ELSE 'active' END WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCategory(String categoryId) {
        String checkSql = "SELECT COUNT(*) FROM products WHERE category_id = ?";
        String deleteSql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = new DBContext().getConnection()) {
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setString(1, categoryId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false; // Cannot delete, in use by products
                    }
                }
            }
            try (PreparedStatement psDel = conn.prepareStatement(deleteSql)) {
                psDel.setString(1, categoryId);
                return psDel.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBrand(String brandId) {
        String checkSql = "SELECT COUNT(*) FROM products WHERE brand_id = ?";
        String deleteSql = "DELETE FROM brands WHERE id = ?";
        try (Connection conn = new DBContext().getConnection()) {
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setString(1, brandId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return false; // Cannot delete, in use by products
                    }
                }
            }
            try (PreparedStatement psDel = conn.prepareStatement(deleteSql)) {
                psDel.setString(1, brandId);
                return psDel.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCategory(String id, String newName) {
        String sql = "UPDATE categories SET name = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newName);
            ps.setString(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBrand(String id, String newName) {
        String sql = "UPDATE brands SET name = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newName);
            ps.setString(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countSearchAndFilterProducts(String query, String[] categoryIds, String[] brandIds, Double minPrice,
            Double maxPrice) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                        + "FROM products p "
                        + "WHERE p.status = 'active'");
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

    public List<Product> searchAndFilterProducts(String query, String[] categoryIds, String[] brandIds, Double minPrice,
            Double maxPrice, int page, int pageSize) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.*, "
                        + "(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id ORDER BY sort_order ASC) as first_image, "
                        + "ISNULL((SELECT AVG(CAST(rating AS FLOAT)) FROM reviews r WHERE r.product_id = p.id), 0) as avg_rating, "
                        + "(SELECT COUNT(*) FROM reviews r WHERE r.product_id = p.id) as review_count, "
                        + "c.name as category_name, b.name as brand_name "
                        + "FROM products p "
                        + "LEFT JOIN categories c ON p.category_id = c.id "
                        + "LEFT JOIN brands b ON p.brand_id = b.id "
                        + "WHERE p.status = 'active'");
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
                    p.setAverageRating(rs.getDouble("avg_rating"));
                    p.setReviewCount(rs.getInt("review_count"));
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

    public List<ProductVariant> getVariantsByProductId(String productId) {

        List<ProductVariant> list = new ArrayList<>();

        String sql = "SELECT * "
                + "FROM product_variants "
                + "WHERE product_id = ?";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductVariant v = new ProductVariant();

                v.setId(rs.getString("id"));
                v.setProductId(rs.getString("product_id"));
                v.setSize(rs.getString("size"));
                v.setColor(rs.getString("color"));
                v.setStockQuantity(rs.getInt("stock_quantity"));

                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Set<String> getSizesByProduct(String productId) {

        Set<String> sizes = new LinkedHashSet<>();

        String sql = "SELECT DISTINCT size "
                + "FROM product_variants "
                + "WHERE product_id = ? "
                + "ORDER BY size";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                sizes.add(rs.getString("size"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sizes;
    }

    public Set<String> getColorsByProduct(String productId) {

        Set<String> colors = new LinkedHashSet<>();

        String sql = "SELECT DISTINCT color "
                + "FROM product_variants "
                + "WHERE product_id = ? "
                + "ORDER BY color";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                colors.add(rs.getString("color"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return colors;
    }

    public List<String> getColorsByProductAndSize(
            String productId,
            String size) throws Exception {

        List<String> list = new ArrayList<>();

        // product_variants stores size and color directly as strings
        String sql = "SELECT DISTINCT color " +
                "FROM product_variants " +
                "WHERE product_id = ? " +
                "AND size = ? " +
                "AND stock_quantity > 0 " +
                "ORDER BY color";

        try (
                Connection con = new DBContext().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, productId);
            ps.setString(2, size);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getString("color"));
            }
        }

        return list;
    }

}
