<% option explicit %>
<!-- #include virtual="/projecten/3lv3/_top.asp" -->

<%
response.expires=0 
response.CacheControl="private"
%>

<H1>Reacties</H1>

<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">

<%
dim actie, id, rsLog, bericht, rsReactie, reactie

id = request("id")
actie = request("actie")

Set rsLog = Conn.Execute("SELECT * FROM log WHERE id =" &id)

	bericht = replace((rsLog.Fields.Item("bericht").Value), vbCRLF, "<BR>")
	bericht = Replace(bericht, ":D", "<img src=http://www.3l.nl/inc/smilies/biggrin.gif>")
	bericht = Replace(bericht, ":&#40", "<img src=http://www.3l.nl/inc/smilies/frown.gif>")
	bericht = Replace(bericht, ":&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	bericht = Replace(bericht, ":-&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	bericht = Replace(bericht, "&#59&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	bericht = Replace(bericht, "&#59-&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	bericht = Replace(bericht, ":P", "<img src=http://www.3l.nl/inc/smilies/tongue.gif>")

	w "<tr><td width='180' class='logtitel'>" &rsLog("titel")
	w "</td><td width='160' class='logdatum'>" &rsLog("datum")& "<br>" &rsLog("tijd")& "</td></tr>"
	w "<tr><td colspan='2' class='logbericht'>" &bericht& "</td></tr></table><br>"
	
	w "<center><img src='inc/ff6633.gif' width='300' height='1'></center>"
	w "<a name=""reacties""></a>"
	w "<H1>Reacties</H1><table width='340' border='0' cellspacing='0' cellpadding='0' align='center'>"

Set rsReactie = Conn.Execute("SELECT * FROM reactie WHERE log_id =" &id)
Do while not rsReactie.EOF
	
	reactie = replace((rsReactie.Fields.Item("bericht").Value), vbCRLF, "<BR>")
	reactie = Replace(reactie, ":D", "<img src=http://www.3l.nl/inc/smilies/biggrin.gif>")
	reactie = Replace(reactie, ":&#40", "<img src=http://www.3l.nl/inc/smilies/frown.gif>")
	reactie = Replace(reactie, ":&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	reactie = Replace(reactie, "&#59&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	reactie = Replace(reactie, ":-&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
	reactie = Replace(reactie, "&#59-&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
	reactie = Replace(reactie, ":P", "<img src=http://www.3l.nl/inc/smilies/tongue.gif>")

	w "<tr><td width='180' class='logtitel'><a href='mailto:" &rsReactie("email")& "'>" &rsReactie("naam")& "</a>"
	w "</td><td width='160' class='logdatum'>" &rsReactie("datum")& " om " &rsReactie("tijd")& "</td></tr>"
	w "<tr><td colspan='2' class='logbericht'>" &reactie& "<br>&nbsp</td></tr>"

rsReactie.MoveNext
Loop
rsReactie.Close 
Set rsReactie = Nothing 
%>

</table>

<center><img src='inc/ff6633.gif' width='300' height='1'></center>

<H1>Reageer ook!</H1>

<FORM METHOD=POST ACTION="actie.asp?actie=reactie" name="reactie" onSubmit="return checkFieldsReactie();">
<input type="hidden" value="<%=id%>" name="logid">
<table width=340 align='center' border='0' cellspacing='0' cellpadding='0'>	
	<tr>	
		<td width=100>Naam: </td>
		<td><INPUT TYPE="text" NAME="naam" class=button size='20' maxlength="25" value="<%=request.cookies("3Lnaam")%>"></td>
	</tr>
	<tr>
		<td>Email: </td>
		<td><INPUT TYPE="text" NAME="email" class=button size='20' maxlength="25" value="<%=request.cookies("3Lemail")%>"></td>
	</tr>
	<tr>
		<td valign=top>Bericht: </td>
		<td><TEXTAREA NAME="bericht" ROWS="7" COLS="40" class=button></TEXTAREA></td>
	</tr>
	<tr>
		<td></td>
		<td><INPUT TYPE="submit" class=button value='Reageren!'></FORM></td>
	</tr>
	<tr>
		<td colspan=2 align=right>
		<center><img src='inc/ff6633.gif' width='300' height='1'></center>
		<br><a href="weblog.asp">Terug naar de Logs</a>
	</tr>
</table>

<!-- #include virtual="/projecten/3lv3/_bottom.asp" -->