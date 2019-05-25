package dao;

import entity.Admin;
import entity.Borrower;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AdminRepository extends CrudRepository<Admin, Integer> {
    Optional<Admin> findAdminById(Integer id);
    Optional<Admin> findAdminByName(String name);

    Page<Borrower> findAll(Pageable pageable);
    List<Borrower> findAll(Specification specification);
    Page<Borrower> findAll(Specification specification, Pageable pageable);
}
