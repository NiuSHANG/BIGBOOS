package config;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;
import org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import java.util.Optional;
import java.util.Properties;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(basePackages = "dao")
public class HibernateConfig {
    @Bean
    @Profile("!test")
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName(Optional.ofNullable(System.getProperty("db.driver")).orElse("com.mysql.cj.jdbc.Driver"));
        dataSource.setUrl(Optional.ofNullable(System.getProperty("db.conn_str")).orElse("jdbc:mysql://localhost:3306/test?serverTimezone=GMT%2B8"));
        dataSource.setUsername(Optional.ofNullable(System.getProperty("db.username")).orElse("root"));
        dataSource.setPassword(Optional.ofNullable(System.getProperty("db.password")).orElse("123456"));
        return dataSource;
    }

    @Bean("hibernateProperties")
    @Profile("!test")
    public Properties hibernateProperties() {
        Properties hibernateProperties = new Properties();
        hibernateProperties.setProperty("hibernate.hibernate.hbm2ddl.auto", "update");
        hibernateProperties.setProperty("hibernate.hbm2ddl.auto", "update");
        hibernateProperties.setProperty("hibernate.dialect", Optional.ofNullable(System.getProperty("db.dialect")).orElse("org.hibernate.dialect.MySQL8Dialect"));
        hibernateProperties.setProperty("hibernate.show_sql", "true");

        return hibernateProperties;
    }

    @Bean
    public LocalSessionFactoryBean sessionFactory(@Autowired DataSource dataSource,
                                                  @Autowired @Qualifier("hibernateProperties") Properties hibernateProps) {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        sessionFactory.setPackagesToScan("entity");
        sessionFactory.setHibernateProperties(hibernateProps);
        return sessionFactory;
    }

    @Bean
    public HibernateTransactionManager hibernateTransactionManager(@Autowired DataSource dataSource,
                                                                   @Autowired @Qualifier("hibernateProperties") Properties hibernateProps) {
        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
        transactionManager.setSessionFactory(sessionFactory(dataSource, hibernateProps).getObject());
        return transactionManager;
    }

    @Bean
    @Primary
    public PlatformTransactionManager transactionManager(@Autowired EntityManagerFactory emf) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(emf);
        return transactionManager;
    }

    @Bean
    public PersistenceExceptionTranslationPostProcessor exceptionTranslation(){
        return new PersistenceExceptionTranslationPostProcessor();
    }

    @Bean
    @Primary
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(@Autowired DataSource dataSource,
                                                                       @Autowired @Qualifier("hibernateProperties") Properties hibernateProps) {
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(dataSource);
        em.setPackagesToScan("entity");

        JpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        em.setJpaVendorAdapter(vendorAdapter);
        em.setJpaProperties(hibernateProps);

        return em;
    }
}
