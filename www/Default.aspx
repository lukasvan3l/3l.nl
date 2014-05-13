<%@ Page Title="Home Page" Language="C#" %>


<% 

String host = Request.Url.Host;

if (host == "fotoalbum.3l.nl")
	Response.Redirect("https://plus.google.com/u/0/photos/118431366129339151157/albums"); 	
else if (host == "dev.3l.nl")
	Response.Redirect("http://developer.3l.nl"); 	
else
	Response.Redirect("http://tumblr.3l.nl"); 

%>