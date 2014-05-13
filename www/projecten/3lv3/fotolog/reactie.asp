<%option explicit%>
<!-- #include file="../../../inc/db/driel.asp" -->

<HTML>
<HEAD>
<TITLE>Fotolog.3L.nl</TITLE>
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
</HEAD>
<BODY>

<table width=380 cellpadding=0 cellspacing=0 align=center>
	<tr>
		<td bgcolor='#cccccc' height=2></td>
	</tr>
	<tr>
		<td align=center><img src="inc/reacties.gif"></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2></td>
	</tr>
	<tr>
		<td height=20></td>
	</tr>
	<tr>
		<td align=center>


<table width=380 cellpadding=0 cellspacing=0 align=center>
<%
dim id, rsReactie, bericht
id = request("id")
set rsReactie = Conn.Execute("SELECT * FROM fotoreactie WHERE foto_id="&id)
do while not rsReactie.EOF

bericht = replace((rsReactie.Fields.Item("bericht").Value), vbCRLF, "<BR>")
%>

<tr>
	<td><b><a href='mailto:<%=rsReactie("email")%>'><%=rsReactie("naam")%></a></b></td>
	<td align=right><i><%=rsReactie("datum")%> om <%=rsReactie("tijd")%></i></td>
</tr>
<tr>
	<td colspan=2><%=bericht%></td>
</tr>
<tr>
	<td colspan=2 height=10 valign=center><hr></td>
</tr>

<%
rsReactie.MoveNext
loop
rsReactie.Close
set rsReactie=nothing
%>

</table>

		</td>
	</tr>
	<tr>
		<td height=20></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2></td>
	</tr>
	<tr>
		<td height=20></td>
	</tr>
	<tr>
		<td>

<H1>Reageer ook!</H1>

<FORM METHOD=POST ACTION="actie.asp?actie=reactie" name="reactie" onSubmit="return checkFieldsReactie();">
<input type="hidden" value="<%=id%>" name="fotoid">
<table width=340 align='center' border='0' cellspacing='0' cellpadding='0'>	
	<tr>	
		<td width=100>Naam: </td>
		<td><INPUT TYPE="text" NAME="naam" class=button size='20' maxlength="25" value="<%=request.cookies("Fotonaam")%>"></td>
	</tr>
	<tr>
		<td>Email: </td>
		<td><INPUT TYPE="text" NAME="email" class=button size='20' maxlength="25" value="<%=request.cookies("Fotoemail")%>"></td>
	</tr>
	<tr>
		<td valign=top>Bericht: </td>
		<td><TEXTAREA NAME="bericht" ROWS="7" COLS="40" class=button></TEXTAREA></td>
	</tr>
	<tr>
		<td></td>
		<td><INPUT TYPE="submit" class=button value='Flits!'></FORM></td>
	</tr>
</table>

		</td>
	</tr>
	<tr>
		<td height=20></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2></td>
	</tr>
	<tr>
		<td align=right><a href="#" onClick="window.close()">Terug naar het log</a></td>
	</tr>
</table>

</body>
</HTML>