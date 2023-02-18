package com.tickets.info.emdbapi.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tickets.info.emdbapi.models.Item;
import com.tickets.info.emdbapi.repositories.ItemRepository;

@Service
public class ItemService {    
    
    @Autowired
    private ItemRepository itemRepository;

    public List<Item> getAllItems(){
    
       List<Item> items = new ArrayList<>();
       itemRepository.findAll()
       .forEach(items::add);
       return items;
    }

    public Optional<Item> getItem (String id){
        return itemRepository.findById(id);
    }

    public void addItem(Item item) {
        itemRepository.save(item);
    }

    public void updateItem(String id, Item item){
        itemRepository.save(item);
    }

    public void deleteItem(String id) {
        itemRepository.deleteById(id);
    }
}

