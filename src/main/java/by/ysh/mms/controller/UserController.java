package by.ysh.mms.controller;

import by.ysh.mms.domain.Role;
import by.ysh.mms.domain.User;
import by.ysh.mms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping ("/user")
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/user/{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping ("/user")
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user)
    {
        userService.saveUser(user, username, form);
        return "redirect:/user";
    }

    @GetMapping("/user/profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());
        return "profile";
    }

    @PostMapping("/user/profile")
    public String updateProfile(
            @AuthenticationPrincipal User user,
            @RequestParam String oldPassword,
            @RequestParam String email
    ){
        userService.updateProfile(user, oldPassword, email);
        return "redirect:/user/profile";
    }

    @GetMapping("/user/{user}/orders")
    public String getUserOrders(
            @PathVariable
            @AuthenticationPrincipal User user,
            Model model
    ){
        model.addAttribute("orders", user.getOrders());
        return "userOrders";
    }

    @RequestMapping(value = "/users/{user}/remove", method = RequestMethod.POST)
    public String removeOrder(
            @PathVariable
            @AuthenticationPrincipal User user,
            @RequestParam("user") long userId
    ){
        userService.deleteUser(userId);
        return "redirect:/user";
    }

}
