<%option explicit%>
<!-- #include file="_top.asp" -->
<!-- #include file="inc/DanDate.inc" -->
<%
Dim CounterFile, Telregels, AantalBezoekers, CounterAction
Dim CounterSQL, CounterRs, CounterHits, RequestPagina, ListSQL, ListRs
Dim RequestDatum, WebsitePassword, WebsiteRoot, WebsiteName, BezoekerKleur
Dim VorigeBrowser, TotaalBrowserType, MinSecurityLevel, rsIpadres
Dim GemBezoek, PixelsPerBezoeker, PixelsPerPaginaBezoek


' Deze pagina niet in de cache bewaren
Response.Expires = 0

' Vul hier in wat de root van de website is (dit is bv.: "http://www.uwdomein.nl" )
WebsiteRoot = "http://www.3l.nl"

' Pixels per bezoeker voor bezoekers grafiek
PixelsPerBezoeker = 5

' Pixels per bezoeker voor paginabezoek grafiek
PixelsPerPaginaBezoek=0.05

' GetStatus/Update vanuit formulier
CounterAction = request("CounterAction")
%>
<!-- #include file="../datateller.asp" -->
<%
CounterSQL = "SELECT * FROM TblTel"
Set CounterRs = CounterDataConn.Execute(CounterSQL)
If CounterRs.EOF then
	response.write "<P><b>De Teller is leeg!</b></P>"
end if

%>
<H1>Statistieken vanaf 21-6-2003</H1>

<table border="0" width="80%" align=center>
  <tr>
    <td valign=top>
		<a href="stats.asp?CounterAction=Bezoekersoverzicht">Bezoekersoverzicht</a><br>
		<a href="stats.asp?CounterAction=Paginaoverzicht">Paginaoverzicht</a><br>
		<a href="stats.asp?CounterAction=Verwijzingoverzicht">Verwijzingen overzicht</a><br>
		<a href="stats.asp?CounterAction=Google">Verwijzingen Zoekmachines</a><br>
		<a href="stats.asp?CounterAction=Ipadres">Grafiek per IP-adres</a><br>
		<a href="stats.asp?CounterAction=BezoekersGrafiek">Grafiek bezoekers per dag</a><br>
		<a href="stats.asp?CounterAction=PaginaBezoek">Overzicht Paginabezoek</a></td>
	<td align=right valign=top>
		<%=Date()%>&nbsp;&nbsp;<%=Time()%><br>
		Er zijn op dit moment <b><%=Application("Active")%></b> bezoeker(s) op de site<br>
			<%
			' *******
			' Aantal bezoekers
			' *******
			CounterSQL = "SELECT Count(qryAantalBezoekenPerBezoeker.CountOfID) AS Aantal FROM qryAantalBezoekenPerBezoeker"
			Set CounterRs = CounterDataConn.Execute(CounterSQL)
			%>
		Er zijn <b><%=CounterRs("Aantal")%></b> bezoekers langsgeweest<br>
			<%
			Set CounterRs = Nothing
			' *******
			' Gemiddeld per dag
			' *******
			CounterSQL = "SELECT Avg(QryAantalBezoekersPerDag.Totaal) AS Gemiddeld FROM QryAantalBezoekersPerDag"
			Set CounterRs = CounterDataConn.Execute(CounterSQL)
			%>
		Gemiddeld zijn er <b><%=FormatNumber(CounterRs("Gemiddeld"),2) %></b> bezoekers per dag<br>
			<%
			Set CounterRs = Nothing
			' *******
			' aantal unieke ip-adressen
			' *******
			CounterSQL = "SELECT count(*) as aantalip FROM qryDistinctIP"
			set CounterRS = CounterDataConn.Execute(CounterSQL)
			%>
		Er zijn <b><%=CounterRS("aantalip")%></b> unieke ip-adressen langsgeweest<br>
    </td>
  </tr>
</table>
<%
CounterSQL = "SELECT * FROM TblTel"


' **********
'  Bezoekersoverzicht
' **********

