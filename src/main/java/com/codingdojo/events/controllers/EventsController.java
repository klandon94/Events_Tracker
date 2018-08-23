package com.codingdojo.events.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.Message;
import com.codingdojo.events.models.User;
import com.codingdojo.events.services.EventService;
import com.codingdojo.events.services.MessageService;
import com.codingdojo.events.services.UserService;

@Controller
@RequestMapping("/events")
public class EventsController {
	private final UserService userServ;
	private final EventService eventServ;
	private final MessageService messageServ;
	
	public EventsController(UserService userServ, EventService eventServ, MessageService messageServ) {
		this.userServ = userServ;
		this.eventServ = eventServ;
		this.messageServ = messageServ;
	}
	
	@RequestMapping("")
	public String home(HttpSession session, Model model, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			User u = userServ.findUserById(userId);
			model.addAttribute("user", u);
			model.addAttribute("event", new Event());
			model.addAttribute("myStateEvents", eventServ.allEventsMyState(u.getState()));
			model.addAttribute("otherStateEvents", eventServ.allEventsNotMyState(u.getState()));
			return "eventdash.jsp";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to enter this website");
		return "redirect:/";
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String create(@Valid @ModelAttribute("event") Event event, BindingResult result, HttpSession session, Model model, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			redir.addFlashAttribute("errors", result.getAllErrors());
			return "redirect:/events";
		}
		else {
			User u = userServ.findUserById(userId);
			eventServ.createEvent(event, u);
			return "redirect:/events";
		}
	}
	
	@RequestMapping("/{id}/join")
	public String join(@PathVariable(value="id") Long id, HttpSession session, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			User user = userServ.findUserById(userId);
			Event event = eventServ.getEvent(id);
			eventServ.joinEvent(event, user);		
			return "redirect:/events";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to perform this action");
		return "redirect:/";
	}
	
	@RequestMapping("/{id}/cancel")
	public String cancel(@PathVariable(value="id") Long id, HttpSession session, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			User user = userServ.findUserById(userId);
			Event event = eventServ.getEvent(id);
			eventServ.leaveEvent(event, user);	
			return "redirect:/events";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to peform this action");
		return "redirect:/";
	}
	
	@RequestMapping("/{id}")
	public String viewEvent(HttpSession session, @PathVariable(value="id") Long id, RedirectAttributes redir, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			Event e = eventServ.getEvent(id);
			model.addAttribute("event", e);
			model.addAttribute("message", new Message());
			return "event.jsp";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to enter this webpage");
		return "redirect:/";
	}
	
	@RequestMapping(value="/{id}/addmsg", method=RequestMethod.POST)
	public String addMessage(@Valid @ModelAttribute(value="message") Message message, BindingResult result, @PathVariable(value="id") Long id, RedirectAttributes redir, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (result.hasErrors()) {
			redir.addFlashAttribute("errors", result.getAllErrors());
			return "redirect:/events/" + id;
		}
		Event event = eventServ.getEvent(id);
		User user = userServ.findUserById(userId);
		messageServ.createMsg(new Message(message.getComment(), event, user));
		return "redirect:/events/" + id;
	}
	
	@RequestMapping(value="/edit/{id}")
	public String edit(@ModelAttribute("event") Event event, @PathVariable(value="id") Long id, Model model, HttpSession session, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {			
			Event e = eventServ.getEvent(id);
			User u = userServ.findUserById(userId);
			if (e.getHoster().getId() == u.getId()) {
				model.addAttribute("event", e);
				return "editevent.jsp";
			}
			redir.addFlashAttribute("editerror", "You are not the host of this event!");
			return "redirect:/events";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to enter this webpage");
		return "redirect:/";
	}
	
	@RequestMapping(value="/edit/{id}", method=RequestMethod.PUT)
	public String editEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, @PathVariable(value="id") Long id, Model model) {
		if (result.hasErrors()) return "editevent.jsp";
		else {
			eventServ.updateEvent(id, event.getName(), event.getDate(), event.getCity(), event.getState(), event.getImage());
			return "redirect:/events";
		}
	}
	
	@RequestMapping(value="/delete/{id}")
	public String deleteEvent(@PathVariable(value="id") Long id, HttpSession session, RedirectAttributes redir) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId != null) {
			Event e = eventServ.getEvent(id);
			User u = userServ.findUserById(userId);
			if (e.getHoster().getId() == u.getId()) {
				eventServ.deleteEvent(id);
				return "redirect:/events";
			}
			redir.addFlashAttribute("editerror", "You are not the host of this event!");
			return "redirect:/events";
		}
		redir.addFlashAttribute("badlogin", "You must be logged in to perform this action");
		return "redirect:/";
	}
	
}
