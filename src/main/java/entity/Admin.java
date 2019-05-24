package entity;

import lombok.Builder;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Data
@Builder
public class Admin {
    @Id
    @GeneratedValue
    private int id;

    @Column(unique = true)
    private String name;

    private String password;
}
