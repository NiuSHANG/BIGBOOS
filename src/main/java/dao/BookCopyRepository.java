package dao;

import entity.BookCopy;
import entity.BookProfile;
import entity.Borrower;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookCopyRepository extends CrudRepository<BookCopy, Integer> {
    Optional<BookCopy> findBookCopyById(Integer id);

    Iterable<BookCopy> findBookCopiesByProfile(BookProfile profile);
    Iterable<BookCopy> findBookCopiesByProfileIsbn(Integer profile_isbn);
    Iterable<BookCopy> findBookCopiesByProfileName(String profile_name);
    Iterable<BookCopy> findBookCopiesByProfileAuthor(String profile_author);

    Iterable<BookCopy> findBookCopiesByBorrower(Borrower borrower);
    Iterable<BookCopy> findBookCopiesByBorrowerId(Integer borrower_id);
    Iterable<BookCopy> findBookCopiesByBorrowerName(String borrower_name);

    Iterable<BookCopy> findBookCopiesByBorrowerIsNull();
    Iterable<BookCopy> findBookCopiesByBorrowerIsNotNull();

    Page<BookCopy> findAll(Pageable pageable);
    Iterable<BookCopy> findAll(Specification specification);
    Page<BookCopy> findAll(Specification specification, Pageable pageable);
}
