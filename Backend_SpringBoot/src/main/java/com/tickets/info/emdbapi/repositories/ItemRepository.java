package com.tickets.info.emdbapi.repositories;

import org.springframework.data.repository.CrudRepository;

import com.tickets.info.emdbapi.models.Item;

public interface ItemRepository extends CrudRepository <Item , String>{
    
}