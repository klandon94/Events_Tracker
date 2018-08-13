<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Events dashboard</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<style>
		#header{
			display:flex;
			width:80%;
			justify-content:space-around;
		}
		#header a {
			margin-top:25px;
			height:50%;
		}
		#mystate, #otherstate{
			width:75%;
			margin:auto;
			margin-bottom:50px;
		}
		.none{
			margin-bottom:100px;
		}
		#create{
			margin-left:30px;
			width:35%;
		}
		.error{
			color:red;
		}
	</style>
</head>
<body>
	<div id="header">
		<h1>Welcome, ${user.firstName}</h1>
		<a href="/logout" class="btn btn-primary">Logout</a>
	</div>
	
	<p class="error"><c:out value="${editerror}"/></p>
	
	<c:if test="${myStateEvents.size() == 0}">
		<h3 class="none">There are currently no events in your state</h3>
	</c:if>
	<c:if test="${myStateEvents.size() > 0}">
	<h3>Here are some of the events in your state:</h3>
	<table class="table table-bordered" id="mystate">
		<thead>
			<tr>
				<th>Name</th>
				<th>Date</th>
				<th>Location</th>
				<th>Host</th>
				<th>Action/Status</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${myStateEvents}" var="event">
			<tr>
				<td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
				<td><fmt:formatDate pattern="MMMMMMM dd, yyyy" value="${event.date}"/></td>
				<td><c:out value="${event.city}, ${event.state}"/></td>
				<td><c:out value="${event.hoster.firstName}"/></td>
				<td>
					<c:if test="${event.hoster == user}">
						<a href="events/edit/${event.id}">Edit</a>
						<a href="events/delete/${event.id}">Delete</a>
					</c:if>
					<c:if test="${event.hoster != user}">
						<c:if test="${!event.joiners.contains(user)}">
							<a href="/events/${event.id}/join">Join</a>
						</c:if>
						<c:if test="${event.joiners.contains(user)}">
							Joining <a href="/events/${event.id}/cancel">Cancel</a>
						</c:if>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
	
	<c:if test="${otherStateEvents.size() == 0}">
		<h3 class="none">There are currently no events in other states</h3>
	</c:if>
	
	<c:if test="${otherStateEvents.size() > 0}">
		<h3>Here are some of the events in other states:</h3>
	<table class="table table-bordered" id="otherstate">
		<thead>
			<tr>
				<th>Name</th>
				<th>Date</th>
				<th>Location</th>
				<th>Host</th>
				<th>Action/Status</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${otherStateEvents}" var="event">
			<tr>
				<td><a href="/events/${event.id}"><c:out value="${event.name}"/></a></td>
				<td><fmt:formatDate pattern="MMMM dd, yyyy" value="${event.date}"/></td>
				<td><c:out value="${event.city}, ${event.state}"/></td>
				<td><c:out value="${event.hoster.firstName}"/></td>
				<td>
					<c:if test="${event.hoster == user}">
						<a href="events/edit/${event.id}">Edit</a>
						<a href="events/delete/${event.id}">Delete</a>
					</c:if>
					<c:if test="${event.hoster != user}">
						<c:if test="${!event.joiners.contains(user)}">
							<a href="/events/${event.id}/join">Join</a>
						</c:if>
						<c:if test="${event.joiners.contains(user)}">
							Joining <a href="/events/${event.id}/cancel">Cancel</a>
						</c:if>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
	
	<div id="create">
		<h3>Create an Event</h3>
		<c:if test="${errors != null}">
			<c:forEach items="${errors}" var="err">
				<p class="error">${err.defaultMessage}</p>
			</c:forEach>
		</c:if>
		<form:form method="post" action="/events/create" modelAttribute="event">
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
				  <option value="" selected="selected">Select a State</option>
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
			<input type="submit" value="Create Event!" class="btn btn-primary">
		</form:form>
	</div>
	
</body>
</html>