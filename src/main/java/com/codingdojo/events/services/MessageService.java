package com.codingdojo.events.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.codingdojo.events.models.Message;
import com.codingdojo.events.repositories.MessageRepository;

@Service 
public class MessageService {
	private final MessageRepository messageRepo;
	
	public MessageService(MessageRepository messageRepo) {
		this.messageRepo = messageRepo;
	}
	
	public List<Message> allMsgs(){
		return messageRepo.findAll();
	}
	
//	public Message createMsg(Message m, Event e, User u) {
//		m.setPoster(u);
//		m.setEvent(e);
//		m.setId(null);  --> for whatever reason, using this method works
//		return messageRepo.save(m);
//	}
	
	public Message createMsg(Message m) {
		return messageRepo.save(m);
	}
	
}
