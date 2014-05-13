<!-- #include file="../databla.asp" -->
<%
Response.Expires=0 '0 is het aantal minuten dat de pagina in de cache wordt opgeslagen 
response.CacheControl="private" 'private geeft aan dat je pagina niet door proxy servers gecached wordt.

dim id, actie, datum, tijd, titel, bericht, url, techniek, email, aantal, preview, fs

id = Request("id")
actie = Request("actie")
datum = date()
tijd = time()

Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

if actie = "login" then
	if request.form("naam") <> "lukas" or request.form("wachtwoord") <> "zevenaar" then
		response.redirect("default.asp?fout=fout")
	end if
	
	Response.Cookies("3LCMSnaam") = request.form("naam")
	Response.Cookies("3LCMSnaam").Expires = Date + 365 
	
	session("user") = "lukas"
	
	response.redirect("welkom.asp")
	
end if


if actie = "logout" then
	session.abandon
	response.redirect("default.asp")
end if


if actie = "weblogaanmaken" then
	titel = request.form("titel")
	bericht = request.form("bericht")

'	bericht = Replace(bericht, "(", "&#40")
'	bericht = Replace(bericht, ")", "&#41")
'	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")
	titel = Replace(titel, "'", "&#39")

	Conn.Execute("INSERT INTO log (titel, bericht, datum, tijd) values('"&titel&"', '"&bericht&"', '"&datum&"', '"&tijd&"')")

	response.redirect ("rss.asp")


elseif actie = "weblogwijzigen" then
	titel = request.form("titel")
	bericht = request.form("bericht")
	id = request.form("id")

'	bericht = Replace(bericht, "(", "&#40")
'	bericht = Replace(bericht, ")", "&#41")
'	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")
	titel = Replace(titel, "'", "&#39")

	Conn.Execute("UPDATE log SET titel='"&titel&"', bericht='"&bericht&"' WHERE id="&id)
	response.redirect ("rss.asp")


elseif actie = "portfolio" then
	response.redirect ("portfolio.asp")


elseif actie = "pfaanpassen" then
	titel = request.form("titel")
	url = request.form("url")
	techniek = request.form("techniek")
	bericht = request.form("bericht")
	id = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("UPDATE portfolio SET titel='"&titel&"', url='"&url&"', techniek='"&techniek&"', bericht='"&bericht&"' WHERE id="&id)

	response.redirect ("portfolio.asp")


elseif actie = "pfnieuw" then
	titel = request.form("titel")
	url = request.form("url")
	techniek = request.form("techniek")
	bericht = request.form("bericht")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("INSERT INTO portfolio (titel, url, techniek, bericht) values('"&titel&"', '"&url&"', '"&techniek&"', '"&bericht&"')")
	response.redirect ("portfolio.asp")


elseif actie = "pfdel" then
	Conn.Execute("DELETE FROM portfolio WHERE id="&id)
	response.redirect ("portfolio.asp")


elseif actie = "blatenaanpassen" then
	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	id = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("UPDATE gastenboek SET naam='"&naam&"', email='"&email&"', bericht='"&bericht&"' WHERE id=" &id)
	response.redirect ("geblaat.asp")


elseif actie = "blatenverwijderen" then
	Conn.Execute("DELETE * FROM gastenboek WHERE id="&id)
	response.redirect ("geblaat.asp")


elseif actie = "lukasaanpassen" then
	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	id = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("UPDATE lukas SET naam='"&naam&"', email='"&email&"', bericht='"&bericht&"' WHERE id=" &id)
	response.redirect ("geblaat")


elseif actie = "lukasverwijderen" then
	Conn.Execute("DELETE * FROM lukas WHERE id="&id)
	response.redirect ("geblaat")


elseif actie = "reactieaanpassen" then
	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	id = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	if email="" then
		Conn.Execute("UPDATE reactie SET naam='"&naam&"', bericht='"&bericht&"' WHERE id=" &id)
	else
		Conn.Execute("UPDATE reactie SET naam='"&naam&"', email='"&email&"', bericht='"&bericht&"' WHERE id=" &id)
	end if
	response.redirect ("weblog.asp?actie=reacties")


