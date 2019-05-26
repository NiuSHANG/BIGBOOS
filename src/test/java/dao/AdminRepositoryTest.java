package dao;

import config.SpringConfig;
import entity.Admin;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.transaction.Transactional;

@Transactional
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = SpringConfig.class)
@ActiveProfiles("test")
public class AdminRepositoryTest {
    @Autowired
    private AdminRepository adminRepo;

    @Test
    public void test() {
        Admin test = Admin.builder().name("test").password("123456").build();
        adminRepo.save(test);
        adminRepo.delete(test);
    }
}