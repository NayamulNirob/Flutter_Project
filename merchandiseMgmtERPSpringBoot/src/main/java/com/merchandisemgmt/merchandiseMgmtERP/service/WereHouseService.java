package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.InventoryItem;
import com.merchandisemgmt.merchandiseMgmtERP.entity.WareHouse;
import com.merchandisemgmt.merchandiseMgmtERP.repository.InventoryItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.WareHouseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WereHouseService {

    @Autowired
    private WareHouseRepository wareHouseRepository;
    @Autowired
    private InventoryItemRepository inventoryItemRepository;

    public List<WareHouse> getAllWarehouses() {
        return wareHouseRepository.findAll();
    }

    public WareHouse saveWarehouse(WareHouse warehouse) {

        try {
            return wareHouseRepository.save(warehouse);
        } catch (Exception e) {
            System.err.println("Error saving product: " + e.getMessage());
            throw new RuntimeException("Failed to save product", e);
        }
    }

    public WareHouse getWarehouseById(Long id) {
        return wareHouseRepository.findById(id).orElseThrow(
                () -> new RuntimeException("WareHouse with id " + id + " not found")
        );
    }

    public WareHouse updateWarehouse(WareHouse warehouse, long id) {
        return wareHouseRepository.save(warehouse);
    }

    public void deleteWarehouseById(Long id) {

        List<InventoryItem> items = inventoryItemRepository.findByWareHouseId(id);
        for (InventoryItem item : items) {
            item.setWareHouse(null);
            inventoryItemRepository.save(item);
        }

        wareHouseRepository.deleteById(id);
    }




}
