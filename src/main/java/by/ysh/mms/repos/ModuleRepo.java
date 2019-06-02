package by.ysh.mms.repos;

import by.ysh.mms.domain.Module;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ModuleRepo extends CrudRepository <Module, Long> {
    List<Module> findByModuleName(String module);
}
