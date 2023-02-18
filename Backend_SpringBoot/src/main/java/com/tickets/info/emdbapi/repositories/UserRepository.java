package com.tickets.info.emdbapi.repositories;


import org.springframework.data.repository.CrudRepository;

import com.tickets.info.emdbapi.models.User;

public interface UserRepository extends CrudRepository <User , String> {
    User findByEmailAndPassword(String email , String password);
}