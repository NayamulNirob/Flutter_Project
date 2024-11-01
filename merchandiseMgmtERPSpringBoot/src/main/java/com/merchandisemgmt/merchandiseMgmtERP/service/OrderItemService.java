package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.OrderItem;
import com.merchandisemgmt.merchandiseMgmtERP.entity.Product;
import com.merchandisemgmt.merchandiseMgmtERP.repository.OrderItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemService {

    @Autowired
    private OrderItemRepository orderItemRepository;
    @Autowired
    private ProductRepository productRepository;


    public List<OrderItem> getAllOrderItems() {
        return orderItemRepository.findAll();
    }



    public OrderItem saveOrderItem(OrderItem orderItem) {
        try{
            Product product = orderItem.getProduct();
            orderItem.setTotalPrice(orderItem.getQuantity() * orderItem.getProduct().getPrice());
            return orderItemRepository.save(orderItem);
        }
        catch(Exception e){
            System.err.println("Error saving order item: " + e.getMessage());
            throw new RuntimeException("Failed to save order item", e);
        }
    }



    public OrderItem getOrderItemById(Long id) {
        return orderItemRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Order item with id " + id + " not found")
        );
    }


    public OrderItem updateOrderItem(OrderItem orderItem,long id) {
        return orderItemRepository.save(orderItem);
    }



    public void deleteOrderItemById(Long id) {
        orderItemRepository.deleteById(id);
    }
}
