package service;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.Predicate;
import java.util.Map;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
final class ServiceUtils {
    static <T> Specification<T> convertMapToSpec(Map<String, Object> criteria) {
        return (root, query, cb) -> {
            Predicate[] predicates = new Predicate[criteria.size()];
            int i = 0;
            for (Map.Entry<String, Object> entry : criteria.entrySet()) {
                if (i >= predicates.length) break;
                predicates[i++] = entry.getValue() instanceof String ?
                        cb.like(root.get(entry.getKey()), (String) entry.getValue()) :
                        cb.equal(root.get(entry.getKey()), entry.getValue());
            }
            return cb.and(predicates);
        };
    }
}
