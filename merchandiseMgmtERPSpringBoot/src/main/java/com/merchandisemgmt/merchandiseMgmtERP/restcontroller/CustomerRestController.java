package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Customer;
import com.merchandisemgmt.merchandiseMgmtERP.repository.CustomerRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.OrderItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.SaleRepository;
import com.merchandisemgmt.merchandiseMgmtERP.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/customer")
@CrossOrigin("*")
public class CustomerRestController {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private OrderItemRepository orderItemRepository;
    @Autowired
    private SaleRepository saleRepository;

    @GetMapping("/")
    public ResponseEntity<List<Customer>>getAllCustomers() {
        List<Customer>customers =customerService.getAllCustomer();
        return new ResponseEntity<>(customers, HttpStatus.OK);
    }
    @PostMapping("/save")
    public ResponseEntity<Customer> saveCustomer(@RequestBody Customer customer) {
        customerService.saveCustomer(customer);
        return new ResponseEntity<>(customer, HttpStatus.CREATED);
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<Customer> updateCustomer(@PathVariable long id, @RequestBody Customer customer) {
        Customer customers=customerService.updateCustomer(customer,id);
        return new ResponseEntity<>(customers, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Customer> getCustomerById(@PathVariable long id) {
        Customer customer= customerService.findCustomerById(id);
        return new ResponseEntity<>(customer, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteCustomerById(@PathVariable Long id) {

        Customer customer = customerRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No customer found with id: " + id)
        );

        try {
            customerRepository.delete(customer);
            return ResponseEntity.ok("Customer deleted successfully.");
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete customer", e);
        }
    }




}
