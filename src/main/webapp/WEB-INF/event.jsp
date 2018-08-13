<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${event.name}</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<style>
		h1{
			margin-top:50px;
		}
		h1, #info p, #joiners{
			margin-left:50px;
		}
		#info p{
			font-size:20px;
		}
		#container{
			display:flex;
			justify-content:space-between;
		}
		#messages{
			margin-right:200px;
		}
		#wall{
			width:500px;
			overflow:scroll;
			border:2px solid black;
			height:300px;
		}
		.error{
			color:red;
			font-weight:bold;
		}
	</style>
</head>
<body>
	<a href="/events">Home page</a>
	<h1>${event.name}</h1>
	<br>
	<div id="container">
		<div id="info">
			<p><b>Host:</b> ${event.hoster.firstName} ${event.hoster.lastName}</p>
			<p><b>Date:</b> <fmt:formatDate pattern="MMMMMMM dd, yyyy" value="${event.date}"/></p>
			<p><b>Location:</b> ${event.city}, ${event.state}</p>
			<p><b>Number of people attending this event:</b> <c:out value="${event.joiners.size()}"/></p>
			<br>
			<c:if test="${event.joiners.size() == 0}">
			<p>No joiners for this event yet</p>
			</c:if>
			<c:if test="${event.joiners.size() > 0}">
			<table class="table table-bordered" id="joiners">
				<thead>
					<tr>
						<th>Name</th>
						<th>Location</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${event.joiners}" var="joiner">
					<tr>
						<td>${joiner.firstName} ${joiner.lastName}</td>
						<td>${joiner.city}, ${joiner.state}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
		</div>
		<div id="messages">
			<h2>Message Wall</h2>
			<div id="wall">
				<c:forEach items="${event.messages}" var="msg">
				<p>${msg.poster.firstName} says (<fmt:formatDate pattern="MMMM dd @ h:mm:ss aa" value="${msg.createdAt}"/>): ${msg.comment}</p>
				<p>-----------------------</p>
				</c:forEach>
			</div>
			<br>
			<h3>Add comment</h3>
			<c:if test="${errors != null}">
				<c:forEach items="${errors}" var="err">
					<p class="error">${err.defaultMessage}</p>
				</c:forEach>
			</c:if>
			<form:form action="/events/${event.id}/addmsg" method="post" modelAttribute="message">
				<form:textarea path="comment" cssClass="form-control"></form:textarea>
				<br>
				<input type="submit" value="Post">
			</form:form>
		</div>
	</div>
</body>
</html>