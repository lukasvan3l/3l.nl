<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<!-- #include virtual="/projecten/3lv3/inc/adovbs.inc" -->

<%
if actie = "" then
	orderby1 = request.querystring("orderby")
	if orderby1 = "" then
		orderby1 = "1desc"
	end if
	orderby2 = left(orderby1,1) & " " & right(orderby1, len(orderby1)-1)
	%>
<H1>Geblaat</H1>
<table width="700" cellpadding=0 cellspacing=0 border=0>
	<tr height="30">
		<td width="50"><a href="geblaat.asp?orderby=<%if orderby1 = "1asc" then%>1desc<%else%>1asc<%end if%>">id</a></td>
		<td width="250"><a href="geblaat.asp?orderby=<%if orderby1 = "2asc" then%>2desc<%else%>2asc<%end if%>">naam</a></td>
		<td width="150"><a href="geblaat.asp?orderby=<%if orderby1 = "3asc" then%>3desc<%else%>3asc<%end if%>">datum/tijd</a></td>
		<td width="250"></td>
	</tr>
	<%
	set rs=Server.CreateObject("ADODB.recordset") 
	sql="SELECT id, naam, datum, tijd, bericht FROM gastenboek ORDER BY "&orderby2
	
	rs.CursorLocation = adUseClient
	rs.PageSize=25
	
	rs.Open sql,conn 
	
	if request.querystring("pagina") = "" then 
		huidige_pagina = 1 
		else 
		huidige_pagina = Cint(request.querystring("pagina")) 
	end if 
	
	aantal_paginas = rs.PageCount 
	 
	If 1 > huidige_pagina Then huidige_pagina = 1 
	If huidige_pagina > aantal_paginas Then huidige_pagina = aantal_paginas 
	 
	rs.AbsolutePage = huidige_pagina
	
	Do While rs.AbsolutePage = huidige_pagina AND Not rs.EOF%>
		<tr onmouseover="setPointer(this, 'over')" onmouseout="setPointer(this, 'out')">
			<td><%=rs("id")%></td>
			<td><a href=geblaat.asp?actie=wijzigen&id=<%=rs("id")%>><%=rs("naam")%></a></td>
			<td><em><%=rs("datum")%> om <%=rs("tijd")%></em></td>
			<td align="right">
				<a href=geblaat.asp?actie=wijzigen&id=<%=rs("id")%>>Bewerk</a>
				</td>
		</tr>
		<%
	RS.MoveNext
	Loop
	rs.Close
	Set rs = Nothing
	Conn.Close
	Set Conn = Nothing%>
	</table>
	<p align="right">
	<%If huidige_pagina = 1 Then%>
		Vorige
	<%else%>
		<a href="<%=request.servervariables("SCRIPT_NAME") & "?orderby="&request.querystring("orderby")&"&pagina=" & huidige_pagina - 1 %>">Vorige</a>
	<%end if%>
	 | 
	<%if huidige_pagina = aantal_paginas then%>
		Volgende
	<%else%>
		<a href="<%=request.servervariables("SCRIPT_NAME") & "?orderby="&request.querystring("orderby")&"&pagina=" & huidige_pagina + 1 %>">Volgende</a>
	<%end if%>
	</p>
	
