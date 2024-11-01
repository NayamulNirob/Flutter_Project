package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.InventoryItem;
import com.merchandisemgmt.merchandiseMgmtERP.service.InventoryItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/inventory")
@CrossOrigin("*")
public class InventoryItemRestController {
    @Autowired
    private InventoryItemsService inventoryItemsService;

    @GetMapping("/")
    public ResponseEntity<List<InventoryItem>> getAllInventory() {

        List<InventoryItem> inventory = inventoryItemsService.getInventoryItems();
        return new ResponseEntity<>(inventory, HttpStatus.OK);
    }


    @PostMapping("/save")
    public ResponseEntity<InventoryItem> saveProduct(@RequestBody InventoryItem inventoryItem) {
        InventoryItem saveInventories= inventoryItemsService.save(inventoryItem);
        return new ResponseEntity<>(saveInventories, HttpStatus.CREATED);
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<InventoryItem> updateProduct(@RequestBody InventoryItem inventoryItem,@PathVariable("id") long id) {
        InventoryItem saveInventories= inventoryItemsService.update(inventoryItem,id);
        return new ResponseEntity<>(saveInventories, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<InventoryItem> getInventoryById(@PathVariable("id") Long id) {
        InventoryItem  inventoryItem = inventoryItemsService.findInventoryById(id);
        return new ResponseEntity<>(inventoryItem,HttpStatus.OK);
    }
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteInventoryById(@PathVariable("id") Long id) {
        inventoryItemsService.deleteInvetory(id);
        return new ResponseEntity<>("Deleted",HttpStatus.OK);
    }


}
