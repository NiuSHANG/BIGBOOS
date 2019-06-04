package service;

import dao.*;
import entity.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import javax.transaction.Transactional;
import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
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

    private static final Path USER_DIR;
    private static final Path COVER_IMG_DIR;

    static {
        String appDataFolder = Optional.ofNullable(System.getenv("APPDATA")).orElse(System.getenv("XDG_DATA_HOME"));
        if (appDataFolder == null)
            throw new RuntimeException("Cannot access app data folder! " +
                                       "Consider executing as admin (Windows) or super user (Linux).");

        USER_DIR = Paths.get(appDataFolder, "YCFJ");
        COVER_IMG_DIR = USER_DIR.resolve("upload").resolve("coverImg");

        for (Path path : new Path[] {USER_DIR, COVER_IMG_DIR}) {
            if (!path.toFile().isDirectory() && !path.toFile().mkdir())
                throw new RuntimeException("Unable to create resource folder!");
        }
    }

    @Override
    public BufferedImage getCoverImage(long isbn) {
        try {
            return ImageIO.read(COVER_IMG_DIR.resolve(isbn + ".png").toFile());
        } catch (Exception ex) {
            log.error("getCoverImage, isbn = " + isbn, ex);
            return null;
        }
    }

    @Override
    public boolean putCoverImage(long isbn, BufferedImage image) {
        try {
            return ImageIO.write(image, "png", COVER_IMG_DIR.resolve(isbn + ".png").toFile());
        } catch (Exception ex) {
            log.error("putCoverImage, isbn = " + isbn, ex);
            return false;
        }
    }

    @Override
    public boolean removeCoverImage(long isbn) {
        try {
            File target = COVER_IMG_DIR.resolve(isbn + ".png").toFile();
            return !target.exists() || target.delete();
        } catch (Exception ex) {
            log.error("removeCoverImage, isbn = " + isbn, ex);
            return false;
        }
    }

    @Override
    public Admin login(String username, String password) {
        Optional<Admin> admin = adminRepo.findAdminByName(username);
        return admin.isPresent() && admin.get().getPassword().equals(password) ? admin.get() : null;
    }
}
