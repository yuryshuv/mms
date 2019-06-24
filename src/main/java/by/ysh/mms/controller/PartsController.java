package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.Part;
import by.ysh.mms.domain.Unit;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;
import by.ysh.mms.repos.PartRepo;
import by.ysh.mms.repos.UnitRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.Map;

@Controller
@SuppressWarnings("Duplicates")
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

    @RequestMapping(value = "/parts", method = RequestMethod.POST)
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

    @RequestMapping(value = "/parts/{part}/remove", method = RequestMethod.POST)
    public String removePart(
            @PathVariable Part part,
            @RequestParam("part") long partId
    ){
        partRepo.deleteById(partId);
        return "redirect:/parts";
    }

    @GetMapping("/parts/{part}")
    public String getPart(
            @PathVariable Part part,
            Model model
    ) {
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("modules", modules);
        model.addAttribute("part", part);
        model.addAttribute("unit", part.getUnit());
        return "part";
    }

    @PostMapping("/parts/{part}")
    public String updatePart(
            @PathVariable Part part,
            @RequestParam String partName,
            @RequestParam String partDescription,
            @RequestParam (required = false) Unit unit,
            Model model
    ){
        part.setPartName(partName);
        part.setPartDescription(partDescription);
        part.setUnit(unit);
        partRepo.save(part);
        return "redirect:/parts";
    }
}
