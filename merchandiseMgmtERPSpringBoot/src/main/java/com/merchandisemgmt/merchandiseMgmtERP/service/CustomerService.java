package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Customer;
import com.merchandisemgmt.merchandiseMgmtERP.repository.CustomerRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.OrderItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.SaleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private SaleRepository saleRepository;

    public  List<Customer> getAllCustomer(){
        return customerRepository.findAll();
    }


    public Customer saveCustomer(Customer customer) {
        try{
            customer.setCreatedAt(LocalDateTime.now());
            customer.setUpdatedAt(LocalDateTime.now());
            return customerRepository.save(customer);
        }
        catch(Exception e){
            System.err.println("Error saving customer: " + e.getMessage());
            throw new RuntimeException("Failed to save customer", e);
        }
    }


    public Customer findCustomerById(Long id) {
        return customerRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No customer found with id: " + id)
        );
    }



    public Customer updateCustomer(Customer customer, Long id) {
        try{
            customer.setCreatedAt(LocalDateTime.now());
            customer.setUpdatedAt(LocalDateTime.now());
            return customerRepository.save(customer);
        }
        catch(Exception e){
            System.err.println("Error saving customer: " + e.getMessage());
            throw new RuntimeException("Failed to save customer", e);
        }
    }

    public void deleteCustomerById(Long id) {

        Customer customer = customerRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No customer found with id: " + id)
        );


        long orderCount = orderItemRepository.countByCustomerId(id);
        if (orderCount > 0) {
            throw new RuntimeException("Cannot delete customer with associated orders.");
        }

        long saleCount = saleRepository.countByCustomerId(id);
        if (saleCount > 0) {

            throw new RuntimeException ("Cannot delete customer with associated sale.");
        }


        try {
            customerRepository.delete(customer);
            System.out.println("Customer with id " + id + " successfully deleted.");
        } catch (Exception e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            throw new RuntimeException("Failed to delete customer", e);
        }
    }

}
