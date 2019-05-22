package entity;

import javax.persistence.Entity;
import java.time.Instant;
import java.time.LocalDate;

@Entity
public class Record {
    private Borrower borrowedBy;
    private BookCopy target;
    private Instant since;
    private Instant until;
    private LocalDate deadline;
}
