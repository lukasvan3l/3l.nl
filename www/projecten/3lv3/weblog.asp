<% option explicit %>
<!-- #include virtual="/projecten/3lv3/_top.asp" -->
<!-- #include virtual="/projecten/3lv3/inc/adovbs.inc" -->
<%
Response.Expires=0 '0 is het aantal minuten dat de pagina in de cache wordt opgeslagen 
response.CacheControl="private" 'private geeft aan dat je pagina niet door proxy servers gecached wordt.
%>

<H1>Weblog</H1>

<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">

<%
dim rsLog, bericht, rsLog2, reactietxt, sql, huidige_pagina, aantal_paginas

	set rsLog=Server.CreateObject("ADODB.recordset") 
	sql="SELECT * FROM log WHERE datum < FORMAT('01-12-2003','dd-mm-yyyy') ORDER BY datum desc"
	
	rsLog.CursorLocation = adUseClient
	rsLog.PageSize=10
	
	rsLog.Open sql,conn 
	
	if request.querystring("pagina") = "" then 
		huidige_pagina = 1 
		else 
		huidige_pagina = Cint(request.querystring("pagina")) 
	end if 
	
	aantal_paginas = rsLog.PageCount 
	 
	If 1 > huidige_pagina Then huidige_pagina = 1 
	If huidige_pagina > aantal_paginas Then huidige_pagina = aantal_paginas 
	 
	rsLog.AbsolutePage = huidige_pagina
	
	Do While rsLog.AbsolutePage = huidige_pagina AND Not rsLog.EOF
		

'Set rsLog = Conn.Execute("SELECT top 10 * FROM log ORDER BY datum desc, tijd desc")
'Do until rsLog.EOF

	bericht = replace((rsLog.Fields.Item("bericht").Value), vbCRLF, "<BR>")
	bericht = Replace(bericht, "<img src=", "<img width=340 src=")
	bericht = Replace(bericht, ":D", "<img src=http://www.3l.nl/inc/smilies/biggrin.gif>")
	bericht = Replace(bericht, ":&#40", "<img src=http://www.3l.nl/inc/smilies/frown.gif>")
	bericht = Replace(bericht, ":&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	bericht = Replace(bericht, ":-&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	bericht = Replace(bericht, "&#59&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	bericht = Replace(bericht, "&#59-&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	bericht = Replace(bericht, ":P", "<img src=http://www.3l.nl/inc/smilies/tongue.gif>")

	w "<tr><td width='180' class='logtitel'>" &rsLog("titel")
	w "</td><td width='160' class='logdatum'>" &rsLog("datum")& "</td></tr>"
	w "<tr><td colspan='2' class='logbericht'>" &bericht& "</td></tr>"
	w "<tr><td colspan='2' class='logreageren'><a href=""reactie.asp?id=" &rsLog("id")& "#reacties"" style='reageren' title='Reageer op deze log!'>"
		
	Set rsLog2= Conn.Execute("SELECT count(*) as aantal_reacties FROM reactie where log_id="&rsLog("id"))
		
		if rsLog2("aantal_reacties") = 0 then
			reactietxt = "Reageer als eerste!"
		elseif rsLog2("aantal_reacties") = 1 then
			reactietxt = "Reeds &eacute;&eacute;n reactie, reageer ook!"
		else
			reactietxt = rsLog2("aantal_reacties")& " reacties, reageer je mee?"
		end	if

	w reactietxt& "</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>"

	rsLog2.Close 
	Set rsLog2 = Nothing 

RSLog.MoveNext 
Loop 
rsLog.Close 
Set rsLog = Nothing%>

<tr align="right"><td colspan="2">
<%If huidige_pagina = 1 Then 
	response.write ("Vorige 10")
	response.write (" | ")
	response.write ("<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina + 1 & """>Volgende 10</a>")
elseif huidige_pagina = aantal_paginas then
	response.write ( "<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina - 1 & """>Vorige 10</a>")
	response.write ( " | Volgende")
else
	response.write ( "<a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina - 1 & """>Vorige 10</a>")
	response.write ( " | <a href=""" & request.servervariables("SCRIPT_NAME") & "?pagina=" & huidige_pagina + 1 & """>Volgende 10")
End If%>
</td></tr>

</table>

<!-- #include virtual="/projecten/3lv3/_bottom.asp" -->