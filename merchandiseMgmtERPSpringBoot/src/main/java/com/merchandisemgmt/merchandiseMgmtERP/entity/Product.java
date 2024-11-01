package com.merchandisemgmt.merchandiseMgmtERP.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.security.SecureRandom;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "products")

public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private double price;

    private String productCode;

    private Date purchaseDate;

    private int quantity;

    private double tax;

    private double paid;

    private double due;

    private double totalPrice;

    private String image;

    private String sizes;



    private static final String CHARACTERS = "hijklmnopqrstuvwxyz456789";
    private static final int CODE_LENGTH = 5;
    private static final SecureRandom RANDOM = new SecureRandom();

    @PrePersist
    private void generateProductCode() {
        this.productCode = generateRandomCode(CODE_LENGTH);
    }

    private String generateRandomCode(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = RANDOM.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }




//    @JsonBackReference
    @ManyToOne
    @JoinColumn
    private Supplier supplier;

//    @JsonManagedReference
//    @OneToMany(fetch = FetchType.EAGER)
//    private List<InventoryItem> inventoryItemList;

    @ManyToOne
    @JoinColumn
    private SubCategories subCategories;



}
