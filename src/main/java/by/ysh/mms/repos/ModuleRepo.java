package by.ysh.mms.repos;

import by.ysh.mms.domain.Module;
import org.springframework.data.repository.CrudRepository;

public interface ModuleRepo extends CrudRepository <Module, Long> {
    Module findByModuleName(String module);
}
