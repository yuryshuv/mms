package by.ysh.mms.controller;

import by.ysh.mms.domain.Module;
import by.ysh.mms.domain.Order;
import by.ysh.mms.domain.Unit;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.ModuleRepo;
import by.ysh.mms.repos.OrderRepo;
import by.ysh.mms.repos.UserRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Set;

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

    @RequestMapping(value ="/orders", method = RequestMethod.POST)
    public String addOrder(
            @RequestParam String expectedDate,
            @RequestParam String expectedTime,
            @RequestParam (required = false) Unit unit,
            @RequestParam (required = false) Set<User> userArray,
            @AuthenticationPrincipal User user,
            @Valid Order order,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()){
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
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<User> users = userRepo.findAll();
        Iterable<Order> orders = orderRepo.findAll();
        model.addAttribute("modules", modules);
        model.addAttribute("users", users);
        model.addAttribute("orders", orders);
        return "redirect:/orders";
    }

    @RequestMapping(value = "/orders/{order}/remove", method = RequestMethod.POST)
    public String removeOrder(
            @PathVariable Order order,
            @RequestParam("order") long orderId
    ){
        orderRepo.deleteById(orderId);
        return "redirect:/orders";
    }

    @GetMapping(value = "/orders/{order}")
    public String getOrder(
            @PathVariable Order order,
            Model model
    ) {
        String[] date = order.getExpectedTime().split("\\.");
        Iterable<Module> modules = moduleRepo.findAll();
        Iterable<User> users = userRepo.findAll();
        model.addAttribute("users", users);
        model.addAttribute("modules", modules);
        model.addAttribute("orderName", order.getOrderName());
        model.addAttribute("orderDescription", order.getOrderDescription());
        model.addAttribute("unit", order.getUnit());
        model.addAttribute("userArray", order.getEmployees());
        model.addAttribute("expectedDate", date[0]+".");
        if (date.length == 2){
            model.addAttribute("expectedTime", date[1].substring(1));
        } else model.addAttribute("expectedTime", "");
        return "order";
    }

    @RequestMapping(value = "/orders/{order}/finish", method = RequestMethod.POST)
    public String finishOrder(
            @PathVariable Order order
    ){
        order.setFinished(true);
        order.setEndTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")));
        orderRepo.save(order);
        return "redirect:/orders";
    }

    @PostMapping("/orders/{order}")
    public String updateOrder(
            @PathVariable Order order,
            @RequestParam String orderName,
            @RequestParam String orderDescription,
            @RequestParam (required = false) Unit unit,
            @RequestParam (required = false) Set<User> userArray,
            @RequestParam String expectedDate,
            @RequestParam String expectedTime
    ){
        order.setOrderName(orderName);
        order.setOrderDescription(orderDescription);
        order.setUnit(unit);
        order.setEmployees(userArray);
        order.setStartTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("d MMM yyyy г. HH:mm")));
        order.setExpectedTime(expectedDate + " " + expectedTime);
        orderRepo.save(order);
        return "redirect:/orders";
    }

}
