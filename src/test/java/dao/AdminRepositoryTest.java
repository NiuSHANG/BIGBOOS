package dao;

import config.SpringConfig;
import entity.Admin;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class AdminRepositoryTest {
    private AdminRepository adminRepo;

    @Before
    public void setUp() {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(SpringConfig.class);
        adminRepo = applicationContext.getBean(AdminRepository.class);
    }

    @Test
    public void test() {
        Admin test = Admin.builder().name("test").password("123456").build();
        adminRepo.save(test);
        adminRepo.delete(test);
    }
}