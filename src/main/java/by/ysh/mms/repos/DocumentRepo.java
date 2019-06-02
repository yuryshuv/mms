package by.ysh.mms.repos;

import by.ysh.mms.domain.Document;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface DocumentRepo extends CrudRepository <Document, Long> {
    List<Document> findByDocumentName(String module);
    List<Document> findByUnitUnitId(Long id);
}
