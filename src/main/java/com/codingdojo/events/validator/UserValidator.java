package com.codingdojo.events.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.codingdojo.events.models.User;
import com.codingdojo.events.services.UserService;

@Component
public class UserValidator implements Validator {
	
	private final UserService userServ;
	
	public UserValidator(UserService userServ) {
		this.userServ = userServ;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		if (!user.getPasswordConfirmation().equals(user.getPassword()))
			errors.rejectValue("passwordConfirmation", "Match");
		if (userServ.findByEmail(user.getEmail()) != null)
			errors.rejectValue("email", "AlreadyTaken");
	}
	
}
