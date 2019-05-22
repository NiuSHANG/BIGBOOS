package entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class BookCopy {
    @Id
    private int id;

    @ManyToOne
    private BookProfile profile;

    @ManyToOne
    private Borrower borrower;
}
