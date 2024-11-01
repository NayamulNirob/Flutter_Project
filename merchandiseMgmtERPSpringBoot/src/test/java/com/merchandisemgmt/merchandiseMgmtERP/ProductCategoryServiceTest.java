package com.merchandisemgmt.merchandiseMgmtERP;

import com.merchandisemgmt.merchandiseMgmtERP.entity.ProductCategory;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ProductCategoryRepository;
import com.merchandisemgmt.merchandiseMgmtERP.service.ProductCategoryService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.util.AssertionErrors;
import org.springframework.web.multipart.MultipartFile;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.io.IOException;

public class ProductCategoryServiceTest {




        @Mock
        private ProductCategoryRepository productCategoryRepository;

        @InjectMocks
        private ProductCategoryService productCategoryService; // Assuming your method is in ProductCategoryService

        @BeforeEach
        public void setup() {
            MockitoAnnotations.openMocks(this); // Initialize mocks
        }

        @Test
        public void testSaveCategoryWithImage() throws IOException {
            // Arrange
            ProductCategory category = new ProductCategory();
            category.setName("Electronics");

            // Mock image file
            MockMultipartFile imageFile = new MockMultipartFile(
                    "image",
                    "image.jpg",
                    "image/jpeg",
                    "test image content".getBytes()
            );

            // Mock saveImage method (or assume it just returns a file name)
            when(productCategoryRepository.save(any(ProductCategory.class))).thenReturn(category);

            // Act
            ProductCategory savedCategory = productCategoryService.saveCategory(category, imageFile);

            // Assert
            assertNotNull(savedCategory);
            assertEquals("image.jpg", savedCategory.getImage());
            verify(productCategoryRepository, times(1)).save(any(ProductCategory.class));
        }

        @Test
        public void testSaveCategoryWithoutImage() throws IOException {
            // Arrange
            ProductCategory category = new ProductCategory();
            category.setName("Clothing");

            // No image file provided
            MultipartFile imageFile = null;

            // Mock repository save
            Mockito.when(productCategoryRepository.save(any(ProductCategory.class))).thenReturn(category);

            // Act
            ProductCategory savedCategory = productCategoryService.saveCategory(category, imageFile);

            // Assert
            assertNotNull(savedCategory);
            assertNull(savedCategory.getImage());
            verify(productCategoryRepository, times(1)).save(any(ProductCategory.class));
        }
    }