elseif actie = "reactieverwijderen" then
	Conn.Execute("DELETE * FROM reactie WHERE id="&id)
	response.redirect ("weblog.asp?actie=reacties")


elseif actie = "fotologgen" then
	titel = request.form("titel")
	bericht = request.form("bericht")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("INSERT INTO fotolog (titel, bericht, datum) values('"&titel&"', '"&bericht&"', '"&datum&"')")
	response.redirect ("fotolog.asp")


elseif actie = "fotologaanpassen" then
	titel = request.form("titel")
	bericht = request.form("bericht")
	logid = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("UPDATE fotolog SET titel='"&titel&"', datum='"&datum&"', bericht='"&bericht&"' WHERE id="&logid)
	response.redirect ("fotolog.asp")


elseif actie = "fotoreactieaanpassen" then
	naam = request.form("naam")
	email = request.form("email")
	bericht = request.form("bericht")
	id = request.form("id")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	if email="" then
		Conn.Execute("UPDATE fotoreactie SET naam='"&naam&"', bericht='"&bericht&"' WHERE id=" &id)
	else
		Conn.Execute("UPDATE fotoreactie SET naam='"&naam&"', email='"&email&"', bericht='"&bericht&"' WHERE id=" &id)
	end if
	response.redirect ("fotolog.asp?actie=reacties")


elseif actie = "fotoreactieverwijderen" then
	Conn.Execute("DELETE * FROM fotoreactie WHERE id="&id)
	response.redirect ("fotolog.asp?actie=reacties")


elseif actie = "albumtoevoegen" then
	titel = request.form("titel")
	aantal = request.form("aantal")
	preview = request.form("preview")
	bericht = request.form("bericht")

	titel = Replace(titel, "(", "&#40")
	titel = Replace(titel, ")", "&#41")
	titel = Replace(titel, ";", "&#59")
	titel = Replace(titel, "'", "&#39")
	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("INSERT INTO fotoalbum (titel, bericht, datum, aantal, preview) values('"&titel&"', '"&bericht&"', '"&datum&"', '"&aantal&"', '"&preview&"')")
	response.redirect ("fotoalbum.asp")


elseif actie = "albumaanpassen" then
	titel = request.form("titel")
	aantal = request.form("aantal")
	preview = request.form("preview")
	bericht = request.form("bericht")
	id = request.form("id")

	titel = Replace(titel, "(", "&#40")
	titel = Replace(titel, ")", "&#41")
	titel = Replace(titel, ";", "&#59")
	titel = Replace(titel, "'", "&#39")

	bericht = Replace(bericht, "(", "&#40")
	bericht = Replace(bericht, ")", "&#41")
	bericht = Replace(bericht, ";", "&#59")
	bericht = Replace(bericht, "'", "&#39")

	Conn.Execute("UPDATE fotoalbum SET titel='"&titel&"', datum='"&datum&"', aantal='"&aantal&"', preview='"&preview&"', bericht='"&bericht&"' WHERE id="&id)

	response.redirect ("fotoalbum.asp")


elseif actie = "albumverwijderen" then
	Conn.Execute("DELETE * FROM fotoalbum WHERE id="&id)
	'verwijder alle bestanden
	set fs=Server.CreateObject("Scripting.FileSystemObject")
	if fs.FolderExists("d:\www\3l.nl\www\fotolog\foto\"&id) then
		fs.DeleteFolder("d:\www\3l.nl\www\fotolog\foto\"&id)
	end if
	if fs.FolderExists("d:\www\3l.nl\www\fotolog\foto\"&id&"t") then
		fs.DeleteFolder("d:\www\3l.nl\www\fotolog\foto\"&id&"t")
	end if

	response.redirect ("fotoalbum.asp")

end if
%>