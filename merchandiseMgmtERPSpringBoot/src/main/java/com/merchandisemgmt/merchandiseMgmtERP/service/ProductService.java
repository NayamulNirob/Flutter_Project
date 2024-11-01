package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.InventoryItem;
import com.merchandisemgmt.merchandiseMgmtERP.entity.Product;
import com.merchandisemgmt.merchandiseMgmtERP.repository.InventoryItemRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
public class ProductService {

    @Autowired
    private  ProductRepository productRepository;
    @Autowired
    private InventoryItemRepository inventoryItemRepository;

    @Value("${image.upload.dir}")
    private String uploadDir;


    private String saveImage(MultipartFile file) throws IOException {
        Path uploadProductPath = Paths.get(uploadDir);

        if (!Files.exists(uploadProductPath)) {
            Files.createDirectories(uploadProductPath);

        }

        String fileName = UUID.randomUUID() +"_"+file.getOriginalFilename().toString();
        Path filePath = uploadProductPath.resolve(fileName);


        Files.copy(file.getInputStream(), filePath);

        return fileName;
    }



    @Transactional
    public Product saveProduct(Product p,MultipartFile imageFile) throws IOException {

        try {

            if(imageFile!=null && !imageFile.isEmpty()){
                String imageFileName=saveImage(imageFile);
                p.setImage(imageFileName);
            }

            double totalPriceWithoutTax = p.getQuantity() * p.getPrice();


            double taxAmount = totalPriceWithoutTax * (p.getTax() / 100);


            double totalPrice = totalPriceWithoutTax + taxAmount;

            double due= p.getPaid()-totalPrice;
            p.setDue(due);
            p.setTotalPrice(totalPrice);
            return productRepository.save(p);
        } catch (Exception e) {
            System.err.println("Error saving product: " + e.getMessage());
            throw new RuntimeException("Failed to save product", e);
        }
    }

    public List<Product> getAllProduct() {
        return productRepository.findAll();
    }

    public void deleteProductById(Long id) {
        List<InventoryItem> items=inventoryItemRepository.getByProductId(id);
        for(InventoryItem item:items){
            item.setProduct(null);
            inventoryItemRepository.save(item);
        }
        productRepository.deleteById(id);
    }


    public Product findProductById(Long id) {
        return productRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No Faculty found with id: " + id)
        );
    }

    public Product updateProduct(Product p, Long id) {
        return productRepository.save(p);
    }
}
