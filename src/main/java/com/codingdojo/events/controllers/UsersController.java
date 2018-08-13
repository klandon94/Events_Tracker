package com.codingdojo.events.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.events.models.User;
import com.codingdojo.events.services.UserService;
import com.codingdojo.events.validator.UserValidator;

@Controller
public class UsersController {
	private final UserService userServ;
	private final UserValidator userVal;
	
	public UsersController(UserService userServ, UserValidator userVal) {
		this.userServ = userServ;
		this.userVal = userVal;
	}
	
	@RequestMapping("/")
	public String loginRegister(Model model) {
		model.addAttribute("user", new User());
		return "loginregister.jsp";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userVal.validate(user, result);
		if (result.hasErrors()) return "loginregister.jsp";
		else {
			User u = userServ.registerUser(user);
			session.setAttribute("userId", u.getId());
			return "redirect:/events";
		}
	}
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		if (userServ.authenticateUser(email, password)) {
			User u = userServ.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/events";
		}
		model.addAttribute("loginerror", "Unable to login");
		model.addAttribute("user", new User());
		return "loginregister.jsp";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redir) {
		session.invalidate();
		redir.addFlashAttribute("logoutsuccess", "Successfully logged out");
		return "redirect:/";
	}
	
}
