package com.tickets.info.emdbapi.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tickets.info.emdbapi.models.User;
import com.tickets.info.emdbapi.repositories.UserRepository;
import com.tickets.info.emdbapi.services.UserService;

@RestController
public class UserController {

    private List<User> users = new ArrayList<>(Arrays.asList(
        new User("1", "ab@gmail", "1234")
    ));
    @Autowired
    private UserRepository userRepository;
    private UserService userService;

    @RequestMapping("/register")
    public List<User> getAllUsers(){
        return users;
        //return userService.getAllUsers();
        
    }

    @GetMapping("/register/{id}")
    public Optional<com.tickets.info.emdbapi.models.User> getUser(@PathVariable String id){
        return userService.getUser(id);
    }

    @PostMapping("/register")
    public User addUser (@RequestBody User user){

       return userRepository.save(user);
    }
    @PostMapping("/login")
    public User Login (@RequestBody User user){
        User oldUser = userRepository.findByEmailAndPassword(user.getEmail(),user.getPassword());
        return oldUser;
    }
    
}
