package entity;

import javax.persistence.*;
import java.util.List;

@Entity
public class Borrower {
    @Id
    @GeneratedValue
    private long id;

    private String name;

    private String password;

    private BorrowerType type;

    private boolean deleted = false;

    @OneToMany
    private List<BookCopy> borrowed;
}
