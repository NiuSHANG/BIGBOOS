package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class BookCopy {
    @Id
    @GeneratedValue
    private int id;

    @ManyToOne
    private BookProfile profile;

    @ManyToOne
    private Borrower borrower;
}
