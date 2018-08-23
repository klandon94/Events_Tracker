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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<style>
		body{
			background-color: lightgoldenrodyellow;
		}
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
			border:5px dotted green;
			padding:10px;
			margin: 0 0 30px 30px;
			width:35%;
			display:inline-block;
		}
		.error{
			color:crimson;
			font-weight:bold;
		}
		.special{
			font-style:italic;
			font-weight:bold;
		}
		#img{
			height:500px;
			width:500px;
			display:inline-block;
			vertical-align:top;
			margin-left:250px;
		}
	</style>
</head>
<body>
	<div id="header">
		<h1>Welcome, ${user.firstName}!</h1>
		<a href="/logout" class="btn btn-primary" id="logout">Logout</a>
	</div>
	
	<p class="error"><c:out value="${editerror}"/></p>
	
	<c:if test="${myStateEvents.size() == 0}">
		<h3 class="none">There are currently no events in your state</h3>
	</c:if>
	<c:if test="${myStateEvents.size() > 0}">
	<h3>Here are some events in your state:</h3>
	<table class="table table-bordered table-dark" id="mystate">
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
				<td><a href="/events/${event.id}" class="btn btn-warning"><c:out value="${event.name}"/></a></td>
				<td><fmt:formatDate pattern="MMMMMMM dd, yyyy" value="${event.date}"/></td>
				<td><c:out value="${event.city}, ${event.state}"/></td>
				<td><c:out value="${event.hoster.firstName}"/></td>
				<td>
					<c:if test="${event.hoster == user}">
						<a href="events/edit/${event.id}" class="btn btn-primary">Edit</a>
						<a href="events/delete/${event.id}" class="btn btn-danger">Delete</a>
					</c:if>
					<c:if test="${event.hoster != user}">
						<c:if test="${!event.joiners.contains(user)}">
							<a href="/events/${event.id}/join" class="btn btn-success">Join</a>
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
		<h3>Here are some events in other states:</h3>
	<table class="table table-bordered table-dark" id="otherstate">
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
				<td><a href="/events/${event.id}" class="btn btn-warning"><c:out value="${event.name}"/></a></td>
				<td><fmt:formatDate pattern="MMMM dd, yyyy" value="${event.date}"/></td>
				<td><c:out value="${event.city}, ${event.state}"/></td>
				<td><c:out value="${event.hoster.firstName}"/></td>
				<td>
					<c:if test="${event.hoster == user}">
						<a href="events/edit/${event.id}" class="btn btn-primary">Edit</a>
						<a href="events/delete/${event.id}" class="btn btn-danger">Delete</a>
					</c:if>
					<c:if test="${event.hoster != user}">
						<c:if test="${!event.joiners.contains(user)}">
							<a href="/events/${event.id}/join" class="btn btn-success">Join</a>
						</c:if>
						<c:if test="${event.joiners.contains(user)}">
							<span class="special">Joining</span> <a href="/events/${event.id}/cancel">Cancel</a>
						</c:if>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:if>
	
	<div id="bottom">
	
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
				<div class="form-group">
	            	<form:label path="image">Image:</form:label>
	            	<br>            	
	            	<form:input path="image" cssClass="form-control"/>
	            </div>
				<input type="submit" value="Create Event!" class="btn btn-primary">
			</form:form>
		</div>
		
			<img id="img" src="https://png.icons8.com/metro/1600/tear-off-calendar.png">
		
	</div>
	
</body>
</html>