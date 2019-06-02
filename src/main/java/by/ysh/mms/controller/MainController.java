package by.ysh.mms.controller;

import by.ysh.mms.domain.*;
import by.ysh.mms.repos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class MainController {
    @Autowired
    private UnitRepo unitRepo;

    @Autowired
    private PartRepo partRepo;

    @Autowired
    private ModuleRepo moduleRepo;

    @Autowired
    private DocumentRepo documentRepo;

    @Autowired
    private OrderRepo orderRepo;

    @Autowired UserRepo userRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model){
        return "greeting";
    }

    @GetMapping("/parts")
    public String parts(Model model) {
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<Part> parts = partRepo.findAll();
        model.addAttribute("parts", parts);
        model.addAttribute("modules", modules);
        return "parts";
    }

    @PostMapping ("/parts")
    public String addPart(
            @AuthenticationPrincipal User user,
            @RequestParam String partName,
            @RequestParam String partDescription,
            @RequestParam (required = false, defaultValue = "") String unitName,
            Model model) {
        Part part = new Part(partName, partDescription, user, unitRepo.findByUnitName(unitName));
        partRepo.save(part);
        Iterable<Part> parts = partRepo.findAll();
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("parts", parts);
        model.addAttribute("modules", modules);
        return "parts";
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
        module.setAuthor(user);
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("module", module);
        } else {
            moduleRepo.save(module);
        }
        Iterable<Module> modules = moduleRepo.findAll();
        model.addAttribute("module", null);
        model.addAttribute("modules", modules);
        return "main";
    }

    @GetMapping ("/modules/{module}")
    public String units(
            @PathVariable Module module,
            Model model

    ){
        Set<Unit> units = module.getUnits();
        model.addAttribute("module", module);
        model.addAttribute("units", units);
        return "modules";
    }


    @PostMapping ("/modules/{module}")
    public String addUnit(
            @AuthenticationPrincipal User user,
            @PathVariable Module module,
            @RequestParam String unitName,
            @RequestParam String unitDescription,
            Model model)
    {
        Unit unit = new Unit(unitName, unitDescription, user, module);
        unitRepo.save(unit);
        Iterable<Unit> units = unitRepo.findByModuleModuleId(module.getModuleId());
        model.addAttribute("units", units);
        return "modules";
    }

    @GetMapping("/units/{unit}")
    public String documents(
            @PathVariable Unit unit,
            Model model
    ){
        Set<Document> documents = unit.getDocuments();
        Set<Part> parts = unit.getParts();
        Set<Order> orders = unit.getOrders();
        model.addAttribute("unit", unit);
        model.addAttribute("parts", parts);
        model.addAttribute("documents", documents);
        model.addAttribute("orders", orders);
        return "units";
    }

    @RequestMapping(value="/units/{unit}", method=RequestMethod.POST)
    public String addDocument(
            @AuthenticationPrincipal User user,
            @PathVariable Unit unit,
            @RequestParam(required = false, defaultValue = "") String documentDescription,
            @RequestPart(name = "file", required = false) MultipartFile file,
            @RequestParam(name = "btn", required = false, defaultValue = "") String button,
            @RequestParam(required = false, defaultValue = "") String partName,
            @RequestParam(required = false, defaultValue = "") String partDescription,
            Model model) throws IOException
    {
        if ("addDocument".equals(button)){
            Document document = new Document(documentDescription, user, unit);
            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()){
                    uploadDir.mkdir();
                }
                file.transferTo(new File(uploadPath + "/" + file.getOriginalFilename()));
                document.setDocumentName(file.getOriginalFilename());
            }
            documentRepo.save(document);
        } else if ("addPart".equals(button)){
            Part part = new Part(partName, partDescription, user, unit);
            partRepo.save(part);
        }
        Iterable<Document> documents = documentRepo.findByUnitUnitId(unit.getUnitId());
        Iterable<Part> parts = partRepo.findByUnitUnitId(unit.getUnitId());
        Iterable<Order> orders = orderRepo.findByUnitUnitId(unit.getUnitId());
        model.addAttribute("orders", orders);
        model.addAttribute("documents", documents);
        model.addAttribute("parts", parts);
        return "units";
    }

    @GetMapping("/orders")
    public String orders(Model model) {
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<User> users = userRepo.findAll();
        Iterable<Order> orders = orderRepo.findAll();
        model.addAttribute("modules", modules);
        model.addAttribute("users", users);
        model.addAttribute("orders", orders);
        return "orders";
    }

    @PostMapping ("/orders")
    public String addOrder(
            @AuthenticationPrincipal User user,
            @RequestParam String orderName,
            @RequestParam String orderDescription,
            @RequestParam String expectedDate,
            @RequestParam String expectedTime,
            Model model) {
        Order order = new Order(orderName, orderDescription,
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")),
                expectedDate + " " + expectedTime, user);
        orderRepo.save(order);
        Iterable<Order> orders = orderRepo.findAll();
        model.addAttribute("orders", orders);
        return "orders";
    }

}