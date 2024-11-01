package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.SubCategories;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductRepository;
import com.merchandisemgmt.merchandiseMgmtERP.repository.SubCategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SubCategoriesService {
    @Autowired
    private SubCategoriesRepository subCategoriesRepository;

    @Autowired
    private ProductRepository productRepository;

    public List<SubCategories> getAllSubCategories() {
        return subCategoriesRepository.findAll();
    }

    public SubCategories getSubCategoriesById(long id) {
        return subCategoriesRepository.findById(id).orElseThrow(
                () -> new RuntimeException("SubCategories not found with this Id"+id)
        );
    }
    public SubCategories saveSubCategories(SubCategories subCategories) {
        return subCategoriesRepository.save(subCategories);
    }
    public SubCategories updateSubCategories(SubCategories subCategories, long id) {
        return subCategoriesRepository.save(subCategories);
    }
    public void deleteSubCategories(long id) {
        subCategoriesRepository.deleteById(id);
    }
}
