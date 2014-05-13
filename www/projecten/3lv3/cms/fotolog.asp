<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<!-- #include virtual="/projecten/3lv3/inc/adovbs.inc" -->

<%if actie = "" then
	orderby = request.querystring("orderby")
	if orderby = "" then
		orderby = "1desc"
	end if
	orderby = left(orderby,1) & " " & right(orderby, len(orderby)-1)%>
	<H1>Fotolog Aanpassen</H1>
	<table width="700" cellpadding=0 cellspacing=0 border=0>
	<tr height="30">
		<td width="50"><a href="weblog.asp?orderby=<%if request.querystring("orderby") = "1desc" then%>1asc<%else%>1desc<%end if%>">id</a></td>
		<td width="150"><a href="#">foto</a></td>
		<td width="250"><a href="weblog.asp?orderby=<%if request.querystring("orderby") = "2desc" then%>2asc<%else%>2desc<%end if%>">titel</a></td>
		<td width="250"></td>
	</tr>

	<%
	set rs=Server.CreateObject("ADODB.recordset") 
	sql="SELECT id, titel FROM fotolog ORDER BY "&orderby
	
	rs.CursorLocation = adUseClient
	rs.PageSize=11
	
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
		<tr>
			<td><%=rs("id")%></td>
			<td><a href=fotolog.asp?actie=wijzigen&id=<%=rs("id")%>><img src=http://www.3l.nl/fotolog/foto/<%=rs("id")%>.jpg width=40 height=30></a></td>
			<td><a href=fotolog.asp?actie=wijzigen&id=<%=rs("id")%>><%=rs("titel")%></a></td>
			<td align="right">
				<a href=fotolog.asp?actie=wijzigen&id=<%=rs("id")%>>Bewerk</a> | 
				<a href=fotolog.asp?actie=reacties&id=<%=rs("id")%>>Reacties</a> | 
				<a href=http://fotolog.3l.nl/fotolog/default.asp?id=<%=rs("id")%>>Lezen</a>
				</td>
		</tr>
		<%
		RS.MoveNext
		Loop
	rs.Close
	Set rs = Nothing
	
	response.write ("<tr><td colspan=""4"" align=""right""><br>")
	If huidige_pagina = 1 Then 
		response.write ("Vorige")
		response.write (" | ")
		response.write ("<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina + 1 & """>Volgende</a>")
	elseif huidige_pagina = aantal_paginas then
		response.write ( "<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina - 1 & """>Vorige</a>")
		response.write ( " | Volgende")
	else
		response.write ( "<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina - 1 & """>Vorige</a>")
		response.write ( " | <a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina + 1 & """>Volgende")
	End If%>

	</table>


<%elseif actie = "aanmaken" then
	'Maak de dir temp leeg, just in case
	dim fs1,fo1,x1
	Set fs1=Server.CreateObject("Scripting.FileSystemObject")
	'zoek bestandsnaam & verwijder het bestand
	set fo1=fs1.GetFolder("D:\www\3l.nl\temp\") 
	for each x1 in fo1.files
		fs1.DeleteFile(x1)
	next 
	set fo1=nothing
	set fs1=nothing
	%>
	<H1>Fotolog Aanmaken (stap 1)</H1>
	<FORM ACTION="fotolog.asp?actie=aanmaken1" METHOD="POST" ENCTYPE="multipart/form-data">
	Kies een bestand<p>
	<INPUT TYPE="FILE" NAME="Path" SIZE="40" class=button><br>
	<INPUT TYPE="SUBMIT" VALUE="Upload Image" class=button>
	</FORM>
	<%


elseif actie = "aanmaken1" then
	Set Upload = Server.CreateObject("Persits.Upload")
	Upload.OverwriteFiles = False
	Upload.SetMaxSize 1000000, true

	Count = Upload.Save(Server.MapPath("\") & "/../temp/")
	Set File = Upload.Files(1)

	set rsNieuw = Conn.Execute("SELECT top 1 id FROM fotolog ORDER BY id desc")
		naam=(rsNieuw("id")+1)
	rsNieuw.close
	set rsNieuw=nothing

	response.redirect ("thumbnail.asp?naam="&naam&"&path="&file.path)

elseif actie = "aanmaken2" then
	'DELETE TEMPORARY IMAGE FILE
	dim fs,fo,x
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	'zoek bestandsnaam & verwijder het bestand
	set fo=fs.GetFolder("D:\www\3l.nl\temp\") 
	for each x in fo.files
		fs.DeleteFile(x)
	next 
	set fo=nothing
	set fs=nothing
	%>
	
	<H1>Fotolog Aanmaken (stap 2)</H1>
	<FORM METHOD=POST ACTION="actie.asp?actie=fotologgen">
	<table width=500>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button size="50"></td>
		</tr>
		<tr>
			<td valign=top>Bericht:</td>
			<td><TEXTAREA NAME="bericht" ROWS="10" COLS="50" class=button></TEXTAREA></td>
		</tr>
		<tr>
			<td></td>
			<td><INPUT TYPE="submit" class=button value='Flits!'></td>
		</tr>
	</table>
	</FORM>
	<img src='http://www.3l.nl/fotolog/foto/<%=id%>.jpg'>
	<%


elseif actie = "wijzigen" then

	sql = "SELECT * FROM fotolog WHERE id = "&id
	set rsLog = Conn.Execute(sql)
	%>
	<H1>Fotolog Aanpassen</H1>
	<FORM METHOD=POST ACTION="actie.asp?actie=fotologaanpassen" name="formulier" onSubmit="return checkFields();">
	<INPUT TYPE="hidden" value="<%=rsLog("id")%>" name="id">
	<table width=500>
		<tr>
			<td>Foto:</td>
			<td><a href='http://www.3l.nl/fotolog/foto/<%=rsLog("id")%>.jpg'><img src='http://www.3l.nl/fotolog/foto/<%=rsLog("id")%>.jpg' width=80 height=60></a> (<%=rsLog("id")%>.jpg)</td>
		</tr>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button value='<%=rsLog("titel")%>' size="50"></td>
		</tr>
		<tr>
			<td valign=top>Bericht:</td>
			<td><TEXTAREA NAME="bericht" ROWS="10" COLS="50" class=button><%=rsLog("bericht")%></TEXTAREA></td>
		</tr>
		<tr>
			<td></td>
			<td><INPUT TYPE="submit" class=button value='Flits!'></td>
		</tr>
	</table>
	</FORM>

	<%
	rsLog.Close 
	Set rsLog = Nothing 


elseif actie = "reacties" then
	w "<H1>Fotolog Reacties</H1>"
	
	if id = "" then
		sql="SELECT top 7 * FROM fotoreactie ORDER BY id desc"
		set rsReactie = Conn.Execute(sql)
	else
		sql="SELECT * FROM fotoreactie WHERE foto_id = " &id& " ORDER BY id desc"
		set rsReactie = Conn.Execute(sql)
	end if

	do while not rsReactie.EOF

		w "<a href=fotolog.asp?actie=reactieswijzigen&id=" &rsReactie("id")& ">" &rsReactie("naam")& "</a><br>"
		w rsReactie("datum")& " / " &rsReactie("tijd")& "<br>"
	
		sql2="SELECT * FROM fotolog WHERE id = "&rsReactie("foto_id")
		set rsLog = Conn.Execute(sql2)
			w "Gereageerd op bericht: (" &rsLog("id")& ") <a href=http://fotolog.3l.nl/fotolog/default.asp?id=" &rsLog("id")& " target=_blank>" &rsLog("titel")& "</a><br>"
		rsLog.close
		set rsLog=nothing
	
		w "(" &rsReactie("id")& ") " &Left(rsReactie("bericht"), 80)& "...<p>"
		
	rsReactie.MoveNext
	Loop
	rsReactie.close
	set rsReactie=nothing


elseif actie = "reactieswijzigen" then
	w "<H1>Fotolog Reacties</H1>"
	sql="SELECT * FROM fotoreactie WHERE id="&id
	set rsReactie = Conn.Execute(sql)

		response.write "<FORM METHOD=POST ACTION='actie.asp?actie=fotoreactieaanpassen' name='formulier'>"
		response.write "<INPUT TYPE='hidden' name='id' VALUE='"&rsReactie("id")&"'>"
		response.write "Naam:<br><INPUT TYPE='text' NAME='naam' class=button value='" &rsReactie("naam")& "'><br>"
		response.write "E-mail:<br><INPUT TYPE='text' NAME='email' class=button value='" &rsReactie("email")& "'><br>"
		response.write "Bericht:<br><TEXTAREA NAME='bericht' ROWS=10 COLS=40 class=button>" &rsReactie("bericht")& "</TEXTAREA><br>"
		response.write "<INPUT TYPE='submit' class=button value='opslaan'>"
		response.write "</FORM>"
		response.write "<a href=actie.asp?actie=fotoreactieverwijderen&id=" &rsReactie("id")& ">Verwijder deze entry</a>"

	rsReactie.close
	set rsReactie = nothing

end if
%>
		
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->