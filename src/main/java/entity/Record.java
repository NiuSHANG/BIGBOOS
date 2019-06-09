package entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.Instant;
import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Record {
    @Id
    @GeneratedValue
    private Integer id;

    @ManyToOne
    @JoinColumn
    private Borrower borrower;

    @ManyToOne
    @JoinColumn
    private BookCopy target;

    @Column(nullable = false)
    private Instant since;

    private Instant until;

    @Column(nullable = false)
    private LocalDate deadline;

    @Override
    public String toString() {
        return ""; // TODO temp fix
    }
}
