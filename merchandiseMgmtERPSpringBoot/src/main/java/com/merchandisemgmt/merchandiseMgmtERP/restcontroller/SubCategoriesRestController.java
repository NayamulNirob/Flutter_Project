package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.SubCategories;
import com.merchandisemgmt.merchandiseMgmtERP.service.SubCategoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/subcategories")
@CrossOrigin("*")
public class SubCategoriesRestController {

    @Autowired
    private SubCategoriesService subCategoriesService;

    @GetMapping("/")
    public ResponseEntity<List<SubCategories>>getAllSubCategories() {
        List<SubCategories> subCategories = subCategoriesService.getAllSubCategories();
        return new ResponseEntity<>(subCategories,HttpStatus.OK);
    }

    @PostMapping("/save")
    public ResponseEntity<SubCategories> saveSubCategories(@RequestBody SubCategories subCategories) {
       SubCategories subCategory= subCategoriesService.saveSubCategories(subCategories);
        return new ResponseEntity<>(subCategory,HttpStatus.OK);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<SubCategories>updateSubCategories(@PathVariable long id, @RequestBody SubCategories subCategories) {
        SubCategories subCategory= subCategoriesService.updateSubCategories(subCategories,id);
        return new ResponseEntity<>(subCategory,HttpStatus.OK);
    }

    @DeleteMapping ("/delete/{id}")
    public ResponseEntity<String> deleteSubCategories(@PathVariable("id") long id) {
        subCategoriesService.deleteSubCategories(id);
        return new ResponseEntity<>( "Supplier Deleted",HttpStatus.OK );
    }
    @GetMapping("/{id}")
    public ResponseEntity<SubCategories> getSubCategories(@PathVariable long id) {
       SubCategories subCategory= subCategoriesService.getSubCategoriesById(id);
        return new ResponseEntity<>(subCategory,HttpStatus.OK);
    }
}
