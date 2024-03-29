package by.ysh.mms.repos;

import by.ysh.mms.domain.Unit;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UnitRepo extends CrudRepository <Unit, Long> {
    List<Unit> findByUnitName(String name);
    List<Unit> findByModuleModuleId(Long id);
    Unit findByUnitId (Long id);
}
