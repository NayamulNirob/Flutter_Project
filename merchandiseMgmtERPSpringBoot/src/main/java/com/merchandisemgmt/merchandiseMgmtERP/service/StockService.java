package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Stock;
import com.merchandisemgmt.merchandiseMgmtERP.repository.InventoryItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.StockRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.WareHouseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class StockService {
    @Autowired
    private StockRepository stockRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private WareHouseRepository wareHouseRepository;

    @Autowired
    private InventoryItemRepository inventoryItemRepository;


    public List<Stock> getAllStocks() {
       return stockRepository.findAll();

    }
    public Stock getStockById(long id) {
        return stockRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Stock not found with this Id:"+id)
        );
    }

    public Stock addStock(Stock stock) {
        stock.setCreatedAt(LocalDateTime.now());
        stock.setUpdatedAt(LocalDateTime.now());
        System.out.println("Created At: " + stock.getCreatedAt());
        System.out.println("Updated At: " + stock.getUpdatedAt());
        return stockRepository.save(stock);
    }

    public Stock updateStock(Stock stock,long id) {
        return stockRepository.save(stock);
    }
    public void  deleteStockById(long id) {
       stockRepository.deleteById(id);
    }



}
