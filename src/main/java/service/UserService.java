package service;

import entity.BookCopy;
import entity.BookProfile;
import entity.Borrower;
import entity.Record;

import java.util.List;
import java.util.Map;

public interface UserService {
    Borrower login(String username, String password);
    Borrower register(Borrower user);
    boolean update(Borrower user);
    List<BookProfile> findBookByCriteria(Map<String, Object> criteria);
    List<Record> findRecordOfSomeone(int uid);

    Record borrow(Borrower user, BookCopy copy);
    Record returnBack(Borrower user, BookCopy copy);
}
