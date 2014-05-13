<% option explicit %>
<!-- #include file="databla.asp" -->

<%
dim naam, email, bericht, logid, datum, tijd, ipadres, MailTo, CDO, zoekding, actie
dim Subject, internet, bodyMessage, SDO, sqlReactie, sqlGastenboek, MailFrom, id

actie = request("actie")
id = request("id")

if actie = "reactie" then
	Response.Cookies("3Lnaam") = request.form("naam")
	Response.Cookies("3Lnaam").Expires = Date + 365 
	Response.Cookies("3Lemail") = request.form("email")
	Response.Cookies("3Lemail").Expires = Date + 365 

	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	logid = request.form("logid")
	datum = date()
	tijd = time()
	ipadres = Request.ServerVariables("REMOTE_ADDR")

	'MAILTJE STUREN
	MailTo = "lukas@3l.nl"
	if email = "" then
		MailFrom = naam & "(postmaster@3l.nl)"
	else
		MailFrom = naam & "(" &email& ")"
	end if
	Subject	= "Reactie op 3L.nl"
	internet = "http://www.3l.nl/reactie.asp?id="&logid
	bodyMessage = vbCrLf&"IP-Adres = "&ipadres&vbCrLf&vbCrLf&naam& " (" &email& ") reageerde:" &vbCrLf&vbCrLf& bericht &vbCrLf&vbCrLf& internet

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
		sqlReactie = "INSERT INTO reactie (naam, bericht, datum, tijd, log_id, ip) values('"&naam&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&logid&"', '"&ipadres&"')"
	else
		sqlReactie = "INSERT INTO reactie (naam, email, bericht, datum, tijd, log_id, ip) values('"&naam&"', '"&email&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&logid&"', '"&ipadres&"')"
	end if
	Conn.Execute(sqlReactie)

	response.redirect ("reactie.asp?id="&logid)


elseif actie = "gastenboek" then
	if Left(request.form("naam"), 1) = " " then 
		response.write "Je kunt als eerste karakter van je naam geen spatie gebruiken."
	elseif len(request.form("bericht")) > 300 then
		response.write "Met dank aan edwin mag je voortaan niet meer dan 300 tekens in het gastenboek pleuren. <br>Blame <a href=""mailto:millenniumgroup@wanadoo.nl"">Edwin</a>"
	else  
		Response.Cookies("3Lnaam") = request.form("naam")
		Response.Cookies("3Lnaam").Expires = Date + 365 
		Response.Cookies("3Lemail") = request.form("email")
		Response.Cookies("3Lemail").Expires = Date + 365 

		naam = request.form("naam")
		email = request.form("email")
		bericht = request.form("bericht")
		datum = date()
		tijd = time()
		ipadres = Request.ServerVariables("REMOTE_ADDR")

		bericht = Replace(bericht, "<", "&lt")
		bericht = Replace(bericht, ">", "&gt")
		bericht = Replace(bericht, "(", "&#40")
		bericht = Replace(bericht, ")", "&#41")
		bericht = Replace(bericht, ";", "&#59")
		bericht = Replace(bericht, "'", "&#39")

		if email = "" then
			sqlGastenboek = "INSERT INTO gastenboek (naam, bericht, datum, tijd, ip) values('"&naam&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&ipadres&"')"
		else
			sqlGastenboek = "INSERT INTO gastenboek (naam, email, bericht, datum, tijd, ip) values('"&naam&"', '"&email&"', '"&bericht&"', '"&datum&"', '"&tijd&"', '"&ipadres&"')"
		end if
		Conn.Execute(sqlGastenboek)

		response.redirect ("weblog.asp")
	end if


elseif actie = "contact" then
	MailTo = "lukas@3l.nl"

	if request.Form("naam") = "" then
		MailFrom = "Anoniem"
	else
		MailFrom = request.Form("naam")
	end if

	if request.form("email") = "" then
		MailFrom = MailFrom & "(postmaster@3l.nl)"
	else
		MailFrom = MailFrom & "(" &request.form("email")& ")"
	end if

	Subject	= "Contact via weblog.3L.nl"

	bodyMessage = vbCrLf& "IP Adres = " &Request.ServerVariables("REMOTE_ADDR") &vbCrLf&vbCrLf& request.Form("naam") & " (" &request.Form("email")& ") zegt:" &vbCrLf & vbCrLf& request.Form("bericht")

	Set CDO		= Server.CreateObject("CDONTS.NewMail")
	CDO.To		= MailTo
	CDO.From	= MailFrom
	CDO.Subject = Subject
	CDO.Body = bodyMessage
	CDO.Send

	Response.Redirect "nutteloos.asp?actie=contactbedankt"


elseif actie = "zoekreactie" then
	response.redirect "nutteloos.asp?actie=reactiepp&id=" &request.form("naam")

elseif actie = "zoekgoogle" then
	response.redirect "http://www.google.nl/search?q="&replace(request.form("zoekding")," ","+")

end if
%>