/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author pts03
 */
public class PaymentDAO {
    public void createCODPayment(String orderId, double amount) throws Exception {
        String sql = "INSERT INTO payments (id, order_id, method, status, amount) " +
                     "VALUES (NEWID(), ?, 'cod', 'pending', ?)";

        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, orderId);
            ps.setDouble(2, amount);
            ps.executeUpdate();
        }
    }
}
