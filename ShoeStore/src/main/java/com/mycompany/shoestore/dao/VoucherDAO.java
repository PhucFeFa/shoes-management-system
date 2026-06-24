package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.db.DBContext;
import com.mycompany.shoestore.models.Voucher;

import java.sql.*;
import java.util.*;

public class VoucherDAO {

    DBContext db = new DBContext();

    public List<Voucher> getAvailableVouchers()
            throws Exception {

        List<Voucher> list = new ArrayList<>();

        String sql =
                "SELECT * FROM vouchers "
                + "WHERE quantity > 0 "
                + "AND GETDATE() BETWEEN start_date AND end_date";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Voucher v = new Voucher();

                v.setId(rs.getString("id"));
                v.setCode(rs.getString("code"));
                v.setDiscountPercent(
                        rs.getDouble("discount_percent"));

                list.add(v);
            }
        }

        return list;
    }
    public boolean decreaseVoucherQuantity(String voucherId) throws Exception {

    String sql =
            "UPDATE vouchers "
            + "SET quantity = quantity - 1 "
            + "WHERE id = ? "
            + "AND quantity > 0";

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, voucherId);

        return ps.executeUpdate() > 0;
    }
}
    public Voucher getVoucherById(String voucherId) throws Exception {

    String sql =
            "SELECT id, code, discount_percent "
            + "FROM vouchers "
            + "WHERE id = ? "
            + "AND quantity > 0 "
            + "AND start_date <= SYSDATETIMEOFFSET() "
            + "AND end_date >= SYSDATETIMEOFFSET()";

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, voucherId);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                Voucher voucher = new Voucher();

                voucher.setId(rs.getString("id"));
                voucher.setCode(rs.getString("code"));
                voucher.setDiscountPercent(
                        rs.getDouble("discount_percent"));

                return voucher;
            }
        }
    }

    return null;
}
}