package entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Borrower {
    @Id
//    @GeneratedValue
    private Integer id;

    @Column(unique = true, nullable = false)
    private String name;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private BorrowerType type;

    @Builder.Default
    @Column(nullable = false)
    private Boolean deleted = false;

    @OneToMany(mappedBy = "borrower")
    private List<BookCopy> borrowed;

    @OneToMany(mappedBy = "borrower")
    private List<Record> records;

    @Override
    public String toString() {
        return ""; // TODO temp fix
    }
}
