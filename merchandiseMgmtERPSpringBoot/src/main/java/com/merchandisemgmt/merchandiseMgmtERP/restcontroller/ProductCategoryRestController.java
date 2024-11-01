package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.ProductCategory;
import com.merchandisemgmt.merchandiseMgmtERP.service.ProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("api/category")
@CrossOrigin("*")
public class ProductCategoryRestController {
    @Autowired
    private ProductCategoryService productCategoryService;


    @GetMapping("/")
    public ResponseEntity<List<ProductCategory>> getAllProductCategory() {

        List<ProductCategory> categories = productCategoryService.viewAllCategories();
        return new ResponseEntity<>(categories, HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<ProductCategory> saveProductCategory(
            @RequestPart(value = "category") ProductCategory category,
            @RequestParam(value = "image", required = false) MultipartFile imageFile) {
        try {
            productCategoryService.saveCategory(category, imageFile);
            return new ResponseEntity<>(category, HttpStatus.CREATED);
        } catch (IOException e) {
            return new ResponseEntity<>(category, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<ProductCategory> updateProductCategory(@RequestBody ProductCategory category, @PathVariable("id") long id) {
        ProductCategory updatedCategory= productCategoryService.updateCategory(category, id);
        return new ResponseEntity<>(updatedCategory, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteProductCategory(@PathVariable("id") long id) {

        productCategoryService.deleteCategory(id);
        return new ResponseEntity<>( "ProductCategory Deleted",HttpStatus.OK );
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductCategory> getProductCategoryById(@PathVariable("id") long id) {
        ProductCategory category= productCategoryService.findCategoryById(id);
        return ResponseEntity.ok(category);
    }


}
