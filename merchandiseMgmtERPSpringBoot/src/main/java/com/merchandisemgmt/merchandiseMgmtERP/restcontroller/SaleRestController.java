package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Sale;
import com.merchandisemgmt.merchandiseMgmtERP.service.SaleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/sale")
@CrossOrigin("*")
public class SaleRestController {
    @Autowired
    private SaleService saleService;

    @GetMapping("/")
    public ResponseEntity<List<Sale>> getAllSales() {
        List<Sale> sales =saleService.getAllSale();
        return new ResponseEntity<>(sales, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<Sale> createSale(@RequestBody Sale sale) {
       Sale sales =saleService.saveSale(sale);
        return new ResponseEntity<>(sales, HttpStatus.CREATED);
    }

    @PutMapping("/Update/{id}")
    public ResponseEntity<Sale> updateSale(@PathVariable Long id, @RequestBody Sale sale) {
        Sale updatesales=saleService.updateSale(sale, id);
        return new ResponseEntity<>(updatesales, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteSale(@PathVariable Long id) {
        saleService.deleteSale(id);
        return new ResponseEntity<>("Delete Sale Successfully", HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Sale> getSale(@PathVariable Long id) {
       Sale saleById =saleService.findSaleById(id);
        return new ResponseEntity<>(saleById, HttpStatus.OK);
    }
}
