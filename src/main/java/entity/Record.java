package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import java.time.Instant;
import java.time.LocalDate;

@Entity
public class Record {
    @Id
    @GeneratedValue
    private int id;

    @ManyToOne
    private Borrower borrowedBy;

    @ManyToOne
    private BookCopy target;

    private Instant since;

    private Instant until;

    private LocalDate deadline;
}
