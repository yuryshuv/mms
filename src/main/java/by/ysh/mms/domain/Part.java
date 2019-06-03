package by.ysh.mms.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Part {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long partId;
    @NotBlank(message = "Поле не может быть пустым")
    @Length(max = 255, message = "Слишком длинное название (более, чем 255 символов)")
    private String partName;
    @Length(max = 255, message = "Слишком длинное описание (более, чем 255 символов)")
    private String partDescription;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "unit_unit_id")
    private Unit unit;

    public Part() {
    }

    public Part(String partName, String partDescription, User author, Unit unit) {
        this.partName = partName;
        this.partDescription = partDescription;
        this.author = author;
        this.unit = unit;
    }

    public Part(String partName, String partDescription, User author) {
        this.partName = partName;
        this.partDescription = partDescription;
        this.author = author;
    }

    public Long getPartId() {
        return partId;
    }

    public void setPartId(Long partId) {
        this.partId = partId;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getPartDescription() {
        return partDescription;
    }

    public void setPartDescription(String partDescription) {
        this.partDescription = partDescription;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getAuthorName(){
        return author != null ? author.getUsername() : "<none>";
    }

    public String getUnit() {
        return unit != null ? unit.getUnitName() : "<none>";
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }
}