<%
elseif actie = "wijzigen" then
	w "<H1>Geblaat Aanpassen</H1>"
	sql="SELECT * FROM gastenboek WHERE id="&id
	set rsGast = Conn.Execute(sql)

		response.write "<FORM METHOD=POST ACTION='actie.asp?actie=blatenaanpassen' name='formulier'>"
		response.write "<INPUT TYPE='hidden' name='id' VALUE='"&rsGast("id")&"'>"
		response.write "Naam:<br><INPUT TYPE='text' NAME='naam' class=button value='" &rsGast("naam")& "'><br>"
		response.write "E-mail:<br><INPUT TYPE='text' NAME='email' class=button value='" &rsGast("email")& "'><br>"
		response.write "IP Adres:<br><INPUT TYPE='text' readonly NAME='ipadres' class=button value='" &rsGast("ip")& "'><br>"
		response.write "Bericht:<br><TEXTAREA NAME='bericht' ROWS=10 COLS=40 class=button>" &rsGast("bericht")& "</TEXTAREA><br>"
		response.write "<INPUT TYPE='submit' class=button value='opslaan'><img src=inc/blank.gif height=1 width=100>"
		response.write "<a href=actie.asp?actie=blatenverwijderen&id=" &rsGast("id")& "><img src=inc/prullenbak.gif> Verwijderen</a>"
		response.write "</FORM>"

	rsGast.close
	set rsGast = nothing



elseif actie = "wijzigenlukas" then
	w "<H1>Geblaat Aanpassen</H1>"
	sql="SELECT * FROM lukas WHERE id="&id
	set rsLukas = Conn.Execute(sql)

		response.write "<FORM METHOD=POST ACTION='actie.asp?actie=lukasaanpassen' name='formulier'>"
		response.write "<INPUT TYPE='hidden' name='id' VALUE='"&rsLukas("id")&"'>"
		response.write "Naam:<br><INPUT TYPE='text' NAME='naam' class=button value='" &rsLukas("naam")& "'><br>"
		response.write "E-mail:<br><INPUT TYPE='text' NAME='email' class=button value='" &rsLukas("email")& "'><br>"
		response.write "Bericht:<br><TEXTAREA NAME='bericht' ROWS=10 COLS=40 class=button>" &rsLukas("bericht")& "</TEXTAREA><br>"
		response.write "<INPUT TYPE='submit' class=button value='opslaan'><img src=inc/blank.gif height=1 width=100>"
		response.write "<a href=actie.asp?actie=lukasverwijderen&id=" &rsLukas("id")& "><img src=inc/prullenbak.gif> Verwijderen</a>"
		response.write "</FORM>"

	rsLukas.close
	set rsLukas = nothing


elseif actie = "ipadrestoevoegen1" then
	%>
	Hier kun je een naam toekennen aan een IP adres (en andersom) in de reacties op 3L.nl.
	<FORM METHOD=POST ACTION="geblaat.asp?actie=ipadrestoevoegen2">
		IP adres <INPUT TYPE="text" NAME="ipadres" size=15 class=button> wordt toegekend aan persoon <INPUT TYPE="text" NAME="naam" size=10 class=button> &nbsp<INPUT TYPE="submit" class=button value="Hoppa!">
	</FORM>
	<%


elseif actie = "ipadrestoevoegen2" then
	ipadres = request.form("ipadres")
	naam = LCase(request.form("naam"))

	conn.execute("UPDATE fotoreactie SET ip='"&ipadres&"' WHERE LCase(naam)='"&naam&"' AND id<18")
	conn.execute("UPDATE gastenboek SET ip='"&ipadres&"'  WHERE LCase(naam)='"&naam&"' AND id<135")
	conn.execute("UPDATE lukas SET ip='"&ipadres&"'  WHERE LCase(naam)='"&naam&"'")
	conn.execute("UPDATE reactie SET ip='"&ipadres&"'  WHERE LCase(naam)='"&naam&"' AND id<873")

	conn.execute("UPDATE fotoreactie SET naam='"&naam&"' WHERE ip='"&ipadres&"' AND id<18")
	conn.execute("UPDATE gastenboek SET naam='"&naam&"'  WHERE ip='"&ipadres&"' AND id<135")
	conn.execute("UPDATE lukas SET naam='"&naam&"'  WHERE ip='"&ipadres&"'")
	conn.execute("UPDATE reactie SET naam='"&naam&"'  WHERE ip='"&ipadres&"' AND id<873")

	response.write "IP Adres "&ipadres&" toegekend aan "&naam&"."



end if
%>
		
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->