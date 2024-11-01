package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.InventoryItem;
import com.merchandisemgmt.merchandiseMgmtERP.entity.Product;
import com.merchandisemgmt.merchandiseMgmtERP.repository.InventoryItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InventoryItemsService {

    @Autowired
    private InventoryItemRepository inventoryItemRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<InventoryItem> getInventoryItems() {
        return inventoryItemRepository.findAll();
    }


    public InventoryItem findInventoryById(Long id) {
        return inventoryItemRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No InventoryItem found with id: " + id)
        );
    }

    public InventoryItem save(InventoryItem inventoryItem) {
        Optional<Product>product = productRepository.findById(inventoryItem.getProduct().getId());
        if(!product.isPresent()) {
            throw new RuntimeException("No Product found with id: " + inventoryItem.getProduct().getId());
        }
        InventoryItem existingInventory = inventoryItemRepository.findByProductId(inventoryItem.getProduct().getId())
                .orElse(null);

        if (existingInventory != null) {


            existingInventory.setStock(existingInventory.getStock() + inventoryItem.getStock());
            existingInventory.setWareHouse(inventoryItem.getWareHouse());



            inventoryItemRepository.save(existingInventory);
            return existingInventory;
        }

        inventoryItemRepository.save(inventoryItem);
        return inventoryItem;
    }

    public InventoryItem update(InventoryItem inventoryItem,long id) {
        return inventoryItemRepository.save(inventoryItem);
    }

    public void deleteInvetory(long id) {
        inventoryItemRepository.deleteById(id);
    }

}