if CounterAction="Bezoekersoverzicht" then
 RequestDatum = trim(Request.form("Datum"))

 if RequestDatum = "" AND Request.form("wie")="" then
 	RequestDatum = date()
 end if

	if trim(Request.form("Wie")) <> "" then
		CounterSQL = CounterSQL & " WHERE tblTel.REMOTE_HOST ='" & request.form("Wie") & "'"
	else
		CounterSQL = CounterSQL & " WHERE TblTel.Datum = #" & DanDate(RequestDatum,"%m-%d-%Y") & "#"
	end if

	CounterSQL = CounterSQL & " ORDER BY TblTel.Datum DESC , TblTel.Tijd DESC"
	Set CounterRs = CounterDataConn.Execute(CounterSQL)

	' HTML code van de totaal geteld actie
%>
<h1>Bezoekersoverzicht</h1>
<table>
<tr>
<%
' Keuzelijst voor een datum

	ListSQL= "SELECT DISTINCT TblTel.Datum FROM TblTel"
	Set ListRs = CounterDataConn.Execute(ListSQL)

%>
	<form method="POST" action="stats.asp" name="bezoekersoverzichtform">
	<input type="hidden" Name="CounterAction" Value="Bezoekersoverzicht">
	<td width="143" valign="bottom" align="left">Toon van datum:</td>
	<td valign="bottom" align="left">
		<select name="Datum" size="1" class=button onChange="document.bezoekersoverzichtform.submit()">
			<% While not ListRs.EOF %>
  			<option <%
				if DanDate(ListRs("Datum"),"%m-%d-%Y") = DanDate(RequestDatum,"%m-%d-%Y") then %>
					Selected
				<% End if %>
  				value="<%=ListRs("Datum")%>">
  				<%=ListRs("Datum")%>
  			</option>
  			<%
  			ListRs.Movenext
  			Wend
  			%>
		</select>
	</td>
	</form>
<%
	if RequestDatum <> "" then

' Keuzelijst voor de bezoekers van die dag

AantalBezoekers = 0

		ListSQL= "SELECT DISTINCT REMOTE_ADDR FROM TblTel WHERE TblTel.Datum=#" & DanDate(RequestDatum,"%m-%d-%Y")& "#"
		Set ListRs = CounterDataConn.Execute(ListSQL)
%>
		<form method="POST" action="stats.asp" name="blaatform">
		<input type="hidden" Name="CounterAction" Value="Bezoekersoverzicht">

		<td valign="bottom" align="left">Bezoekers van vandaag:</td>
		<td valign="bottom" align="left">
			<select name="Wie" size="1" class=button onChange="document.blaatform.submit()">
				<% While not ListRs.EOF %>
  				<option value="<%=ListRs("REMOTE_ADDR")%>">
				<%=ListRs("REMOTE_ADDR")%>
				</option>
  				<%
  					AantalBezoekers = AantalBezoekers + 1
					ListRs.Movenext
				Wend
				%>
			</select>
		</td>
		</form>
	</tr>


<%	end if %>
	<tr>
		<td colspan="9">
          <p align="center">Vandaag zijn er <b><%=AantalBezoekers%></b> bezoekers langsgeweest.</p>
        </td>
	</tr>
</table>
<!-- ************ -->                    <hr>                <!-- *************** -->
<%
if CounterRS.EOF then
%>
<p>Nog niets geteld...</p>
<%
	else
%>
<table cellspacing="0" cellpadding="0">
<tr>
	<td width="100" height="18"><b>Datum/Tijd</b></td>
	<td height="18"><b>&nbsp;&nbsp;Ip Adres</b></td>
	<td height="18"><b>&nbsp;&nbsp;Pagina</b></td>
	<td height="18"><b>&nbsp;&nbsp;Kwam van</b></td>
</tr>
<%
	telregels=0
	' bgcolor="#00FFFF"
	while not CounterRs.EOF
		telregels=telregels+1
		BezoekerKleur = left(hex(right(replace(CounterRs("REMOTE_ADDR"),".",""),8)),6)
