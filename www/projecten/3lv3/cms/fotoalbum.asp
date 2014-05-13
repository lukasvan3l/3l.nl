<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->

<%if actie = "" then
	set rsFa = Conn.Execute("SELECT * FROM fotoalbum ORDER BY id desc")%>
	<H1>Fotoalbum Aanpassen</H1>
	<table cellspacing="5" cellpadding="0" border="0" width="700">
	<tr>
		<td width="50"><strong>ID</strong></td>
		<td width="150"><strong>Foto</strong></td>
		<td width="250"><strong>Naam</strong></td>
		<td width="100"><strong>Aantal</strong></td>
		<td width="150"><strong></strong></td>
	</tr>
	<% Do until rsFa.EOF %>
	<tr>
		<td>(<%=rsFa("id")%>)
		<td><a href="fotoalbum.asp?actie=wijzigen&id=<%=rsFa("id")%>">
			<img src=http://home.planet.nl/~vdriel/fotoalbum/<%=rsFa("id")%>t/<%=rsFa("preview")%>.jpg width=40 height=30></a></td>
		<td><a href="fotoalbum.asp?actie=wijzigen&id=<%=rsFa("id")%>"><%=rsFa("titel")%></a><br></td>
		<td><%=rsFa("aantal")%></td>
		<td><a href="fotoalbum.asp?actie=wijzigen&id=<%=rsFa("id")%>">bewerk</a> | 
			<a href="http://fotoalbum.3l.nl/fotolog/fotoalbum.asp?actie=album&id=<%=rsFa("id")%>" target="_blank">lezen</a>
			</td>
	</tr>

<%
'		folder grootte toevoegen mocht hij bij 3l.nl gehost zijn
'		set fs=Server.CreateObject("Scripting.FileSystemObject")
'		set fo=fs.GetFolder("D:\www\3l.nl\www\fotoalbum\"&rsFa("id"))
'			sizekb = Cint(fo.Size / 1000)
'			w "&nbsp&nbsp&nbsp&nbsp" &sizekb& " Kb"
'		set fo=nothing
'		set fs=nothing
		
		rsFa.MoveNext
		Loop
	rsFa.Close
	Set rsFa = Nothing%>

	</table>
<%
elseif actie = "aanmaken" then
	%>
	<H1>Fotoalbum Aanmaken</H1>
	<FORM METHOD=POST ACTION="actie.asp?actie=albumtoevoegen">
	<table width=500>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button size="50"></td>
		</tr>
		<tr>
			<td>Aantal:</td>
			<td><INPUT TYPE="text" NAME="aantal" class=button size="5"></td>
		</tr>
			<tr>
			<td>Preview:</td>
			<td><INPUT TYPE="text" NAME="preview" class=button size="5"></td>
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
	<%



elseif actie = "wijzigen" then
	sql = "SELECT * FROM fotoalbum WHERE id = "&id
	set rsFa = Conn.Execute(sql)
	%>

	<FORM METHOD=POST ACTION="actie.asp?actie=albumaanpassen">
	<INPUT TYPE="hidden" value="<%=rsFa("id")%>" name="id">
	<table width=500>
		<tr>
			<td>Foto:</td>
			<td><a href='http://home.planet.nl/~vdriel/fotoalbum/<%=rsFa("id")%>/<%=rsFa("preview")%>.jpg'><img src='http://home.planet.nl/~vdriel/fotoalbum/<%=rsFa("id")%>/<%=rsFa("preview")%>.jpg' width=80 height=60></a> (<%=rsFa("id")%>/<%=rsFa("preview")%>.jpg)</td>
		</tr>
		<tr>
			<td>Titel:</td>
			<td><INPUT TYPE="text" NAME="titel" class=button value='<%=rsFa("titel")%>' size="50"></td>
		</tr>
		<tr>
			<td>Aantal:</td>
			<td><INPUT TYPE="text" NAME="aantal" class=button size="5" value='<%=rsFa("aantal")%>'></td>
		</tr>
			<tr>
			<td>Preview:</td>
			<td><INPUT TYPE="text" NAME="preview" class=button size="5" value='<%=rsFa("preview")%>'></td>
		</tr>
		<tr>
			<td valign=top>Bericht:</td>
			<td><TEXTAREA NAME="bericht" ROWS="10" COLS="50" class=button><%=rsFa("bericht")%></TEXTAREA></td>
		</tr>
		<tr>
			<td></td>
			<td><INPUT TYPE="submit" class=button value='Flits!'>
				<img src=inc/blank.gif height=1 width=180>
				<a href='actie.asp?actie=albumverwijderen&id=<%=rsFa("id")%>'>
				<img src=inc/prullenbak.gif> Verwijderen</a>
				</td>
		</tr>
	</table>
	</FORM>

	<%
	rsFa.Close 
	Set rsFa = Nothing 



end if
%>
		
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->