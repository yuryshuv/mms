package by.ysh.mms.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Document {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long documentId;

    @NotBlank(message = "Поле не может быть пустым")
    @Length(max = 255, message = "Слишком длинное имя файла (более, чем 255 символов)")
    private String documentName;

    @Length(max = 255, message = "Слишком длинное описание файла (более, чем 255 символов)")
    private String documentDescription;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "unit_unit_id")
    private Unit unit;

    public Document() {
    }

    public Document(String documentDescription, User author, Unit unit) {
        this.documentDescription = documentDescription;
        this.author = author;
        this.unit = unit;
    }

    public Long getDocumentId() {
        return documentId;
    }

    public void setDocumentId(Long documentId) {
        this.documentId = documentId;
    }

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getAuthorName (){
        return author != null ? author.getUsername() : "<none>";
    }

    public String getDocumentDescription() {
        return documentDescription;
    }

    public void setDocumentDescription(String documentDescription) {
        this.documentDescription = documentDescription;
    }

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }
}