%>
<tr>
	<td bgcolor="#<%=BezoekerKleur %>">
        <%=CounterRs("Datum")%><br>
		&nbsp&nbsp<%=CounterRs("Tijd")%>
	</td>
	<td valign=top>
        &nbsp;&nbsp;<%
		set rsIpadres = conn.execute("SELECT TOP 1 naam FROM reactie WHERE ip='"&CounterRs("REMOTE_ADDR")&"' ORDER BY id desc")
		if rsIpadres.EOF = true then
			response.write CounterRs("REMOTE_ADDR")
		else
			response.write "<a href='"&CounterRs("REMOTE_ADDR")&"'>"&rsIpadres("naam")&"</a>"
		end if
		rsIpadres.close
		set rsIpadres = nothing%>
	</td>
	<td valign=top>
        &nbsp;&nbsp;<%=CounterRs("PATH_INFO")%>&nbsp;&nbsp;
	</td>
	<td valign=top>
        &nbsp;&nbsp;<A HREF="<%=CounterRs("HTTP_REFERER")%>" target="_blank"><%=left(CounterRs("HTTP_REFERER"),40)%></A>&nbsp;&nbsp;
	</td>

</tr>
<%
		CounterRs.MoveNext
	Wend
%>
</table>
<%
 	Set CounterRs = nothing
 	end if
end if

' **********
'  Paginaoverzicht
' **********

if CounterAction="Paginaoverzicht" then
	RequestPagina = Request.form("Pagina")
	if RequestPagina <> "" then
		CounterSQL = CounterSQL & " WHERE tblTel.PATH_INFO ="  & RequestPagina
	else
		CounterSQL = CounterSQL & " WHERE tblTel.PATH_INFO = 1"
	end if
	CounterSQL = CounterSQL & " AND REMOTE_ADDR<>'80.61.68.211' ORDER BY TblTel.Datum DESC , TblTel.Tijd DESC"

	Set CounterRs = CounterDataConn.Execute(CounterSQL)
%>
<h1>Pagina overzicht</h1>
<table>
<tr>
<%
' Keuzelijst voor een pagina

	ListSQL= "SELECT PATH_INFO, id FROM path_info"
	Set ListRs = CounterDataConn.Execute(ListSQL)
%>
	<form method="POST" name="paginaoverzichtform" action="stats.asp">
	<input type="hidden" Name="CounterAction" Value="Paginaoverzicht">
	<td width="143" valign="bottom" align="left">Toon van pagina:</td>
	<td valign="bottom" align="left">
		<select name="Pagina" size="1" class=button onChange="document.paginaoverzichtform.submit()">
			<option selected>&nbsp</option>
			<% While not ListRs.EOF %>
  			<option <%
				if ListRs("PATH_INFO") = RequestPagina  then %>
					Selected
				<% End if %>
  			value="<%=ListRs("id")%>">
  				<%=ListRs("PATH_INFO")%>
  			</option>
  			<%
  				ListRs.Movenext
  			Wend
  			%>
		</select>
	</td>
	</form>
</table>
<%
	if CounterRS.EOF then
%>
<p>Nog niets geteld...</p>
<%
	else
%>
<p>
<table cellspacing="0" cellpadding="0">
<tr>
	<td><b>&nbsp;&nbsp;Datum en Tijd</b></td>
	<td><b>&nbsp;&nbsp;Ip Adres</b></td>
	<td><b>&nbsp;&nbsp;Kwam van</b></td>
</tr>
<%
		telregels = 0
		while not CounterRs.EOF
		telregels = telregels +1
%>
<tr>
	<td>
        &nbsp;&nbsp;<%=CounterRs("Datum")%> om <%=CounterRs("Tijd")%>&nbsp;&nbsp;
	</td>

	<td>
        &nbsp;&nbsp;<%
		set rsIpadres = conn.execute("SELECT TOP 1 naam FROM reactie WHERE ip='"&CounterRs("REMOTE_ADDR")&"' ORDER BY id desc")
		if rsIpadres.EOF = true then
			response.write CounterRs("REMOTE_ADDR")
		else
			response.write "<a href='"&CounterRs("REMOTE_ADDR")&"'>"&rsIpadres("naam")&"</a>"
		end if
		rsIpadres.close
		set rsIpadres = nothing%>
	</td>
	<td>
        &nbsp;&nbsp;<A HREF="<%=CounterRs("HTTP_REFERER")%>" target="_blank"><%=left(CounterRs("HTTP_REFERER"),50)%></A>&nbsp;&nbsp;
	</td>

