<%
if left(request.servervariables("URL"),4) = "/g4g" then
	response.redirect("http://g4g.3l.nl/")
end if
%>
<%saveReferrer()%>
<HTML>
<HEAD>
	<TITLE>
		<%
		If request.querystring("g") <> "" Then
			set rs = conn.execute("SELECT * FROM g4g LEFT JOIN g4g_categorie ON g4g_categorie.g4g_categorie_id = g4g.categorie_id WHERE g4g_id="&request.querystring("g"))
			response.write(rs("g4g.titel") & " - " & rs("g4g_categorie.titel") & " - Gifts 4 Girls")
			set rs = nothing
		ElseIf request.querystring("c") <> "" Then
			set rs = conn.execute("SELECT * FROM g4g_categorie WHERE g4g_categorie_id="&request.querystring("c") )
			response.write(rs("titel") & " - Gifts 4 Girls")
			set rs = nothing
		Else
			response.write("Gifts 4 Girls - Originele cadeau's voor (en door) mijn vriendin")
		End If
	%>
	</TITLE>
	<META NAME="Author" CONTENT="Lukas van 3L">
	<link href="/favicon.ico" rel="shortcut icon" />
	<META NAME="Keywords" CONTENT="Valentijn, Cadeau, creatief, computerkunst, crea bea, lukas van driel, lukas, verjaardag, feest, vriendin, lief, attent, gentleman">
	<META NAME="Description" CONTENT="Als je een idee voor een cadeau voor je vriendin zoekt kan je hier terecht.">
	<link rel="STYLESHEET" type="text/css" href="g4g/g4g.css">
</HEAD>
<BODY>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0" framespacing="0">
<tr>
	<td align=center valign=center>

<table width=760 height=420 background=g4g/inc/background.gif align=center border="0" cellspacing="0" cellpadding="0" framespacing="0">
	<tr height=0><td width=330></td><td width=180></td><td width=250></td></tr>
	<tr height=110>
		<td colspan=2></td>
		<td width=350 align=left valign=top><a href="http://g4g.3l.nl"><img src="g4g/inc/g4g.gif"></a></td>
	</tr>
	<tr height=310>
		<td width=250 valign=top><%
			for i = 1 to 4
				%><a href="default.asp?c=<%=i%>"><img src="g4g/inc/nav_<%=i%>.gif"></a><%
			next
			%></td>
		<td colspan=2 rowspan=2>
			<DIV id="divje"<%
			if instr(request.servervariables("HTTP_USER_AGENT"),"MSIE") then
				response.write("style=""background-attachment: fixed;""")
			end if
			%>>

<%if request.querystring("g") <> "" then

	set rs = conn.execute("SELECT * FROM g4g LEFT JOIN g4g_categorie ON g4g_categorie.g4g_categorie_id = g4g.categorie_id WHERE g4g_id="&request.querystring("g"))%>
	
	<table width=100% border="0">
	<tr>
		<td valign=top>
			<h1><%=rs("g4g.titel")%></h1>
			<%
			if rs("omschrijving") <> "" then
				response.write( replace(rs("omschrijving"),vbcrlf,"<br>") )
			else
				response.write( replace(rs("intro"),vbcrlf,"<br>") )
			end if
			%>
		</td>
		<td align=right>
			<%if rs("foto") <> "" then%>
				<img src="g4g/img/<%=rs("foto")%>">
			<%end if%>
		</td>
	</tr>
	<tr>
		<td valign=top colspan=2>
	<%if len(rs("g4g.tekst")) > 20 then%>
		<h2>Omschrijving</h2>
		<%=rs("g4g.tekst")%>
	<%end if%>
	<%if rs("zip") <> "" then%>
		<h2>Bestanden downloaden</h2>
		&nbsp;&nbsp;<a href="http://g4g.3l.nl/g4g/zip/<%=rs("zip")%>"><%=rs("zip")%></a>
	<%end if%>
		</td>
	</tr>
	</table>
	<p align=right><a href="default.asp?c=<%=rs("categorie_id")%>">Terug naar de <%=rs("g4g_categorie.titel")%> overzicht</a></p>
	
	<%set rs = nothing

else%>
	<table width="100%" height="100%" border=0 cellpadding=2 cellspacing=0>
	
	<%if request.querystring("c") = 5 or request.querystring("c") = "" then
	
		set rs = conn.execute("SELECT * FROM g4g_categorie WHERE g4g_categorie_id=5" )%>
		<tr>
			<td width=100% valign=top><h1><%=rs("titel")%></h1>
				<%=replace(rs("tekst"), vbcrlf, "<br>")%>
			</td>
			<td width=232>
				<img src="g4g/inc/strand.jpg" width=232 height=300 alt="Gifts for Girls">
			</td>
		</tr>
	
	<%else
	
		set rs = conn.execute("SELECT * FROM g4g_categorie WHERE g4g_categorie_id="&request.querystring("c") )%>
		<tr>
			<td valign="top" colspan=2><h1><%=rs("titel")%></h1>
				<%=replace(rs("tekst"), vbcrlf, "<br>")%></td>
		</tr>	<tr>
			<td colspan=2><hr></td>
		</tr>
		<%
		set rs2 = conn.execute("SELECT * FROM g4g WHERE categorie_id="&request.querystring("c")&" AND not isnull(foto) ORDER BY datum DESC, titel ASC" )
		do until rs2.EOF
			%>
			<tr>
				<td valign="top"><h2>
					<a href="default.asp?g=<%=rs2("g4g_id")%>"><%=rs2("titel")%></a>
					</h2>
					<%=replace(rs2("intro"), vbcrlf, "<br>")%></td>
				<td valign="top" align="right">
					<a href="default.asp?g=<%=rs2("g4g_id")%>">
					<img src="g4g/img/<%=rs2("foto")%>" alt="<%=rs2("foto")%>"></a>
					</td>
			</tr>
			<%
		rs2.movenext : loop
		rs2.close : set rs2 = nothing
	end if
	set rs = nothing
end if%>
			
			
			</DIV>
		</td>
	</tr>
</table>

</td></tr></table>
<%set conn = nothing%>
</BODY>
</HTML>