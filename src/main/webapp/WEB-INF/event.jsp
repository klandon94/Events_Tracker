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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<style>
		#home{
			margin: 20px 0 0 20px;
		}
		body{
			background-color:lightgoldenrodyellow;
		}
		h1{
			margin-bottom:50px;
		}
		#info{
			margin: 25px 0 0 15px;
			border:5px dotted green;
			padding:15px;
		}
		#info p{
			font-size:20px;
		}
		.labels{
			font-weight:bold;
			font-style:italic;
			text-decoration:underline;
		}
		#container{
			display:flex;
			justify-content:space-around;
		}
		#wall{
			width:500px;
			overflow:scroll;
			border:2px solid black;
			height:350px;
			padding:15px;
		}
		#pic{
			margin-top:150px;
			width:400px;
			height:300px;
		}
		.poster{
			font-weight:bold;
			color:blue;
		}
		.message{
			border-bottom:double;
		}
		.error{
			color:red;
			font-weight:bold;
		}
		.footer {
		    position: fixed;
		    left: 0;
		    bottom: 0;
		    width: 100%;
		    background-color: blue;
		    color: white;
		    text-align: center;
		}
	</style>
</head>
<body>
	<a href="/events" id="home" class="btn btn-primary">Home page</a>
	<div id="container">
		<div id="info">
			<h1>${event.name}</h1>
			<p><span class="labels">Host:</span> ${event.hoster.firstName} ${event.hoster.lastName}</p>
			<p><span class="labels">Date:</span> <fmt:formatDate pattern="MMMMMMM dd, yyyy" value="${event.date}"/></p>
			<p><span class="labels">Location:</span> ${event.city}, ${event.state}</p>
			<p><span class="labels">Number of people attending this event:</span> <c:out value="${event.joiners.size()}"/></p>
			<br>
			<c:if test="${event.joiners.size() == 0}">
			<p class="error">No joiners for this event yet</p>
			</c:if>
			<c:if test="${event.joiners.size() > 0}">
			<table class="table table-bordered table-dark" id="joiners">
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
				<p class="message"><span class="poster">${msg.poster.firstName}</span> (<fmt:formatDate pattern="MMMM dd @ h:mm:ss aa" value="${msg.createdAt}"/>): ${msg.comment}</p><br>
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
				<input type="submit" class="btn btn-success" value="Post">
			</form:form>
		</div>
		<div>
			<img id="pic" src="${event.image}">
		</div>
	</div>
	<div class="footer">
		<p>Events tracker</p>
	</div>
</body>
</html>