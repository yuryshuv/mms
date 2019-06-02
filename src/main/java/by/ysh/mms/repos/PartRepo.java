package by.ysh.mms.repos;

import by.ysh.mms.domain.Part;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PartRepo extends CrudRepository <Part, Long> {
    List<Part> findByPartName(String name);
    List<Part> findByUnitUnitId(Long id);
}
