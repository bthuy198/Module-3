package com.example.customers.Service.mysql;

import com.example.customers.Service.ICustomerService;
import com.example.customers.model.Customer;
import com.example.customers.model.CustomerType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MSCustomerService extends DBContext implements ICustomerService {
    private static final String SELLECT_ALL_CUSTOMER = "SELECT * FROM customer";
    private static final String SELLECT_CUSTOMER = "SELECT * FROM customer where `id` = ?";
    private static final String INSERT_CUSTOMER = "INSERT INTO `customer` (`id`, `name`, `birthday`, `address`,`img`, `idType`) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String DELETE_CUSTOMER_BY_ID = "DELETE FROM `customer` WHERE (`id` = ?);";

    private static final String UPDATE_CUSTOMER_BY_ID = "UPDATE `customer` SET `name` = ?, `birthday` = ?,`address` = ?, `img` = ?, `idType` = ? WHERE `id` = ?";
    private static final String CHECK_IMAGE_EXIST = "SELECT * FROM customer where `img` = ?";

    @Override
    public List<Customer> getAllCustomer() {
        List<Customer> customers = new ArrayList<>();
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELLECT_ALL_CUSTOMER);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Customer c = getCustomerFromRs(rs);
                customers.add(c);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return customers;
    }

    private Customer getCustomerFromRs(ResultSet rs) throws SQLException {
        Long id = rs.getLong("id");
        String name = rs.getString("name");
        java.sql.Date sqlBirthday = rs.getDate("birthday");
        java.util.Date uBirthday = new java.util.Date(sqlBirthday.getTime());
        String address = rs.getString("address");
        String image = rs.getString("img");
        Long idType = rs.getLong("idType");

        Customer customer = new Customer(id, name, uBirthday, address, image, idType);
        return customer;
    }

    @Override
    public Customer findCustomerById(Long id) {
        Connection connection = getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(SELLECT_CUSTOMER);
            ps.setLong(1, id);
            ResultSet resultSet = ps.executeQuery();
            while (resultSet.next()) {
                Customer costomer = getCustomerFromRs(resultSet);
                return costomer;
            }
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void editCustomer(Customer customer) {
        Connection connection = getConnection();
        //UPDATE Customer
        //SET name = 'Alfred Schmidt', address= 'Frankfurt'
        //WHERE id = 1;
        try {
            PreparedStatement ps = connection.prepareStatement(UPDATE_CUSTOMER_BY_ID);
            ps.setLong(6, customer.getId());
            ps.setString(1, customer.getName());
            ps.setDate(2, new java.sql.Date(customer.getBirthday().getTime()));
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getImg());
            ps.setLong(5, customer.getIdType());

            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteCustomerById(Long id) {
        Connection connection = getConnection();
        //DELETE FROM customer` WHERE (`id` = ?)
        try {
            PreparedStatement ps = connection.prepareStatement(DELETE_CUSTOMER_BY_ID);
            ps.setLong(1, id);

            ps.executeUpdate();
            // DELETE FROM customer` WHERE (`id` = 3)
            System.out.println("deleteCustomerById: " + ps);
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
    }

    @Override
    public void createCustomer(Customer customer) {
        Connection connection = getConnection();
        //DELETE FROM customer` WHERE (`id` = ?)
        try {

            //INSERT INTO `customer` (`id`, `name`, `birthday`, `address`, `idType`)
            // VALUES ('?', '?', '?', '?', '?');";
            PreparedStatement ps = connection.prepareStatement(INSERT_CUSTOMER);
            ps.setLong(1, customer.getId());
            ps.setString(2, customer.getName());
            ps.setDate(3, new java.sql.Date(customer.getBirthday().getTime()));
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getImg());
            ps.setLong(6, customer.getIdType());

            ps.executeUpdate();
            ps.close();
            // DELETE FROM customer` WHERE (`id` = 3)
            System.out.println("deleteCustomerById: " + ps);
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
    }

    @Override
    public boolean checkImageExists(String fileName) {
        Connection connection = getConnection();
        try {
            PreparedStatement ps = connection.prepareStatement(CHECK_IMAGE_EXIST);
            ps.setString(1, fileName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }


}
