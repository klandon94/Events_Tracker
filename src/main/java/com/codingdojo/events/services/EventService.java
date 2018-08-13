package com.codingdojo.events.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.events.models.Event;
import com.codingdojo.events.models.User;
import com.codingdojo.events.repositories.EventRepository;

@Service
public class EventService {
	private final EventRepository eventRepo;
	
	public EventService(EventRepository eventRepo) {
		this.eventRepo = eventRepo;
	}
	
	public List<Event> getAllEvents(){
		return eventRepo.findAll();
	}
	
	public List<Event> allEventsMyState(String state){
		return eventRepo.findByStateOrderByDateAsc(state);
	}
	
	public List<Event> allEventsNotMyState(String state){
		return eventRepo.findByStateNotOrderByDateAsc(state);
	}
	
	
	public Event createEvent(Event e, User u) {
		e.setHoster(u);
		return eventRepo.save(e);
	}
	
	public Event getEvent(Long id) {
		Optional<Event> optionalEvent = eventRepo.findById(id);
		if (optionalEvent.isPresent()) return optionalEvent.get();
		else return null;
	}
	
	public void updateEvent(Long id, String name, Date date, String city, String state) {
		Optional<Event> event = eventRepo.findById(id);
		if (event.isPresent()) {
			event.get().setName(name);
			event.get().setDate(date);
			event.get().setCity(city);
			event.get().setState(state);
			eventRepo.save(event.get());
		}
	}
	
	public void deleteEvent(Long id) {
		eventRepo.deleteById(id);
	}
	
	public void joinEvent(Event e, User u) {
		List<User> joiners = e.getJoiners();
		joiners.add(u);
		e.setJoiners(joiners);
		eventRepo.save(e);
	}
	
	public void leaveEvent(Event e, User u) {
		List<User> joiners = e.getJoiners();
		joiners.remove(u);
		e.setJoiners(joiners);
		eventRepo.save(e);
	}
	
}
