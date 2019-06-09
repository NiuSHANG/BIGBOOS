package entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class BookProfile {
    @Id
    private Long isbn;

    @Column(nullable = false)
    private String name;

    @Column
    private String summary;

    @Column(nullable = false)
    private String author;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private LocalDate issueOn;

    @Column(nullable = false)
    private Double price;

    @OneToMany(mappedBy = "profile")
    private List<BookCopy> copies;

    @OneToMany(mappedBy = "target")
    private List<Record> records;

    @Override
    public String toString() {
        return ""; // TODO temp fix
    }
}
