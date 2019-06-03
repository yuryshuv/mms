package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.Order;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;
import by.ysh.mms.repos.OrderRepo;
import by.ysh.mms.repos.UserRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Controller
public class OrdersController {

    @Autowired
    private ModuleRepo moduleRepo;

    @Autowired
    private OrderRepo orderRepo;

    @Autowired
    private UserRepo userRepo;

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

    @PostMapping("/orders")
    public String addOrder(
            @RequestParam String expectedDate,
            @RequestParam String expectedTime,
            @AuthenticationPrincipal User user,
            @Valid Order order,
            BindingResult bindingResult,
//            @RequestParam String orderName,
//            @RequestParam String orderDescription,
            Model model) {
//        Order order = new Order(orderName, orderDescription,
//                LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")),
//                expectedDate + " " + expectedTime, user);
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("order", order);
        } else {
            order.setAuthor(user);
            order.setStartTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")));
            order.setExpectedTime(expectedDate + " " + expectedTime);
            model.addAttribute("unit", null);
            orderRepo.save(order);
        }
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<User> users = userRepo.findAll();
        Iterable<Order> orders = orderRepo.findAll();
        model.addAttribute("modules", modules);
        model.addAttribute("users", users);
        model.addAttribute("orders", orders);
        return "orders";
    }
}
