package com.tickets.info.emdbapi.services;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tickets.info.emdbapi.models.User;
import com.tickets.info.emdbapi.repositories.UserRepository;


@Service
public class UserService {
    private List<User> users = new ArrayList<>(Arrays.asList(
        new User("1", "ab@gmail", "1234")
    ));
    
    @Autowired
    private UserRepository userRepository;

    public UserRepository findByEmailAndPassword (String email , String password){
        return (UserRepository) userRepository.findByEmailAndPassword(email, password);
    }

    public List<User> getAllUsers(){
        return users;
    }

    public Optional<User> getUser (String id){
        return userRepository.findById(id);
    }

    public User addUser(User user) {
        return userRepository.save(user);
    }

}
