package config;

import org.hibernate.SessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = SpringConfig.class)
// This class tests the connectivity to real database.
// So don't use `test` profile here.
public class HibernateConnectivityTest {
    @Autowired
    private SessionFactory sessionFactory;

    @Test
    public void test() {
        sessionFactory.openSession().close();
    }
}
