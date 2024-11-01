package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Country;
import com.merchandisemgmt.merchandiseMgmtERP.repository.CountryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class CountryService {
    @Autowired
    private CountryRepository countryRepository;

    public  List<Country> getAllCountry(){
        return countryRepository.findAll();
    }


    public Country saveCountry(Country Country) {
        return countryRepository.save(Country);
    }


    public Country findCountryById(Integer id) {
        return countryRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No Country found with id: " + id)
        );
    }



    public Country updateCountry(Country Country, Integer id) {
         return countryRepository.save(Country);
    }

    public void deleteCountryById(Integer id) {

        Country country = countryRepository.findById(id).orElseThrow(
                () -> new RuntimeException("No Country found with id: " + id));
    }

}
