package dao;

import entity.Borrower;
import entity.BorrowerType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BorrowerRepository extends CrudRepository<Borrower, Integer> {
    Optional<Borrower> findBorrowerById(Integer id);
    Optional<Borrower> findBorrowerByIdAndDeletedIsFalse(Integer id);

    Optional<Borrower> findBorrowerByName(String name);

    List<Borrower> findBorrowersByType(BorrowerType type);
    List<Borrower> findBorrowersByDeleted(Boolean deleted);

    Page<Borrower> findAll(Pageable pageable);
    List<Borrower> findAll(Specification specification);
    Page<Borrower> findAll(Specification specification, Pageable pageable);
}
