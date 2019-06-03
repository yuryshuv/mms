package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.Unit;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.UnitRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
public class ModulesController {

    @Autowired
    private UnitRepo unitRepo;

    @GetMapping("/modules/{module}")
    public String units(
            @PathVariable Module module,
            Model model

    ){
        Set<Unit> units = module.getUnits();
        model.addAttribute("module", module);
        model.addAttribute("units", units);
        return "modules";
    }


    @PostMapping("/modules/{module}")
    public String addUnit(
            @AuthenticationPrincipal User user,
            @PathVariable Module module,
            @Valid Unit unit,
            BindingResult bindingResult,
            Model model)
    {
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("unit", unit);
        } else {
            List<Unit> unitsFromDb = unitRepo.findByUnitName(unit.getUnitName());
            if (unitsFromDb != null && unitsFromDb.stream().anyMatch(s -> s.getModule().equals(unit.getModule()))){
                model.addAttribute("unit", unit);
                model.addAttribute("unitNameError", "Узел с таким именем уже существует");
            } else {
                unit.setModule(module);
                unit.setAuthor(user);
                model.addAttribute("unit", null);
                unitRepo.save(unit);
            }
        }
        Iterable<Unit> units = unitRepo.findByModuleModuleId(module.getModuleId());
        model.addAttribute("units", units);
        return "modules";
    }
}
