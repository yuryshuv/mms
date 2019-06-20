package by.ysh.mms.repos;

import by.ysh.mms.domain.Order;
import by.ysh.mms.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderRepo extends CrudRepository<Order, Long> {
    List<Order> findByUnitUnitId(Long id);
}
