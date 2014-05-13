<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<%
'AANTALLEN
sql1 = "SELECT count(*) as aantallogs FROM log"
set rsAantal = Conn.Execute(sql1)
	aantallogs = rsAantal("aantallogs")
rsAantal.Close
set rsAantal = nothing

sql2 = "SELECT count(*) as aantalreacties FROM reactie"
set rsReactie = Conn.Execute(sql2)
	aantalreacties = rsReactie("aantalreacties")
rsReactie.Close
set rsReactie = nothing%>

<H1>Aantallen</H1>
<table cellspacing=5>
<tr><td width=20>&nbsp</td><td width=150>Aantal logs:</td><td align=right width=100><%=aantallogs%></td></tr>
<tr><td width=20>&nbsp</td><td width=150>Aantal reacties:</td><td align=right width=100><%=aantalreacties%></td></tr>
</table>


<H1>Nieuw</H1>
<%
set fs=Server.CreateObject("Scripting.FileSystemObject")
set alles=fs.GetFolder("D:\www\3l.nl\")
set db=fs.GetFolder("D:\www\3l.nl\database\")
set fotolog=fs.GetFolder("D:\www\3l.nl\www\fotolog\")
set weblog=fs.GetFolder("D:\www\3l.nl\www\")
set portfolio=fs.GetFolder("D:\www\3l.nl\www\portfolio\")
set projecten=fs.GetFolder("D:\www\3l.nl\www\projecten\")
set cms=fs.GetFolder("D:\www\3l.nl\www\cms\")
%>

<table cellspacing=0 border=0 cellpadding=0 width="100%">
	<tr>
		<td width=20>&nbsp</td>
		<td width=50% valign=top>
			<p><a href=weblog.asp?actie=aanmaken>Nieuw Weblog</a></p>
			<p><a href=fotolog.asp?actie=aanmaken>Nieuw Fotolog</a></p>
			<p><a href=fotoalbum.asp?actie=aanmaken>Nieuw Fotoalbum</a></p></td>
		<td width=25%>
			Totale grootte:<br>
			Database:<br>
			Weblog:<br>
			Fotolog/fotoalbum:<br>
			Portfolio:<br>
			Projecten:<br>
			CMS:<br>
			</td>
		<td align=right width=100 width="50%">
			<b><%=FormatNumber((alles.Size / 1000),0)%> Kb</b><br>
			<%=FormatNumber((db.Size / 1000),0)%> Kb<br>
			<%=FormatNumber(((weblog.Size - fotolog.Size - portfolio.Size - projecten.Size - cms.Size) / 1000),0) %> Kb<br>
			<%=FormatNumber((fotolog.Size / 1000),0)%> Kb<br>
			<%=FormatNumber((portfolio.Size / 1000),0)%> Kb<br>
			<%=FormatNumber((projecten.Size / 1000),0)%> Kb<br>
			<%=FormatNumber((cms.Size / 1000),0)%> Kb<br>
			</td>
	</tr>
</table>

<%
set alles=nothing
set fs=nothing
%>

<H1>Overige Functies</H1>

<table cellspacing=5>
	<tr>
		<td width=20>&nbsp</td>
		<td><a href=overpompen.asp>Teller Database overpompen</a><br>
			<a href=stats.asp?CounterAction=referers>Teller database opruimen</a><br>
			<a href=geblaat.asp?actie=ipadrestoevoegen1>IP Adres Toevoegen</a><br>
			</td>
	</tr>
</table>


<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->