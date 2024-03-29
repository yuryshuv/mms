package by.ysh.mms.service;

import by.ysh.mms.domain.Role;
import by.ysh.mms.domain.User;
import by.ysh.mms.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user == null || !user.isActive()){
            throw new UsernameNotFoundException("Неверное имя пользователя или пароль");
        }
        return user;
    }

    public boolean addUser(User user){
        User userFromDb = userRepo.findByUsername(user.getUsername());
        if (userFromDb != null){
            return false;
        }
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);
        sendMessage(user);
        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            String message = String.format(
                    "Здравствуйте, %s! \n" +
                            "Вы зарегистрировались в систему управления обслуживанием. " +
                            "Для завершения регистрации перейдите по следующей ссылке: " +
                            "http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(),"Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null){
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepo.save(user);
        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepo.save(user);
    }

    public void updateProfile(User user, String oldPassword, String email) {
        String userEmail = user.getEmail();
        boolean isEmailChanged = (email != null && !email.equals(userEmail)) ||
                (userEmail != null && !userEmail.equals(email));
        if (isEmailChanged) {
            user.setEmail(email);
            if(!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if (!StringUtils.isEmpty(oldPassword)) {
            user.setPassword(passwordEncoder.encode(oldPassword));
        }
        userRepo.save(user);
        if (isEmailChanged) {
            sendMessage(user);
        }
    }

    public void deleteUser(long userId) {
        userRepo.deleteById(userId);
    }

    public void sendPassword(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String newPassword = UUID.randomUUID().toString().substring(0,8);
            String message = String.format(
                    "Здравствуйте, %s! \n" +
                            "Ваш пароль для входа в систему: %s, смените после входа в систему",
                    user.getUsername(),
                    newPassword
            );
            user.setPassword(passwordEncoder.encode(newPassword));
            userRepo.save(user);
            mailSender.send(user.getEmail(), "Восстановление пароля", message);
        }
    }

    public User findByUsername(String username) {
        return userRepo.findByUsername(username);
    }
}
