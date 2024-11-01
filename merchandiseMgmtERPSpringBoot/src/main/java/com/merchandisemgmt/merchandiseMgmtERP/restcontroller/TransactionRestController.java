package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;


import com.merchandisemgmt.merchandiseMgmtERP.entity.Transaction;
import com.merchandisemgmt.merchandiseMgmtERP.repository.TransactionRepository;
import com.merchandisemgmt.merchandiseMgmtERP.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/transaction")
@CrossOrigin("*")
public class TransactionRestController {
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private TransactionRepository transactionRepository;

    @GetMapping("/")
    public ResponseEntity<List<Transaction>> getAllTransactions() {
     List<Transaction> transactions = transactionService.getAllTransactions();
     return new ResponseEntity<>(transactions, HttpStatus.OK);
    }
 
    @PostMapping("/save")
    public ResponseEntity<Transaction> saveTransaction(@RequestBody Transaction transaction) {
        transactionService.saveTransaction(transaction);
        return new ResponseEntity<>(transaction, HttpStatus.CREATED);
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<Transaction> updateTransaction(@PathVariable long id, @RequestBody Transaction transaction) {
        Transaction transactions=transactionService.updateTransaction(transaction,id);
        return new ResponseEntity<>(transactions, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Transaction> getTransactionById(@PathVariable long id) {
        Transaction transaction= transactionService.getTransactionById(id);
        return new ResponseEntity<>(transaction, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteTransactionById(@PathVariable Long id) {

     transactionService.deleteTransaction(id);
     return new ResponseEntity<>("Transaction deleted", HttpStatus.OK);
    }

    @GetMapping("/total")
    public Double getTotalTransactionAmount() {
        return transactionRepository.calculateTotalTransactionAmount();
    }

}
