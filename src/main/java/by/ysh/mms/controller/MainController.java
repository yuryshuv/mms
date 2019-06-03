package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class MainController {

    @Autowired
    private ModuleRepo moduleRepo;

    @GetMapping("/")
    public String greeting(Map<String, Object> model){
        return "greeting";
    }

    @GetMapping("/main")
    public String modules(Model model) {
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("modules", modules);
        return "main";
    }

    @PostMapping ("/main")
    public String add(
            @AuthenticationPrincipal User user,
            @Valid Module module,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("module", module);
        } else {
            Module moduleFromDb = moduleRepo.findByModuleName(module.getModuleName());
            if (moduleFromDb != null){
                model.addAttribute("module", module);
                model.addAttribute("moduleNameError", "Модуль с таким именем уже существует");
            } else {
                module.setAuthor(user);
                model.addAttribute("module", null);
                moduleRepo.save(module);
            }
        }
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("modules", modules);
        return "main";
    }

}