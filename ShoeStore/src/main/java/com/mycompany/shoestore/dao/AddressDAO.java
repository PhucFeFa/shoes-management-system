/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shoestore.dao;

import com.mycompany.shoestore.models.Address;
import com.mycompany.shoestore.db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pts03
 */
public class AddressDAO {

    public boolean addAddress(Address address) {

        String sql = "INSERT INTO Addresses\n" + "(user_id, city, district, ward, address_line)\n" + "VALUES (?, ?, ?, ?, ?)\n";

        try (
                 Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, address.getUserId());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getDistrict());
            ps.setString(4, address.getWard());
            ps.setString(5, address.getAddressLine());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Address> getAddressesByUserId(String userId) {
        List<Address> list = new ArrayList<>();

        String sql
                = "SELECT id,user_id, city, district, ward, address_line "
                + "FROM addresses "
                + "WHERE user_id = ?";

        try (
                 Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Address a = new Address();

                a.setId(rs.getString("id"));
                a.setUserId(rs.getString("user_id"));
                a.setCity(rs.getString("city"));
                a.setDistrict(rs.getString("district"));
                a.setWard(rs.getString("ward"));
                a.setAddressLine(rs.getString("address_line"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean deleteAddress(String id) {

        String sql
                = "DELETE FROM addresses WHERE id = ?";

        try (
                 Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateAddress(Address address) {

        String sql
                = "UPDATE addresses "
                + "SET city=?, district=?, ward=?, address_line=? "
                + "WHERE id=?";

        try (
                 Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, address.getCity());
            ps.setString(2, address.getDistrict());
            ps.setString(3, address.getWard());
            ps.setString(4, address.getAddressLine());
            ps.setString(5, address.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public Address getAddressById(String id) {

        String sql
                = "SELECT * FROM addresses WHERE id = ?";

        try (
                 Connection con = new DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Address address = new Address();

                address.setId(rs.getString("id"));
                address.setUserId(rs.getString("user_id"));
                address.setCity(rs.getString("city"));
                address.setDistrict(rs.getString("district"));
                address.setWard(rs.getString("ward"));
                address.setAddressLine(rs.getString("address_line"));

                return address;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
