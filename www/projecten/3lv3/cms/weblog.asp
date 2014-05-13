<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<!-- #include virtual="/projecten/3lv3/inc/adovbs.inc" -->

<%if actie = "" then
	orderby = request.querystring("orderby")
	if orderby = "" then
		orderby = "1desc"
	end if
	orderby = left(orderby,1) & " " & right(orderby, len(orderby)-1)
	%>
<H1>Weblog Aanpassen</H1>
<table width="700" cellpadding=0 cellspacing=0 border=0>
	<tr height="30">
		<td width="50"><a href="weblog.asp?orderby=<%if request.querystring("orderby") = "1desc" then%>1asc<%else%>1desc<%end if%>">id</a></td>
		<td width="250"><a href="weblog.asp?orderby=<%if request.querystring("orderby") = "2desc" then%>2asc<%else%>2desc<%end if%>">titel</a></td>
		<td width="150"><a href="weblog.asp?orderby=<%if request.querystring("orderby") = "3desc" then%>3asc<%else%>3desc<%end if%>">datum/tijd</a></td>
		<td width="250"></td>
	</tr>
	<%
	set rs=Server.CreateObject("ADODB.recordset") 
	sql="SELECT id, titel, datum, tijd, bericht FROM log ORDER BY "&orderby
	
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
			<td><a href=weblog.asp?actie=wijzigen&id=<%=rs("id")%>><%=rs("titel")%></a></td>
			<td><em><%=rs("datum")%> om <%=rs("tijd")%></em></td>
			<td align="right">
				<a href=weblog.asp?actie=wijzigen&id=<%=rs("id")%>>Bewerk</a> |
				<a href=weblog.asp?actie=reacties&id=<%=rs("id")%>>Reacties</a> |
				<a href='http://www.3l.nl/reactie.asp?id=<%=rs("id")%>' target=_blank>Lezen</a>
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

<%elseif actie = "aanmaken" then
	%>
	<H1>Weblog Aanmaken</H1>
	<FORM METHOD=POST ACTION="actie.asp?actie=weblogaanmaken">
	<table width=500>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button size="50"></td>
		</tr>
		<tr>
			<td valign=top>Bericht:</td>
			<td><TEXTAREA NAME="bericht" ROWS="20" COLS="60" class=button>


<img src=http://home.planet.nl/~vdriel/fotos/.jpg></TEXTAREA></td>
		</tr>
		<tr>
			<td></td>
			<td><INPUT TYPE="submit" class=button value='Loggen maar!'></td>
		</tr>
	</table>
	</FORM>
	<%



elseif actie = "wijzigen" then
	sql = "SELECT * FROM log WHERE id = "&id
	set rsLog = Conn.Execute(sql)
	%>
	<H1>Weblog Wijzigen</H1>
	<FORM METHOD=POST ACTION="actie.asp?actie=weblogwijzigen">
	<INPUT TYPE="hidden" value="<%=rsLog("id")%>" name="id">
	<table width=500>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button value='<%=rsLog("titel")%>' size="50"></td>
		</tr>
		<tr>
			<td valign=top>Bericht:</td>
			<td><TEXTAREA NAME="bericht" ROWS="20" COLS="60" class=button><%=rsLog("bericht")%></TEXTAREA></td>
		</tr>
		<tr>
			<td></td>
			<td><INPUT TYPE="submit" class=button value='Opslaan'></td>
		</tr>
	</table>
	</FORM>

	<%
	rsLog.Close 
	Set rsLog = Nothing 



