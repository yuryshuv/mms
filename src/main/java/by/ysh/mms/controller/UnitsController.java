package by.ysh.mms.controller;

import by.ysh.mms.domain.*;
import by.ysh.mms.repos.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Set;

@Controller
@SuppressWarnings("Duplicates")
public class UnitsController {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private PartRepo partRepo;

    @Autowired
    private DocumentRepo documentRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/units/{unit}")
    public String documents(
            @PathVariable Unit unit,
            Model model
    ){
        Set<Document> documents = unit.getDocuments();
        Set<Part> parts = unit.getParts();
        Set<Order> orders = unit.getOrders();
        Iterable<User> users = userRepo.findAll();
        model.addAttribute("users", users);
        model.addAttribute("unit", unit);
        model.addAttribute("parts", parts);
        model.addAttribute("documents", documents);
        model.addAttribute("orders", orders);
        return "units";
    }

    @RequestMapping(value="/units/{unit}", method= RequestMethod.POST)
    public String addDocument(
            @AuthenticationPrincipal User user,
            @PathVariable Unit unit,
            @RequestParam(required = false, defaultValue = "") String partName,
            @RequestParam(required = false, defaultValue = "") String partDescription,
            @RequestPart(name = "file", required = false) MultipartFile file,
            @RequestParam(required = false, defaultValue = "") String documentDescription,
            @RequestParam(name = "btn", required = false, defaultValue = "") String button,
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
        Iterable<User> users = userRepo.findAll();
        model.addAttribute("users", users);
        model.addAttribute("orders", orders);
        model.addAttribute("documents", documents);
        model.addAttribute("parts", parts);
        return "units";
    }

    @RequestMapping(value="/units/{unit}/addOrder", method= RequestMethod.POST)
    public String addUnit(
            @RequestParam String expectedDate,
            @RequestParam String expectedTime,
            @PathVariable Unit unit,
            @RequestParam (required = false) Set<User> userArray,
            @AuthenticationPrincipal User user,
            @Valid Order order,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("order", order);
        } else {
            order.setUnit(unit);
            order.setAuthor(user);
            order.setEmployees(userArray);
            order.setStartTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")));
            order.setExpectedTime(expectedDate + " " + expectedTime);
            model.addAttribute("order", null);
            orderRepo.save(order);
        }
        Iterable<User> users = userRepo.findAll();
        Iterable<Order> orders = orderRepo.findAll();
        model.addAttribute("users", users);
        model.addAttribute("orders", orders);
        return "redirect:/units/{unit}";
    }

    @RequestMapping(value = "/units/{unit}/removeDocument", method = RequestMethod.POST)
    public String removeDocument(
            @PathVariable Unit unit,
            @RequestParam("document") long documentId
    ){
        documentRepo.deleteById(documentId);
        return "redirect:/units/{unit}";
    }

    @RequestMapping(value = "/units/{unit}/removePart", method = RequestMethod.POST)
    public String removePart(
            @PathVariable Unit unit,
            @RequestParam("part") long partId
    ){
        partRepo.deleteById(partId);
        return "redirect:/units/{unit}";
    }

}
