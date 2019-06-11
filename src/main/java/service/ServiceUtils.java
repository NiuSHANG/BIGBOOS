package service;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
final class ServiceUtils {
    @SafeVarargs
    static <T> Specification<T> convertMapToSpec(Map<String, Object>... criteria) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            for (Map<String, Object> criterion : criteria) {
                for (Map.Entry<String, Object> entry : criterion.entrySet()) {
                    predicates.add(entry.getValue() instanceof String ?
                            cb.like(root.get(entry.getKey()), (String) entry.getValue()) :
                            cb.equal(root.get(entry.getKey()), entry.getValue()));
                }
            }
            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }

    static <K, V> Map<K, V> mapOf(Object... values) {
        Map<K, V> out = new HashMap<>();
        for (int i = 0; i / 2 < values.length / 2; i += 2) {
            // noinspection unchecked
            out.put((K) values[i], (V) values[i + 1]);
        }
        return out;
    }
}
