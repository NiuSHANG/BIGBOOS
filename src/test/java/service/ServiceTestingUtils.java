package service;

import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;

public abstract class ServiceTestingUtils { // use abstract to avoid JUnit invocation
    private ServiceTestingUtils() {}

    public static <T> void addAllAndUpdate(List<T> list, Function<T, T> repoFunc) {
        addAllAndUpdate(list, repoFunc, null);
    }

    public static <T> void addAllAndUpdate(List<T> list, Function<T, T> repoFunc, Consumer<T> additionalOperations) {
        for (int i = 0; i < list.size(); i++) {
            T neue = repoFunc.apply(list.get(i));
            if (additionalOperations != null)
                additionalOperations.accept(neue);
            list.set(i, neue);
        }
    }
}
