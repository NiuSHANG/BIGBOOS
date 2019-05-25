package dao;

import entity.BookProfile;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface BookProfileRepository extends CrudRepository<BookProfile, Integer> {
    Optional<BookProfile> findBookProfileByIsbn(Integer isbn);

    List<BookProfile> findBookProfilesByName(String name);
    List<BookProfile> findBookProfilesByAuthor(String author);

    // TODO
//    @Query("select p from BookProfile p, Borrower b where b = ? and p.copies in b.borrowed")
//    List<BookProfile> findBookProfilesByBorrower(Borrower borrower);

    Page<BookProfile> findAll(Pageable pageable);
    List<BookProfile> findAll(Specification specification);
    Page<BookProfile> findAll(Specification specification, Pageable pageable);
}
