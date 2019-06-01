package service;

import config.SpringConfig;
import entity.*;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.*;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = SpringConfig.class)
@ActiveProfiles("test")
public class AdminServiceTest {
    @Autowired
    private AdminService adminService;

    private static Admin admin = Admin.builder().name("__test").password("123456").build();
    private static BookProfile profile = new BookProfile(123456L, "__test_profile", null, "gresstant", "type", LocalDate.of(2000, 1, 1), 1.0, null);

    private static List<Admin> admins = new LinkedList<>();
    private static List<Borrower> users = new LinkedList<>();
    private static List<BookProfile> profiles = new LinkedList<>();
    private static Map<Long, List<BookCopy>> bookCopies = new TreeMap<>(); // key is bookProfile.id

    static {
        Random random = new Random();

        // region admins
        int adminSize = random.nextInt(20);
        for (int i = 0; i < adminSize; i++)
            admins.add(Admin.builder().name("admins_" + random.nextInt()).password(Integer.toString(i)).build());
        // endregion

        // region users
        int userSize = random.nextInt(20);
        for (int i = 0; i < userSize; i++)
            users.add(Borrower.builder().name("users_" + random.nextInt()).password(Integer.toString(i))
                    .type(random.nextBoolean() ? BorrowerType.FACULTY : BorrowerType.STUDENT).build());
        // endregion

        // region profiles & bookCopies
        int profileSize = random.nextInt(20);
        Set<Long> isbnSet = new TreeSet<>();
        for (int i = 0; i < profileSize; i++) {
            long isbn = random.nextLong();
            while (isbnSet.contains(isbn)) // to avoid duplicate isbn
                isbn = random.nextInt();
            isbnSet.add(isbn);

            BookProfile p = BookProfile.builder().isbn(isbn)
                    .name("profiles_" + random.nextInt())
                    .author("author_type" + i % 2)
                    .type("type_" + i % 2)
                    .issueOn(LocalDate.ofEpochDay(random.nextInt()))
                    .price(random.nextDouble() * 100).build();
            profiles.add(p);

            List<BookCopy> bookCopyList = new LinkedList<>();
            int copySize = random.nextInt(10);
            for (int j = 0; j < copySize; j++)
                bookCopyList.add(BookCopy.builder().profile(p).build());
            bookCopies.put(isbn, bookCopyList);
        }
        // endregion
    }

    @Before
    public void setUp() {
        admin = adminService.addAdmin(Admin.builder().name("__test").password("123456").build());
        profile = adminService.addBookProfile(profile);

        ServiceTestingUtils.addAllAndUpdate(admins, adminService::addAdmin);
        ServiceTestingUtils.addAllAndUpdate(users, adminService::addUser);
        ServiceTestingUtils.addAllAndUpdate(profiles, adminService::addBookProfile, p -> bookCopies.get(p.getIsbn()).forEach(copy -> copy.setProfile(p)));
        bookCopies.forEach((isbn, copyList) -> ServiceTestingUtils.addAllAndUpdate(copyList, adminService::addBookCopy));
    }

    @After
    public void tearDown() {
        adminService.removeAdmin(admin);
        adminService.removeBookProfile(profile);

        admins.forEach(adminService::removeAdmin);
        users.forEach(adminService::removeUser);
        profiles.forEach(adminService::removeBookProfile);
        bookCopies.forEach((isbn, copyList) -> copyList.forEach(adminService::removeBookCopy));
    }

    @Test
    public void findUser() {
        users.forEach(u -> Assert.assertEquals(u, adminService.findUser(u.getId())));
    }

    @Test
    public void findBookProfile() {
        Assert.assertEquals(profile, adminService.findBookProfile(profile.getIsbn()));
        profiles.forEach(p -> Assert.assertEquals(p, adminService.findBookProfile(p.getIsbn())));
    }

    @Test
    public void findBookCopy() {
        bookCopies.forEach((i, l) -> l.forEach(c -> Assert.assertEquals(c, adminService.findBookCopy(c.getId()))));
    }

    @Test
    public void findBookByCriteria() {
        HashMap<String, Object> criteria = new HashMap<>();
        criteria.put("isbn", profile.getIsbn());
        criteria.put("name", profile.getName());
        criteria.put("author", profile.getAuthor());
        List<BookProfile> bookByCriteria = adminService.findBookByCriteria(criteria);
        Assert.assertTrue(bookByCriteria.size() >= 1);
        Assert.assertEquals(profile, bookByCriteria.get(0));

        criteria.clear();
        criteria.put("name", "profiles\\_%");
        Assert.assertEquals(profiles.size(), adminService.findBookByCriteria(criteria).size());
    }

    @Test
    public void findRecordByCriteria() {
        // TODO
    }

    @Test
    public void updateAdmin() {
        // TODO
    }

    @Test
    public void updateUser() {
        // TODO
    }

    @Test
    public void updateBookProfile() {
        // TODO
    }

    @Test
    public void updateBookCopy() {
        // TODO
    }

    @Test
    public void login() {
        Admin login = adminService.login("__test", "123456");
        Assert.assertNotNull(login);
        Assert.assertEquals(admin.getName(), login.getName());
        Assert.assertEquals(admin.getPassword(), login.getPassword());
    }
}