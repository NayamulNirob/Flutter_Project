package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.WareHouse;
import com.merchandisemgmt.merchandiseMgmtERP.service.WereHouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/warehouse")
@CrossOrigin("*")
public class WarehouseRestController {

    @Autowired
    private WereHouseService wereHouseService;

    @GetMapping("/")
    public ResponseEntity <List<WareHouse>> getAllWarehouses() {
        List<WareHouse> wareHouses = wereHouseService.getAllWarehouses();
        return new ResponseEntity<>(wareHouses,HttpStatus.OK);
    }


    @PostMapping("/save")
    public ResponseEntity<WareHouse> saveWarehouse(@RequestBody WareHouse warehouse) {
        WareHouse saveWareHouse = wereHouseService.saveWarehouse(warehouse);
        return new ResponseEntity<>(saveWareHouse, HttpStatus.CREATED);
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<WareHouse> updateWarehouse(@RequestBody WareHouse warehouse, @PathVariable("id") Long Id) {
        WareHouse updateWareHouse =wereHouseService.updateWarehouse(warehouse,Id);
        return new ResponseEntity<>(updateWareHouse,HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteWarehouse(@PathVariable("id") Long id) {
        wereHouseService.deleteWarehouseById(id);
        return new ResponseEntity<>("WareHouse Deleted",HttpStatus.OK);

    }



    @GetMapping("/{id}")
    public ResponseEntity<WareHouse> getWarehouseById(@PathVariable("id") Long id) {
        WareHouse warehouse = wereHouseService.getWarehouseById(id);
        return new ResponseEntity<>(warehouse,HttpStatus.OK);
    }





}
