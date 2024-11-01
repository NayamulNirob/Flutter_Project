package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;
import com.merchandisemgmt.merchandiseMgmtERP.entity.Stock;
import com.merchandisemgmt.merchandiseMgmtERP.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("api/stock")
@CrossOrigin("*")
public class StockRestController {
    @Autowired
    private StockService stockService;

    @GetMapping("/")
    public ResponseEntity<List<Stock>> getAllStocks() {
        List<Stock> stocks =stockService.getAllStocks();
        return new ResponseEntity<>(stocks, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<Stock> createStock(@RequestBody Stock Stock) {
        Stock stocks =stockService.addStock(Stock);
        return new ResponseEntity<>(stocks, HttpStatus.CREATED);
    }

    @PutMapping("/Update/{id}")
    public ResponseEntity<Stock> updateStock(@PathVariable Integer id, @RequestBody Stock Stock) {
        Stock updateStocks=stockService.updateStock(Stock, id);
        return new ResponseEntity<>(updateStocks, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteStock(@PathVariable Integer id) {
        stockService.deleteStockById(id);
        return new ResponseEntity<>("Delete Stock Successfully", HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Stock> getStock(@PathVariable Integer id) {
        Stock stockById =stockService.getStockById(id);
        return new ResponseEntity<>(stockById, HttpStatus.OK);
    }
    
}
