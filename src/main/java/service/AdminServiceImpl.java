package service;

import dao.*;
import entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.awt.image.BufferedImage;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
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
    public Borrower findUser(int id) {
        return borrowerRepo.findBorrowerById(id).orElse(null);
    }
    @Override
    public Admin findAdmin(int id) {
        return adminRepo.findAdminById(id).orElse(null);
    }

    @Override
    public BookProfile findBookProfile(long isbn) {
        return bookProfileRepo.findBookProfileByIsbn(isbn).orElse(null);
    }

    @Override
    public BookCopy findBookCopy(int id) {
        return bookCopyRepo.findBookCopyById(id).orElse(null);
    }

    @Override
    public List<BookProfile> findBookByCriteria(Map<String, Object> criteria) {
        return bookProfileRepo.findAll(ServiceUtils.convertMapToSpec(criteria));
    }

    @Override
    public List<Record> findRecordByCriteria(Map<String, Object> criteria) {
        return recordRepo.findAll(ServiceUtils.convertMapToSpec(criteria));
    }

    @Override
    public List<Borrower> findUserByCriteria(Map<String, Object> criteria) {
        return borrowerRepo.findAll(ServiceUtils.convertMapToSpec(criteria));
    }

    @Override
    public Admin addAdmin(Admin admin) {
        admin.setId(null);
        return adminRepo.save(admin);
    }

    @Override
    public Borrower addUser(Borrower user) {
        user.setId(null);
        return borrowerRepo.save(user);
    }

    @Override
    public BookProfile addBookProfile(BookProfile profile) {
        // profile.isbn isn't generated value! don't clear it!
        return bookProfileRepo.save(profile);
    }

    @Override
    public BookCopy addBookCopy(BookCopy copy) {
        copy.setId(null);
        return bookCopyRepo.save(copy);
    }

    @Override
    public boolean removeAdmin(Admin admin) {
        adminRepo.delete(admin);
        return true;
    }

    @Override
    public boolean removeUser(Borrower user) {
        borrowerRepo.delete(user);
        return true;
    }

    @Override
    public boolean removeBookProfile(BookProfile profile) {
        bookProfileRepo.delete(profile);
        return true;
    }

    @Override
    public boolean removeBookCopy(BookCopy copy) {
        bookCopyRepo.delete(copy);
        return true;
    }

    @Override
    public Admin updateAdmin(Admin admin) {
        return adminRepo.save(admin);
    }

    @Override
    public Borrower updateUser(Borrower user) {
        return borrowerRepo.save(user);
    }

    @Override
    public BookProfile updateBookProfile(BookProfile profile) {
        return bookProfileRepo.save(profile);
    }

    @Override
    public BufferedImage getCoverImage(long isbn) {
        return null; // TODO
    }

    @Override
    public boolean putCoverImage(long isbn, BufferedImage image) {
        return false; // TODO
    }

    @Override
    public boolean removeCoverImage(long isbn) {
        return false; // TODO
    }

    @Override
    public Admin login(String username, String password) {
        Optional<Admin> admin = adminRepo.findAdminByName(username);
        return admin.isPresent() && admin.get().getPassword().equals(password) ? admin.get() : null;
    }
}