elseif actie = "reacties" then
	w "<H1>Weblog Reacties</H1>"
	
	if id = "" then
		sql="SELECT top 6 * FROM reactie ORDER BY id desc"
		set rsReactie = Conn.Execute(sql)
	else
		sql="SELECT * FROM reactie WHERE log_id = " &id& " ORDER BY id desc"
		set rsReactie = Conn.Execute(sql)
	end if

	do while not rsReactie.EOF

		w "<a href=weblog.asp?actie=reactieswijzigen&id=" &rsReactie("id")& ">" &rsReactie("naam")& "</a> ("&rsReactie("ip")&")<br>"
		w rsReactie("datum")& " / " &rsReactie("tijd")& "<br>"
	
		sql2="SELECT * FROM log WHERE id = "&rsReactie("log_id")
		set rsLog = Conn.Execute(sql2)
			w "Gereageerd op bericht: (" &rsLog("id")& ") <a href='http://www.3l.nl/reactie.asp?id=" &rsLog("id")& "' target=_blank>" &rsLog("titel")& "</a><br>"
		rsLog.close
		set rsLog=nothing
	
		bericht = Replace(rsReactie("bericht"), "(", "&#40")
		bericht = Replace(bericht, ")", "&#41")
		bericht = Replace(bericht, ";", "&#59")
		bericht = Replace(bericht, "'", "&#39")
		bericht = Replace(bericht, "<", "[")
		bericht = Replace(bericht, ">", "]")
		bericht = Left(bericht, 80)
		w "(" &rsReactie("id")& ") " &bericht& "...<p>"
		
	rsReactie.MoveNext
	Loop
	rsReactie.close
	set rsReactie=nothing

elseif actie = "reactieswijzigen" then
	w "<H1>Weblog Reacties</H1>"
	sql="SELECT * FROM reactie WHERE id="&id
	set rsReactie = Conn.Execute(sql)

		response.write "<FORM METHOD=POST ACTION='actie.asp?actie=reactieaanpassen' name='formulier'>"
		response.write "<INPUT TYPE='hidden' name='id' VALUE='"&rsReactie("id")&"'>"
		response.write "Naam:<br><INPUT TYPE='text' NAME='naam' class=button value='" &rsReactie("naam")& "'><br>"
		response.write "E-mail:<br><INPUT TYPE='text' NAME='email' class=button value='" &rsReactie("email")& "'><br>"
		response.write "Bericht:<br><TEXTAREA NAME='bericht' ROWS=10 COLS=40 class=button>" &rsReactie("bericht")& "</TEXTAREA><br>"
		response.write "<INPUT TYPE='submit' class=button value='opslaan'>"
		response.write "</FORM>"
		response.write "<a href=actie.asp?actie=reactieverwijderen&id=" &rsReactie("id")& ">Verwijder deze entry</a>"

	rsReactie.close
	set rsReactie = nothing

elseif actie = "reactiespp" then

	sql = "SELECT * FROM reactie WHERE naam='" &id& "' ORDER BY id desc"
	set rsRpp = Conn.Execute(sql)
	w "<H1>Weblog Reacties van "&id&"</H1>"
	do while not rsRpp.EOF
	
		w "<a href=default.asp?actie=reactieaanpassen&id=" &rsRpp("id")& ">" &rsRpp("naam")& "</a><br>"
		w rsRpp("datum")& " / " &rsRpp("tijd")& "<br>"
	
		sql2="SELECT * FROM log WHERE id = "&rsRpp("log_id")
		set rsLog = Conn.Execute(sql2)
			w "Gereageerd op bericht: (" &rsLog("id")& ") <a href='http://www.3l.nl/reactie.asp?id=" &rsLog("id")& "' target=_blank>" &rsLog("titel")& "</a><br>"
		rsLog.close
		set rsLog=nothing
	
		bericht = Replace(rsRpp("bericht"), "(", "&#40")
		bericht = Replace(bericht, ")", "&#41")
		bericht = Replace(bericht, ";", "&#59")
		bericht = Replace(bericht, "'", "&#39")
		bericht = Replace(bericht, "<", "[")
		bericht = Replace(bericht, ">", "]")
		bericht = Left(bericht, 80)

		w "(" &rsRpp("id")& ") " &bericht& "...<p>"
		
	rsRpp.MoveNext
	Loop
	rsRpp.close
	set rsRpp=nothing


end if
%>
		
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->