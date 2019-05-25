package dao;

import entity.BookCopy;
import entity.BookProfile;
import entity.Borrower;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookCopyRepository extends CrudRepository<BookCopy, Integer> {
    Optional<BookCopy> findBookCopyById(Integer id);

    List<BookCopy> findBookCopiesByProfile(BookProfile profile);
    List<BookCopy> findBookCopiesByProfileIsbn(Integer profile_isbn);
    List<BookCopy> findBookCopiesByProfileName(String profile_name);
    List<BookCopy> findBookCopiesByProfileAuthor(String profile_author);

    List<BookCopy> findBookCopiesByBorrower(Borrower borrower);
    List<BookCopy> findBookCopiesByBorrowerId(Integer borrower_id);
    List<BookCopy> findBookCopiesByBorrowerName(String borrower_name);

    List<BookCopy> findBookCopiesByBorrowerIsNull();
    List<BookCopy> findBookCopiesByBorrowerIsNotNull();

    Page<BookCopy> findAll(Pageable pageable);
    List<BookCopy> findAll(Specification specification);
    Page<BookCopy> findAll(Specification specification, Pageable pageable);
}
