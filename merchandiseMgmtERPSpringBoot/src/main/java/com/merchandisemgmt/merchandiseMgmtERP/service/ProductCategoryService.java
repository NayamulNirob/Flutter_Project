package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.ProductCategory;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service

public class ProductCategoryService {
    @Autowired
    private ProductCategoryRepository productCategoryRepository;

    @Value("${image.upload.dir}")
    private String uploadDir;


    public List<ProductCategory> viewAllCategories() {
        return productCategoryRepository.findAll();
    }

    @Transactional
    public ProductCategory saveCategory(ProductCategory category, MultipartFile imageFile) throws IOException {
        if(imageFile!=null && !imageFile.isEmpty()){
            String imageFileName=saveImage(imageFile);
            category.setImage(imageFileName);
        }
        return productCategoryRepository.save(category);
    }



    private String saveImage(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);

        }

        String fileName = UUID.randomUUID() +"_"+file.getOriginalFilename().toString();
        Path filePath = uploadPath.resolve(fileName);


        Files.copy(file.getInputStream(), filePath);

        return fileName;
    }


    public ProductCategory findCategoryById(Long id) {
        return productCategoryRepository.findById(id).orElseThrow(
                ()-> new RuntimeException("Product Category Not Found With This Id"+id)
        );
    }
    public ProductCategory updateCategory(ProductCategory productCategory,long id) {
        if (!productCategoryRepository.existsById(id)) {
            throw new RuntimeException("Product Category Not Found With This Id: " + id);
        }
        productCategory.setId(id);
        return productCategoryRepository.save(productCategory);
    }

    public void deleteCategory(long id) {
        if (!productCategoryRepository.existsById(id)) {
            throw new RuntimeException("Product Category Not Found With This Id: " + id);
        }
        productCategoryRepository.deleteById(id);
    }
}
