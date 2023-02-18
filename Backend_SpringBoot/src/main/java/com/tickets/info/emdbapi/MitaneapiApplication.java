package com.tickets.info.emdbapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
@CrossOrigin
public class MitaneapiApplication {

	public static void main(String[] args) {
		SpringApplication.run(MitaneapiApplication.class, args);
	}
}