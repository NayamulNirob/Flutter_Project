package com.merchandisemgmt.merchandiseMgmtERP.service;

import com.merchandisemgmt.merchandiseMgmtERP.entity.ToDoTask;
import com.merchandisemgmt.merchandiseMgmtERP.repository.ToDoTaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ToDoTaskService {

    @Autowired
    private ToDoTaskRepository toDoTaskRepository;

    public List<ToDoTask> getAllTasks() {
        return toDoTaskRepository.findAll();
    }

    public Optional<ToDoTask> getTaskById(Long id) {
        return toDoTaskRepository.findById(id);
    }

    public ToDoTask createTask(ToDoTask task) {
        return toDoTaskRepository.save(task);
    }

    public ToDoTask updateTask(Long id, ToDoTask taskDetails) {
        ToDoTask task = toDoTaskRepository.findById(id).orElseThrow();
        task.setDescription(taskDetails.getDescription());
        task.setStatus(taskDetails.getStatus());
        return toDoTaskRepository.save(task);
    }
//
//    public ToDoTask updateTask(Long id, ToDoTask taskDetails) {
//        ToDoTask task = toDoTaskRepository.findById(id).orElseThrow();
//        task.setStatus(taskDetails.getStatus());
//        return toDoTaskRepository.save(task);
//    }


    public void deleteTask(Long id) {
        toDoTaskRepository.deleteById(id);
    }

}
