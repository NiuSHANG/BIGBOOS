package service;

import config.SpringConfig;
import entity.Admin;
import entity.BookProfile;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

public class AdminServiceTest {
    private AdminService adminService;

    private LocalDate date = LocalDate.of(2000, 1, 1);
    private Admin admin;
    private BookProfile profile;

    @Before
    public void setUp() {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(SpringConfig.class);
        adminService = applicationContext.getBean(AdminService.class);

        admin = adminService.addAdmin(Admin.builder().name("__test").password("123456").build());
        profile = adminService.addBookProfile(new BookProfile(123456, "__test_profile", "gresstant", "type", date, 1.0, null));
    }

    @Test
    public void test() {

        Admin login = adminService.login("__test", "123456");
        Assert.assertNotNull(login);
        Assert.assertEquals("__test", login.getName());
        Assert.assertEquals("123456", login.getPassword());

        BookProfile bookProfile = adminService.findBookProfile(123456);
        Assert.assertEquals(123456, bookProfile.getIsbn().intValue());
        Assert.assertEquals("__test_profile", bookProfile.getName());
        Assert.assertEquals("gresstant", bookProfile.getAuthor());
        Assert.assertEquals("type", bookProfile.getType());
        Assert.assertEquals(date, bookProfile.getIssueOn());
        Assert.assertEquals(1.0, bookProfile.getPrice(), Double.MIN_VALUE);
        Assert.assertNull(bookProfile.getCopies());

        HashMap<String, Object> criteria = new HashMap<>();
        criteria.put("isbn", 123456);
        criteria.put("name", "__test_profile");
        criteria.put("author", "gresstant");
        List<BookProfile> bookByCriteria = adminService.findBookByCriteria(criteria);
        Assert.assertEquals(1, bookByCriteria.size());
        Assert.assertEquals(123456, bookByCriteria.get(0).getIsbn().intValue());
    }

    @After
    public void tearDown() throws Exception {
        adminService.removeAdmin(admin);
        adminService.removeBookProfile(profile);
    }
}