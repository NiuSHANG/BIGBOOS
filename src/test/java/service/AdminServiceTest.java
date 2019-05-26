package service;

import config.SpringConfig;
import entity.Admin;
import entity.BookProfile;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = SpringConfig.class)
public class AdminServiceTest {
    @Autowired
    private AdminService adminService;

    private Admin admin;
    private BookProfile profile;

    @Before
    public void setUp() {
        admin = adminService.addAdmin(Admin.builder().name("__test").password("123456").build());
        profile = adminService.addBookProfile(new BookProfile(123456, "__test_profile", "gresstant", "type", LocalDate.of(2000, 1, 1), 1.0, null));
    }

    @After
    public void tearDown() {
        adminService.removeAdmin(admin);
        adminService.removeBookProfile(profile);
    }

    @Test
    public void findUser() {
    }

    @Test
    public void findBookProfile() {
        BookProfile bookProfile = adminService.findBookProfile(123456);
        Assert.assertEquals(profile.getIsbn(), bookProfile.getIsbn());
        Assert.assertEquals(profile.getName(), bookProfile.getName());
        Assert.assertEquals(profile.getAuthor(), bookProfile.getAuthor());
        Assert.assertEquals(profile.getType(), bookProfile.getType());
        Assert.assertEquals(profile.getIssueOn(), bookProfile.getIssueOn());
        Assert.assertEquals(profile.getPrice(), bookProfile.getPrice(), Double.MIN_VALUE);
        Assert.assertNull(bookProfile.getCopies());
    }

    @Test
    public void findBookCopy() {
    }

    @Test
    public void findBookByCriteria() {
        HashMap<String, Object> criteria = new HashMap<>();
        criteria.put("isbn", profile.getIsbn());
        criteria.put("name", profile.getName());
        criteria.put("author", profile.getAuthor());
        List<BookProfile> bookByCriteria = adminService.findBookByCriteria(criteria);
        Assert.assertTrue(bookByCriteria.size() >= 1);
        Assert.assertEquals(profile.getIsbn(), bookByCriteria.get(0).getIsbn());
    }

    @Test
    public void findRecordByCriteria() {
    }

    @Test
    public void addAdmin() {
    }

    @Test
    public void addUser() {
    }

    @Test
    public void addBookProfile() {
    }

    @Test
    public void addBookCopy() {
    }

    @Test
    public void removeAdmin() {
    }

    @Test
    public void removeUser() {
    }

    @Test
    public void removeBookProfile() {
    }

    @Test
    public void removeBookCopy() {
    }

    @Test
    public void updateAdmin() {
    }

    @Test
    public void updateUser() {
    }

    @Test
    public void updateBookProfile() {
    }

    @Test
    public void updateBookCopy() {
    }

    @Test
    public void login() {
        Admin login = adminService.login("__test", "123456");
        Assert.assertNotNull(login);
        Assert.assertEquals(admin.getName(), login.getName());
        Assert.assertEquals(admin.getPassword(), login.getPassword());
    }
}