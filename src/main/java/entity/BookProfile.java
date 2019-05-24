package entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
public class BookProfile {
    @Id
    private int isbn;

    private String name;

    private String author;

    private String type;

    private LocalDate issueOn;

    private double price;

    @OneToMany
    private List<BookCopy> copies;
}
