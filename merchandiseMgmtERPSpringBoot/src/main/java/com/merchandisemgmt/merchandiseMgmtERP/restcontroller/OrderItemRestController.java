package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.OrderItem;
import com.merchandisemgmt.merchandiseMgmtERP.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/order")
@CrossOrigin("*")
public class OrderItemRestController {

    @Autowired
    private OrderItemService orderItemService;

    @GetMapping("/")
    public ResponseEntity<List<OrderItem>> getOrderItems() {
        List<OrderItem> orderItems = orderItemService.getAllOrderItems();
        return new ResponseEntity<>(orderItems, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<OrderItem> addOrderItem(@RequestBody OrderItem orderItem) {
        OrderItem orderItemSaved = orderItemService.saveOrderItem(orderItem);
        return new ResponseEntity<>(orderItemSaved, HttpStatus.CREATED);
    }


    @PutMapping("/update/{id}")
    public ResponseEntity<OrderItem> updateOrder(@RequestBody OrderItem orderItem, @PathVariable("id") long id) {
        OrderItem orderItems= orderItemService.updateOrderItem(orderItem,id);
        return new ResponseEntity<>(orderItems, HttpStatus.OK);
    }



    @GetMapping("/{id}")
    public ResponseEntity<OrderItem> getOrderById(@PathVariable("id") Long id) {
        OrderItem orderItem = orderItemService.getOrderItemById(id);
        return new ResponseEntity<>(orderItem,HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<OrderItem> deleteOrder(@PathVariable("id") Long id) {
       OrderItem orderItem= orderItemService.getOrderItemById(id);
        return new ResponseEntity<>(orderItem, HttpStatus.OK);
    }


}