</tr>
<%
			CounterRs.MoveNext
		Wend
%>
<tr>
	<td>
        <br><b>Totaal:</b>
	</td>
	<td colspan=3>
        <br><b><%=Telregels%></b>
	</td>
</tr>
</table>
<%
 		Set CounterRs = nothing
	end if
end if

' **********
'  Verwijzing overzicht
' **********

if CounterAction="Verwijzingoverzicht" then
	CounterSQL = "SELECT * FROM qryVerwijzingen WHERE left(qryVerwijzingen.Verwijzing,16)<>'http://www.3l.nl' AND left(qryVerwijzingen.Verwijzing,20)<>'http://fotolog.3l.nl' AND left(qryVerwijzingen.Verwijzing,12)<>'http://3l.nl' AND left(qryVerwijzingen.Verwijzing,22)<>'http://fotoalbum.3l.nl' AND left(qryVerwijzingen.Verwijzing,18)<>'http://lukas.3l.nl' AND left(qryVerwijzingen.Verwijzing,19)<>'http://weblog.3l.nl' AND left(qryVerwijzingen.Verwijzing,22)<>'http://portfolio.3l.nl'"
	Set CounterRs = CounterDataConn.Execute(CounterSQL)
%>
<h1>Verwijzingen overzicht</h1>
<table>
<tr>
<%
	if CounterRS.EOF then
%>
<td><p>Nog niets geteld...</p></td></tr></table>
<%
	else
%>
<p>
<table>
<tr>
	<td><b>&nbsp;&nbsp;Verwijzing</b></td>
	<td><b>&nbsp;&nbsp;Aantal keer doorverwezen door deze verwijzing</b></td>
</tr>
<%
		Telregels = 0
		while not CounterRs.EOF
			Telregels= telregels +1
%>
<tr>
	<td>
		&nbsp;&nbsp;<A HREF="<%=CounterRs("Verwijzing")%>" target="_blank"><%=CounterRs("Verwijzing")%></A>&nbsp;&nbsp;
	</td>
	<td>
		&nbsp;&nbsp;<%=CounterRs("CountOfID")%>&nbsp;&nbsp;
	</td>
</tr>
<%
			CounterRs.MoveNext
		Wend
%>
<tr>
	<td>
        &nbsp<br><b>Totaal:</b>
	</td>
	<td valign=bottom>
        <b>
		<%=Telregels%> verwijzende pagina's
        </b>
	</td>
</tr>
</table>
<%
		Set CounterRs = nothing
	end if
end if

' **********
'  PaginaBezoek
' **********

if CounterAction="PaginaBezoek" then

CounterSQL = "SELECT TblTel.PATH_INFO, Count(TblTel.ID) AS Aantal FROM TblTel "
CounterSQL = CounterSQL & " GROUP BY TblTel.PATH_INFO "
CounterSQL = CounterSQL & " ORDER BY Count(TblTel.ID) DESC "

	Set CounterRs = CounterDataConn.Execute(CounterSQL)
%>
<h1>Paginabezoek overzicht</h1>
<table>
<tr>
<%
	if CounterRS.EOF then
%>
<p>Nog niets geteld...</p>
<%
	else
%>
<p>
<table>
<tr>
	<td><b>&nbsp;&nbsp;Pagina</b></td>
	<td colspan="2"><b>&nbsp;&nbsp;Aantal keer geladen&nbsp;&nbsp;</b></td>
</tr>
<%
		Telregels = 0
		while not CounterRs.EOF
			Telregels= telregels +1
%>
<tr>
	<td nowrap>
		&nbsp;&nbsp;<A HREF="<%=CounterRs("PATH_INFO")%>" target="_blank"><%=CounterRs("PATH_INFO")%></A>&nbsp;&nbsp;
	</td>
	<td align="center">
		<%=CounterRs("Aantal")%>
	</td>
	<td>
		<img src="inc/blauw.gif" width="<%=CounterRs("Aantal")*PixelsPerPaginaBezoek%>" height="10">
	</td>

