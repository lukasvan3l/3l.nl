<% option explicit %>
<!-- #include file="../../../inc/db/driel.asp" -->

<%
dim actie
actie=request("actie")

if actie = "reactie" then
	dim naam, email, bericht, logid, datum, tijd, MailTo, MailFrom, Subject, bodyMessage, SDO

	Response.Cookies("Fotonaam") = request.form("naam")
	Response.Cookies("Fotonaam").Expires = Date + 365 
	Response.Cookies("Fotoemail") = request.form("email")
	Response.Cookies("Fotoemail").Expires = Date + 365 

	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	logid = request.form("fotoid")
	datum = date()
	tijd = time()


	'MAILTJE STUREN
	MailTo = "lukas@3l.nl"
	if email = "" then
		MailFrom = naam & "(postmaster@3l.nl)"
	else
		MailFrom = naam & "(" &email& ")"
	end if
	Subject	= "Reactie op Fotolog.3L.nl"
	bodyMessage = vbCrLf & naam & " (" &email& ") reageerde:" & vbCrLf & vbCrLf& bericht &vbCrLf & vbCrLf& "http://fotolog.3l.nl/fotolog/default.asp?id=" &logid

	Set SDO		= Server.CreateObject("CDONTS.NewMail")
	SDO.To		= MailTo
	SDO.From	= MailFrom
	SDO.Subject = Subject
	SDO.Body = bodyMessage
	SDO.Send
	
	'IN DATABASE PLEMPEM
	bericht = Replace(bericht, "<", "&lt")
	bericht = Replace(bericht, ">", "&gt")
	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	if email = "" then
		Conn.Execute("INSERT INTO fotoreactie (naam, bericht, datum, tijd, foto_id) values('"&naam&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&logid&"')")
	else
		Conn.Execute("INSERT INTO fotoreactie (naam, email, bericht, datum, tijd, foto_id) values('"&naam&"', '"&email&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&logid&"')")
	end if
	
	response.redirect ("reactie.asp?id="&logid)
end if
%>