package com.tickets.info.emdbapi.models;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Item {
    
    @Id
    private String id;
    private String img;
    private String title;
    private String price;
    private String description;

    public Item(){

    }

    public Item(String id, String img, String title, String price, String description) {
        this.id = id;
        this.img = img;
        this.title = title;
        this.price = price;
        this.description = description;
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getImg() {
        return img;
    }
    public void setImg(String img) {
        this.img = img;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    
}
