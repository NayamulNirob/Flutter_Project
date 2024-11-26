package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Product;
import com.merchandisemgmt.merchandiseMgmtERP.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("api/product")
@CrossOrigin("*")
public class ProductRestController {
    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public ResponseEntity<List<Product>> getAllProduct() {

        List<Product> products = productService.getAllProduct();
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<Product> saveProduct(
            @RequestPart Product product,
            @RequestParam(value = "image", required = false) MultipartFile imageFile) {
        try {
        productService.saveProduct(product,imageFile);
        return new ResponseEntity<>(product, HttpStatus.CREATED);
        } catch (IOException e) {
            return new ResponseEntity<>(product, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Product> updateProduct(@RequestBody Product p, @PathVariable("id") long id) {
        Product updatedProduct= productService.updateProduct(p, id);
        return new ResponseEntity<>(updatedProduct, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable("id") long id) {

        productService.deleteProductById(id);
        return new ResponseEntity<>( "Product Deleted",HttpStatus.OK );
    }

    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable("id") long id) {
    Product product= productService.findProductById(id);
        return ResponseEntity.ok(product);
    }


}
