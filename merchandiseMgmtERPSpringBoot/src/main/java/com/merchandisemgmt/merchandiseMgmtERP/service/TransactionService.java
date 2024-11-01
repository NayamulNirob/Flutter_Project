package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.Transaction;
import com.merchandisemgmt.merchandiseMgmtERP.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    public List<Transaction> getAllTransactions() {
        return transactionRepository.findAll();
    }

    public Transaction getTransactionById(Long id) {
        return transactionRepository.findById(id).orElseThrow(
                () -> new RuntimeException("Transaction with id " + id + " not found")
        );
    }



//    public Map<String, Object> saveTransaction(Transaction transaction) {
//
//        transaction.setDate(LocalDateTime.now());
//        Transaction savedTransaction = transactionRepository.save(transaction);
//
//
//        double totalAmount = transactionRepository.findAll()
//                .stream()
//                .mapToDouble(Transaction::getAmount)
//                .sum();
//
//        Double totalAmount = transactionRepository.calculateTotalTransactionAmount();
//
//        Map<String, Object> result = new HashMap<>();
//        result.put("transaction", savedTransaction);
//        result.put("totalAmount", totalAmount);
//
//        return result;
//    }

    public Transaction saveTransaction(Transaction transaction) {
        transaction.setDate(LocalDateTime.now());
        return transactionRepository.save(transaction);
    }

    public void deleteTransaction(Long id) {
        transactionRepository.deleteById(id);
    }
    public Transaction updateTransaction(Transaction transaction,long id) {
        return transactionRepository.save(transaction);
    }
}
