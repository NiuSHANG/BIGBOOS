package dao;

import entity.BookCopy;
import entity.BookProfile;
import entity.Borrower;
import entity.Record;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecordRepository extends CrudRepository<Record, Integer> {
    Optional<Record> findRecordById(Integer id);

    Iterable<Record> findRecordsByBorrower(Borrower borrower);
    Iterable<Record> findRecordsByBorrowerId(Integer borrower_id);
    Iterable<Record> findRecordsByBorrowerName(String borrower_name);

    Iterable<Record> findRecordsByTarget(BookCopy target);
    Iterable<Record> findRecordsByTargetId(Integer borrower_id);

    Iterable<Record> findRecordsByTargetProfile(BookProfile target_profile);
    Iterable<Record> findRecordsByTargetProfileIsbn(Integer target_profile_isbn);
    Iterable<Record> findRecordsByTargetProfileName(String target_profile_name);
    Iterable<Record> findRecordsByTargetProfileAuthor(String target_profile_author);

    Iterable<Record> findRecordsByUntilIsNull();

    Page<Record> findAll(Pageable pageable);
    Iterable<Record> findAll(Specification specification);
    Page<Record> findAll(Specification specification, Pageable pageable);
}
