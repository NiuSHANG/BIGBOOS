package entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class BookCopy {
    @Id
    @GeneratedValue
    private Integer id;

    @ManyToOne
    @JoinColumn
    private BookProfile profile;

    @ManyToOne
    @JoinColumn
    private Borrower borrower;
}