</tr>
<%
			CounterRs.MoveNext
		Wend
%>
<tr>
	<td>
        <b>
		Totaal:</b>
	</td>
	<td>
        <b>
		<%=Telregels%> pagina's
        </b>
	</td>
</tr>
</table>
<%
		Set CounterRs = nothing
	end if
end if

if CounterAction="Google" then%>
	<h1>Zoekterm waarmee 3L.nl gevonden is</h1>
	<table>
	<%	Set CounterRs = CounterDataConn.Execute("SELECT http_referer, datum FROM tbltel WHERE http_referer LIKE '%.google.%' OR http_referer like '%search.msn.%' OR http_referer like '%.altavista.com%' OR http_referer like '%search.yahoo.com%' GROUP BY http_referer, datum ORDER BY 2 desc")
		do while not CounterRS.EOF
		
		dim link, q, en, total
		link = CounterRs("http_referer")
		
		if instr(link, "search.yahoo.com") then
			q = InStr(link, "p=")+1
		else
			q = InStr(link, "q=")+1
		end if
	
		total = Len(link)
		link = right(link, total-q)
		en = Instr(link, "&")
		if en = 0 then
			en = len(link)
		end if
		link = left(link, en)
	
		link = Replace(link, "+", " ")
		link = Replace(link, "%27", "'")
		link = Replace(link, "&", "")
		link = Replace(link, "%22", "")
		link = Replace(link, "%2B", " ")
		link = Replace(link, "%28", "(")
		link = Replace(link, "%29", ")")
		link = Replace(link, "%2C", ",")
		link = Replace(link, "%2D", "-")
		link = Replace(link, "%5C", "\")
		link = Replace(link, "%3A", ":")
	
		link = trim(link)
	
		'deze laat hij niet zien:
		if left(CounterRs("http_referer"), 29) = "http://www.google.com/custom?" then
			link = ""
		elseif left(CounterRs("http_referer"), 26) = "http://www.google.com/url?" then
			link = ""
		elseif CounterRs("http_referer") = "http://www.google.nl " then
			link = ""
		elseif left(CounterRs("http_referer"), 34) = "http://search.yahoo.com/search?va=" then
		'deze wel
		else
			%>
			<tr>
				<td>
					&nbsp;&nbsp;<A HREF="<%=CounterRs("http_referer")%>" target="_blank"><%=link%></A>&nbsp;&nbsp;
				</td>
			</tr>
			
			<%
		end if
		CounterRS.MoveNext
		loop
		CounterRS.close
		Set CounterRs = nothing
	response.write("</table>")
end if

'*************************************************************************************************************
if CounterAction="Ipadres" then
	
end if
'*************************************************************************************************************



' **********
'  Bezoekersgrafiek
' **********

if CounterAction="BezoekersGrafiek" then
	CounterSQL = "SELECT * FROM qryAantalBezoekersPerDag  ORDER BY Datum DESC"
	Set CounterRs = CounterDataConn.Execute(CounterSQL)

' SELECT Avg(QryAantalBezoekersPerDag.Totaal) AS Gemiddeld
' FROM QryAantalBezoekersPerDag;


%>
<h1>Grafiek Bezoekers per Dag</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td>Datum</td>
		<td>#</td>
		<td>&nbsp;</td>
	</tr>
<%
	if CounterRs.eof then
		response.write "<tr><td>Geen bezoekers langsgeweest</td></tr>"
	else
		while not  CounterRs.EOF %>
	<tr>
		<td><%=CounterRs("Datum")%>&nbsp;&nbsp;</td>
		<td><%=CounterRs("Totaal")%>&nbsp;&nbsp;</td>
<%
if GemBezoek > CounterRs("Totaal") then
%>
		<td><img src="inc/rood.gif" width="<%=CounterRs("Totaal")*PixelsPerBezoeker%>" height="10"></td>
<%
end if
if GemBezoek <= CounterRs("Totaal") then
%>
		<td><img src="inc/blauw.gif" width="<%=GemBezoek*PixelsPerBezoeker%>" height="10"><img src="inc/lichtblauw.gif" width="<%=(CounterRs("Totaal")-GemBezoek)*PixelsPerBezoeker%>" height="10">
		</td>
<%
end if
%>
	</tr>
	<%
			CounterRs.MoveNext
		wend
	end if
%>
</table>
<%
	Set CounterRs = nothing
end if

' **********
'  Browser overzicht
' **********




if CounterAction="Browseroverzicht" then
'	CounterSQL = "SELECT TblTel.HTTP_USER_AGENT, Count(TblTel.ID) AS Aantal FROM TblTel GROUP BY  TblTel.HTTP_USER_AGENT"
	CounterSQL = "SELECT tblBrowsers.Browsertype, tblBrowsers.Version, Count(TblTel.ID) AS Aantal "
	CounterSQL = CounterSQL & "FROM TblTel INNER JOIN tblBrowsers ON TblTel.HTTP_USER_AGENT = tblBrowsers.HTTP_USER_AGENT "
	CounterSQL = CounterSQL & "GROUP BY tblBrowsers.Browsertype, tblBrowsers.Version;"

	Set CounterRs = CounterDataConn.Execute(CounterSQL)
%>
<h1>Verwijzingen overzicht</h1>
<table>
<tr>
<%
	if CounterRS.EOF then
%>
<p>Nog niets geteld...</p>
<%
	else
%>
<p>
<table>
<tr>
	<td><b>&nbsp;&nbsp;Browser</b></td>
	<td><b>&nbsp;&nbsp;Versie</b></td>
	<td><b>&nbsp;&nbsp;Aantal keer gebruikt</b></td>
</tr>
<%
		Telregels = 0
		while not CounterRs.EOF
			Telregels= telregels +1
			if VorigeBrowser <> CounterRs("BrowserType")  then
				if TotaalBrowserType > 30 then
%>
<tr>
	<td>
		<b><%=VorigeBrowser%> Totaal:</b>
	</td>

	<td>
		<b>&nbsp;&nbsp;<%=TotaalBrowserType%>&nbsp;&nbsp;</b>
	</td>
	<td>&nbsp;	</td>
</tr>
<%
				end if
				TotaalBrowserType = 0
			end if
			TotaalBrowserType = TotaalBrowserType + CounterRs("Aantal")
			VorigeBrowser = CounterRs("BrowserType")
%>
<tr>
	<td>
		<%=CounterRs("BrowserType")%>
	</td>
	<td>
		<%=CounterRs("Version")%>
	</td>
	<td>
		&nbsp;&nbsp;<%=CounterRs("Aantal")%>&nbsp;&nbsp;
	</td>
</tr>
<%
			CounterRs.MoveNext
		Wend
%>
<tr>
	<td>
        <b>
		Totaal:</b>
	</td>
	<td colspan="2">
        <b>
		<%=Telregels%> verschillende browsers</b>
	</td>
</tr>
</table>
<%
		Set CounterRs = nothing
	end if



elseif CounterAction = "referers" then
	dim rsRef
	set rsRef = CounterDataConn.execute("SELECT id, http_referer as h FROM tbltel")
	do while not rsRef.EOF
		if instr(rsRef("h"), "3l.nl") <> 0 AND instr(rsRef("h"), "google") = 0 then
			CounterDataConn.execute("UPDATE tbltel SET http_referer = null WHERE id="&rsRef("id"))
			response.write "Referer van 3l.nl verwijderd<br>"
		end if
		if rsRef("h") = "http://home.planet.nl/~vdriel/start/" then
			CounterDataConn.execute("UPDATE tbltel SET http_referer = null WHERE id="&rsRef("id"))
			response.write "Referer van startpagina verwijderd<br>"
		end if
		rsRef.MoveNext
		Loop
	rsRef.close
	set rsRef=nothing

	CounterDataConn.execute("DELETE FROM tbltel WHERE remote_addr = '80.61.68.211'")

	response.write "<p>Klaar met verwijderen van hits op ip-adres '80.61.68.211'</p>"

end if

CounterDataConn.Close
Set CounterDataConn = nothing
%>
<p>
<!-- #include file="_bottom.asp" -->