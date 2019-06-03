package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.Part;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;
import by.ysh.mms.repos.PartRepo;
import by.ysh.mms.repos.UnitRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class PartsController {

    @Autowired
    private UnitRepo unitRepo;

    @Autowired
    private PartRepo partRepo;

    @Autowired
    private ModuleRepo moduleRepo;

    @GetMapping("/parts")
    public String parts(Model model) {
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<Part> parts = partRepo.findAll();
        model.addAttribute("parts", parts);
        model.addAttribute("modules", modules);
        return "parts";
    }

    @PostMapping("/parts")
    public String addPart(
            @RequestParam (required = false) Long unitId,
            @AuthenticationPrincipal User user,
            @Valid Part part,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("part", part);
        } else {
            if (unitRepo.findByUnitId(unitId) != null){
                part.setUnit(unitRepo.findByUnitId(unitId));
            }
            part.setAuthor(user);
            model.addAttribute("part", null);
            partRepo.save(part);
        }
        Iterable<Part> parts = partRepo.findAll();
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("parts", parts);
        model.addAttribute("modules", modules);
        return "parts";
    }

}
