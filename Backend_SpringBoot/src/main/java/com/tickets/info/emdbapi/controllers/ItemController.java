package com.tickets.info.emdbapi.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tickets.info.emdbapi.services.ItemService;
import com.tickets.info.emdbapi.models.Item;

@RestController
public class ItemController {

    @Autowired
    private ItemService itemService;
    
    @GetMapping("/items")
    public List<Item> getAllItems() {
       return itemService.getAllItems();
    }

    @GetMapping("/items/{id}")
    public Optional<Item> getItem(@PathVariable String id){
        return itemService.getItem(id);
    }

    @PostMapping("/items")
    public void addItem(@RequestBody Item i){
        itemService.addItem(i);
    }

    @PutMapping("/items/{id}")
    public void updateItem(@RequestBody Item it, @PathVariable String id){
        itemService.updateItem(id, it);
    }

    @DeleteMapping("/items/{id}")
    public void deleteItem(@PathVariable String id){
        itemService.deleteItem(id);
    }
}