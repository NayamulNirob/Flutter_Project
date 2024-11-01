package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Supplier;
import com.merchandisemgmt.merchandiseMgmtERP.service.CountryService;
import com.merchandisemgmt.merchandiseMgmtERP.service.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/supplier")
@CrossOrigin("*")
public class SupplierRestController {
    @Autowired
    private SupplierService supplierService;
    @Autowired
    private CountryService countryService;

    @GetMapping("/")
    public ResponseEntity<List<Supplier>> getAllSupplier() {

        List<Supplier> suppliers = supplierService.getAllSuppliers();
        return new ResponseEntity<>(suppliers, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<Supplier> saveSupplier(@RequestBody Supplier supplier) {
//        supplier.setCreatedAt(LocalDateTime.now());
//        supplier.setUpdatedAt(LocalDateTime.now());
//        Country country = countryService.findCountryById(supplier.getCountry().getId());
//        supplier.setCountry(country);
        Supplier saveSupplier= supplierService.SaveSupplier(supplier);
        return new ResponseEntity<>(saveSupplier, HttpStatus.CREATED);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Supplier> updateSupplier(@RequestBody Supplier s, @PathVariable("id") long id) {
        Supplier updatedSupplier= supplierService.updateSupplier(s, id);
        return new ResponseEntity<>(updatedSupplier, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteSupplier(@PathVariable("id") long id) {

        supplierService.deleteSupplierById(id);
        return new ResponseEntity<>( "Supplier Deleted",HttpStatus.OK );
    }

    @GetMapping("/{id}")
    public ResponseEntity<Supplier> getSupplierById(@PathVariable("id") long id) {
        Supplier supplier= supplierService.findSupplierById(id);
        return ResponseEntity.ok(supplier);
    }



}
