<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit event ${event.id}</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<style>
		body{
			background-color:lightgoldenrodyellow;
		}
		#header{
			display:flex;
			justify-content:space-between;
			width:90%;
			margin:0 auto;
		}
		.event{
			font-size:35px;
			font-weight:bold;
		}
		#editform{
			width:50%;
		}
		h3{
			text-align:center;
		}
		h1, #editform{
			margin-left:30px;
		}
		#edit{
			border:5px dotted green;
			width:50%;
			margin: 0 auto;
		}
		.error{
			color:red;
			font-weight:bold;
		}
	</style>
</head>
<body>
	<div id="header">
		<span class="event">${event.name}</span>
		<a href="/events" id="home" class="btn btn-primary">Home page</a>
	</div>
	<br>
	<div id="edit">
	<h3>Edit event</h3>
	<form:form method="post" action="/events/edit/${event.id}" modelAttribute="event" id="editform">
		<input type="hidden" name="_method" value="put">
		<div class="form-group">
			<form:label path="name">Event name:</form:label>
            <br>
            <form:errors path="name" cssClass="error"/>
            <form:input path="name" cssClass="form-control"/>
		</div>
		<div class="form=group">
			<form:label path="date">Date:</form:label>
               <br>
               <form:errors path="date" cssClass="error"/>
               <form:input path="date" type="date" cssClass="form-control"/>
		</div>
		<div class="form-group">
           	<form:label path="city">City:</form:label>
           	<br>            	
           	<form:errors path="city" cssClass="error"/>
           	<form:input path="city" cssClass="form-control"/>
        </div>
		<div class="form-group">
			<form:label path="state">State:</form:label>
           	<form:errors path="state" cssClass="error"/>
           	<form:select path="state" cssClass="form-inline">
			  <option value="">Select a State</option>
			  <option value="AL">Alabama</option>
			  <option value="AK">Alaska</option>
			  <option value="AZ">Arizona</option>
			  <option value="AR">Arkansas</option>
			  <option value="CA">California</option>
			  <option value="CO">Colorado</option>
			  <option value="CT">Connecticut</option>
			  <option value="DE">Delaware</option>
			  <option value="DC">District Of Columbia</option>
			  <option value="FL">Florida</option>
			  <option value="GA">Georgia</option>
			  <option value="HI">Hawaii</option>
			  <option value="ID">Idaho</option>
			  <option value="IL">Illinois</option>
			  <option value="IN">Indiana</option>
			  <option value="IA">Iowa</option>
			  <option value="KS">Kansas</option>
			  <option value="KY">Kentucky</option>
			  <option value="LA">Louisiana</option>
			  <option value="ME">Maine</option>
			  <option value="MD">Maryland</option>
			  <option value="MA">Massachusetts</option>
			  <option value="MI">Michigan</option>
			  <option value="MN">Minnesota</option>
			  <option value="MS">Mississippi</option>
			  <option value="MO">Missouri</option>
			  <option value="MT">Montana</option>
			  <option value="NE">Nebraska</option>
			  <option value="NV">Nevada</option>
			  <option value="NH">New Hampshire</option>
			  <option value="NJ">New Jersey</option>
			  <option value="NM">New Mexico</option>
			  <option value="NY">New York</option>
			  <option value="NC">North Carolina</option>
			  <option value="ND">North Dakota</option>
			  <option value="OH">Ohio</option>
			  <option value="OK">Oklahoma</option>
			  <option value="OR">Oregon</option>
			  <option value="PA">Pennsylvania</option>
			  <option value="RI">Rhode Island</option>
			  <option value="SC">South Carolina</option>
			  <option value="SD">South Dakota</option>
			  <option value="TN">Tennessee</option>
			  <option value="TX">Texas</option>
			  <option value="UT">Utah</option>
			  <option value="VT">Vermont</option>
			  <option value="VA">Virginia</option>
			  <option value="WA">Washington</option>
			  <option value="WV">West Virginia</option>
			  <option value="WI">Wisconsin</option>
			  <option value="WY">Wyoming</option>
			</form:select>
		</div>
		<div class="form-group">
           	<form:label path="image">Image:</form:label>
           	<br>            	
           	<form:input path="image" cssClass="form-control"/>
        </div>
		<input type="submit" value="Edit" class="btn btn-primary">
	</form:form>
	</div>
</body>
</html>