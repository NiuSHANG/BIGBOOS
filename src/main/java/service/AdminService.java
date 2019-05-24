package service;

import entity.*;

import java.util.List;
import java.util.Map;

public interface AdminService {
    Borrower findUser(int id);
    BookProfile findBookProfile(int isbn);
    BookCopy findBookCopy(int id);

    List<BookProfile> findBookByCriteria(Map<String, Object> criteria);
    List<Record> findRecordByCriteria(Map<String, Object> criteria);

    Admin addAdmin(Admin admin);
    Borrower addUser(Borrower user);
    BookProfile addBookProfile(BookProfile profile);
    BookCopy addBookCopy(BookCopy copy);

    boolean removeAdmin(Admin admin);
    boolean removeUser(Borrower user);
    boolean removeBookProfile(BookProfile profile);
    boolean removeBookCopy(BookCopy copy);

    Admin updateAdmin(Admin admin);
    Borrower updateUser(Borrower user);
    BookProfile updateBookProfile(BookProfile profile);
    BookCopy updateBookCopy(BookCopy copy);

    Admin login(String username, String password);
}