package dao;

import entity.BookProfile;
import entity.Borrower;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface BookProfileRepository extends CrudRepository<BookProfile, Long> {
    Optional<BookProfile> findBookProfileByIsbn(Long isbn);

    List<BookProfile> findBookProfilesByName(String name);
    List<BookProfile> findBookProfilesByAuthor(String author);

    @Query("select p from BookProfile p where p.copies in (select b.borrowed from Borrower b where b = ?1)")
    List<BookProfile> findBookProfilesByBorrower(Borrower borrower);

    Page<BookProfile> findAll(Pageable pageable);
    List<BookProfile> findAll(Specification specification);
    Page<BookProfile> findAll(Specification specification, Pageable pageable);
}
