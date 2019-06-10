package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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

    @RequestMapping (value = "/main", method = RequestMethod.POST)
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

    @RequestMapping(value = "/main/remove", method = RequestMethod.POST)
    public String removeModule(
            @RequestParam("module") long moduleId
    ){
        System.out.println("remove");
        System.out.println(moduleId);
        moduleRepo.deleteById(moduleId);
        return "redirect:/main";
    }

    @GetMapping("/main/{module}")
    public String getModule(
            @PathVariable Module module,
            Model model
            ) {
        model.addAttribute("moduleName", module.getModuleName());
        model.addAttribute("moduleDescription", module.getModuleDescription());
        return "moduleEdit";
    }

    @PostMapping("/main/{module}")
    public String updateModule(
            @PathVariable Module module,
            @RequestParam String moduleName,
            @RequestParam String moduleDescription,
            Model model
    ){
        module.setModuleName(moduleName);
        module.setModuleDescription(moduleDescription);
        moduleRepo.save(module);
        return "redirect:/main/";
    }


}