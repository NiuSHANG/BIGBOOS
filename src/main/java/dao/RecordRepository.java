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

import java.util.List;
import java.util.Optional;

@Repository
public interface RecordRepository extends CrudRepository<Record, Integer> {
    Optional<Record> findRecordById(Integer id);
    Optional<Record> findRecordByBorrowerAndTargetAndUntilIsNull(Borrower borrower, BookCopy target);

    List<Record> findRecordsByBorrower(Borrower borrower);
    List<Record> findRecordsByBorrowerId(Integer borrower_id);
    List<Record> findRecordsByBorrowerName(String borrower_name);

    Page<Record> findRecordsByBorrowerId(Integer borrower_id, Pageable pageable);

    List<Record> findRecordsByTarget(BookCopy target);
    List<Record> findRecordsByTargetId(Integer borrower_id);

    List<Record> findRecordsByTargetProfile(BookProfile target_profile);
    List<Record> findRecordsByTargetProfileIsbn(Long target_profile_isbn);
    List<Record> findRecordsByTargetProfileName(String target_profile_name);
    List<Record> findRecordsByTargetProfileAuthor(String target_profile_author);

    List<Record> findRecordsByUntilIsNull();

    Page<Record> findAll(Pageable pageable);
    List<Record> findAll(Specification specification);
    Page<Record> findAll(Specification specification, Pageable pageable);
}
