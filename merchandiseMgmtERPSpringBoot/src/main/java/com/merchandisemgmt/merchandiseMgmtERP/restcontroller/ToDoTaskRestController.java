package com.merchandisemgmt.merchandiseMgmtERP.restcontroller;

import com.merchandisemgmt.merchandiseMgmtERP.entity.ToDoTask;
import com.merchandisemgmt.merchandiseMgmtERP.service.ToDoTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("api/task")
@CrossOrigin("*")
public class ToDoTaskRestController {

    @Autowired
    private ToDoTaskService toDoTaskService;

    @GetMapping("/")
    public ResponseEntity<List<ToDoTask>> getAllTasks() {
        List<ToDoTask> toDoTasks = toDoTaskService.getAllTasks();
        return new ResponseEntity<>(toDoTasks, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ToDoTask> getTaskById(@PathVariable Long id) {
        return toDoTaskService.getTaskById(id).map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }


    @PostMapping("/save")
    public ResponseEntity<ToDoTask> createTask(@RequestBody ToDoTask task) {
        ToDoTask toDoTask = toDoTaskService.createTask(task);
        return new ResponseEntity<>(toDoTask, HttpStatus.CREATED);
    }


    //    @PutMapping("/update/{id}")
//    public ResponseEntity<ToDoTask> updateTask(@PathVariable Long id, @RequestBody ToDoTask taskDetails) {
//        ToDoTask updatedTask = toDoTaskService.updateTask(id, taskDetails);
//        return new ResponseEntity<>(updatedTask,HttpStatus.OK);
//    }
    @PutMapping("/update/{id}")
    public ResponseEntity<ToDoTask> updateTask(@PathVariable Long id, @RequestBody ToDoTask taskDetails) {
        ToDoTask task = toDoTaskService.getTaskById(id).orElseThrow();
        task.setDescription(taskDetails.getDescription());
        task.setStatus(taskDetails.getStatus());
        ToDoTask updatedTask = toDoTaskService.updateTask(id, task);
        return new ResponseEntity<>(updatedTask, HttpStatus.OK);
    }


    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteTask(@PathVariable Long id) {
        toDoTaskService.deleteTask(id);
        return new ResponseEntity<>("Task deleted", HttpStatus.OK);
    }

}
