<%option explicit
dim conn%>
<!-- #include file="../../../inc/dbdriel.asp" -->

<HTML>
<HEAD>
<TITLE>Fotolog.3L.nl</TITLE>
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language=JavaScript>
window.defaultStatus = "Fotolog.3L.nl";
</SCRIPT>
</HEAD>
<BODY>


<%
Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

dim id
id = Request("id")

'lijst met alle fotoalbums
if id = "" then
	dim rsFa
	w "<table width=100% border=0 cellpadding=0 cellspacing=0 align=center>"
	w "<tr><td></td><td><B>Naam</B></td><td align=right><B>Datum</B></td><td align=right><B>Aantal</B></td><td width=30>&nbsp</td></tr>"
	'<td align=right><B>Grootte</B></td></tr>
	set rsFa = Conn.Execute("SELECT * FROM fotoalbum ORDER BY id desc")
	do while not rsFa.EOF
	%>
		
			<tr><td height=70 valign=top width=100>
				<a href='fotoalbum.asp?actie=album&id=<%=rsFa("id")%>' target=_parent>
				<img src='http://www.3l.nl/fotoalbum/<%=rsFa("id")%>/thumbs/<%=rsFa("preview")%>.jpg' width=80 height=60></a></td>
			<td width=300>
				<a href='fotoalbum.asp?actie=album&id=<%=rsFa("id")%>' target=_parent>
				<%=rsFa("titel")%></a></td>
			<td align=right width=150><%=rsFa("datum")%></td>
			<td align=right width=60><%=rsFa("aantal")%></td>
			<td> </td>
<!--		<td align=right width=70>
				<%'set fs=Server.CreateObject("Scripting.FileSystemObject")
				'set fo=fs.GetFolder("D:\www\3l.nl\www\fotolog\foto\"&rsFa("id"))
				'	sizekb = Cint(fo.Size / 1000)
				'	w "(" &sizekb& " Kb)"
				'set fo=nothing
				'set fs=nothing%></td>-->
			</tr>

	<%
	rsFa.MoveNext
	loop
	rsFa.close
	set rsFa=nothing
	w "</table>"


'lijst met alle foto's in een album
else
	dim rsFa2, i
	set rsFa2 = Conn.Execute("SELECT * FROM fotoalbum WHERE id="&id)
	w "<table width=400 border=0 cellpadding=0 cellspacing=0 align=center><tr>"

		for i = 1 to rsFa2("aantal")
		If (i MOD 4 = 0 ) Then
			w "<td width=100 align=center valign=top height=70><a href='fotoalbum.asp?actie=albumfoto&album=" &id& "&id=" &i& "' target=_parent>"
			w "<img src='http://www.3l.nl/fotoalbum/"&id&"/thumbs/"&i&".jpg' height=50 alt='" &rsFa2("titel")& " - " &i& ".jpg'>"
			w "</a></td></tr><tr>"
		else
			w "<td width=100 align=center valign=top height=70><a href='fotoalbum.asp?actie=albumfoto&album=" &id& "&id=" &i& "' target=_parent>"
			w "<img src='http://www.3l.nl/fotoalbum/"&id&"/thumbs/"&i&".jpg' height=50 alt='" &rsFa2("titel")& " - " &i& ".jpg'>"
			w "</a></td>"
		end if

		next
	w "</tr></table>"
	rsFa2.Close
	set rsFa2=nothing

end if
%>
</body>
</HTML>