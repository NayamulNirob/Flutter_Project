package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Country;
import com.merchandisemgmt.merchandiseMgmtERP.service.CountryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/country")
@CrossOrigin("*")
public class CountryRestController {
    @Autowired
    private CountryService countryService;


    @GetMapping("/")
    public ResponseEntity<List<Country>>getAllCountrys() {
        List<Country>Countrys =countryService.getAllCountry();
        return new ResponseEntity<>(Countrys, HttpStatus.OK);
    }
    @PostMapping("/save")
    public ResponseEntity<Country> saveCountry(@RequestBody Country Country) {
        countryService.saveCountry(Country);
        return new ResponseEntity<>(Country, HttpStatus.CREATED);
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<Country> updateCountry(@PathVariable int id, @RequestBody Country Country) {
        Country countrys=countryService.updateCountry(Country,id);
        return new ResponseEntity<>(countrys, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Country> getCountryById(@PathVariable Integer id) {
        Country country= countryService.findCountryById(id);
        return new ResponseEntity<>(country, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteCountryById(@PathVariable Integer id) {
        countryService.deleteCountryById(id);
     return new ResponseEntity<>("Deleted Successfully", HttpStatus.OK);
    }
}
