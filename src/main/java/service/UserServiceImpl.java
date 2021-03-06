package service;

import dao.*;
import entity.BookCopy;
import entity.BookProfile;
import entity.Borrower;
import entity.Record;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    AdminRepository adminRepo;

    @Autowired
    BookCopyRepository bookCopyRepo;

    @Autowired
    BookProfileRepository bookProfileRepo;

    @Autowired
    BorrowerRepository borrowerRepo;

    @Autowired
    RecordRepository recordRepo;

    @Override
    public Borrower login(String username, String password) {
        Optional<Borrower> user = borrowerRepo.findBorrowerByNameAndDeletedIsFalse(username);
        return user.isPresent() && user.get().getPassword().equals(password) ? user.get() : null;
    }

    @Override
    public boolean update(Borrower user) {
        try {
            borrowerRepo.save(user);
            return true;
        } catch (DataIntegrityViolationException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public List<BookProfile> findBookByCriteria(Map<String, Object> criteria) {
        return bookProfileRepo.findAll(ServiceUtils.convertMapToSpec(criteria));
    }

    @Override
    public List<Record> findRecordOfSomeone(int uid) {
        return recordRepo.findRecordsByBorrowerId(uid);
    }

    @Override
    public Page<BookProfile> findBookByCriteria(Map<String, Object> criteria, Pageable pageable) {
        return bookProfileRepo.findAll(ServiceUtils.convertMapToSpec(criteria), pageable);
    }

    @Override
    public Page<Record> findRecordOfSomeone(int uid, Pageable pageable) {
        return recordRepo.findRecordsByBorrowerId(uid, pageable);
    }

    @Override
    public Record borrow(Borrower user, BookCopy copy) {
        Objects.requireNonNull(user);
        Objects.requireNonNull(copy);

        if (user.getDeleted() || copy.getBorrower() != null) return null;

        copy.setBorrower(user);
        bookCopyRepo.save(copy);
        return recordRepo.save(Record.builder().borrower(user).target(copy).profile(copy.getProfile())
                .since(Instant.now()).deadline(LocalDate.now().plus(Period.ofDays(60))).build());
    }

    @Override
    public Borrower register(Borrower user) {
        if (borrowerRepo.findBorrowerById(user.getId()).isPresent())
            user.setDeleted(false);
        return borrowerRepo.save(user);
    }

    @Override
    public Record returnBack(Borrower user, BookCopy copy) {
        if (copy.getBorrower() == null || !copy.getBorrower().getId().equals(user.getId()))
            return null;

        Optional<Record> record = recordRepo.findRecordByBorrowerAndTargetAndUntilIsNull(user, copy)
                                            .filter(rec -> rec.getBorrower().getId().equals(user.getId()))
                                            .filter(rec -> rec.getTarget().getId().equals(copy.getId()));
        if (!record.isPresent()) return null;

        copy.setBorrower(null);
        bookCopyRepo.save(copy);
        record.ifPresent(rec -> {
            rec.setUntil(Instant.now());
            rec.setTarget(null);
        });
        return recordRepo.save(record.get());
    }
}
