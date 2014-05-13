<!-- #include file="../databla.asp" -->

<%
Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

actie = request("actie")
id = request("id")

if actie = "gastenboek" then

	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	datum = date()
	tijd = time()
	ipadres = Request.ServerVariables("REMOTE_ADDR")

	bericht1 = Replace(bericht, "<", "&lt")
	bericht1 = Replace(bericht1, ">", "&gt")
	bericht1 = Replace(bericht1, "(", "&#40")
	bericht1 = Replace(bericht1, ")", "&#41")
	bericht1 = Replace(bericht1, ";", "&#59")
	bericht1 = Replace(bericht1, "'", "&#39")

	if email = "" then
		sqlLukas = "INSERT INTO lukas (naam, bericht, datum, tijd, ip) values('"&naam&"', '"&bericht1&"', '"&datum&"', '"&tijd&"', '"&ipadres&"')"
	else
		sqlLukas = "INSERT INTO lukas (naam, email, bericht, datum, tijd, ip) values('"&naam&"', '"&email&"', '"&bericht1&"', '"&datum&"', '"&tijd&"', '"&ipadres&"')"
	end if
	
	Conn.Execute(sqlLukas)

	response.redirect ("default.asp")


elseif actie = "contact" then

	MailTo = "lukas@3l.nl"

	if request.Form("naam") = "" then
		MailFrom = Anoniem
	else
		MailFrom = request.Form("naam")
	end if

	if request.form("email") = "" then
		MailFrom = MailFrom & "(postmaster@3l.nl)"
	else
		MailFrom = MailFrom & "(" &request.form("email")& ")"
	end if

	Subject	= "Contact via Lukas.3L.nl"

	bodyMessage = vbCrLf& "IP Adres = " &Request.ServerVariables("REMOTE_ADDR") &vbCrLf& request.Form("naam") & " (" &request.Form("email")& ") zegt:" &vbCrLf & vbCrLf& request.Form("bericht")

	Dim CDO
	Set CDO		= Server.CreateObject("CDONTS.NewMail")
	CDO.To		= MailTo
	CDO.From	= MailFrom
	CDO.Subject = Subject

	CDO.Body = bodyMessage
	CDO.Send

	Response.Redirect "default.asp?actie=contactbedankt"

end if

%>