<% option explicit %>
<!-- #include file="_top.asp" -->
<%
response.expires=0 
response.CacheControl="private" 

dim actie, id
actie = Request("actie")
id = Request("id")

if actie = "contact" then
	%>
	<H1>Contact</H1>

	Je kan mij natuurlijk altijd een <a href="mailto:lukas@3l.nl">mailtje sturen</a>.<p>
	Maar voor degene die er écht werk van willen maken, kunnen dit formuliertje invullen.<p>
	Veel plezier!

	<FORM METHOD=POST ACTION="actie.asp?actie=contact" name="reactie" onSubmit="return checkFieldsReactie();">
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>Naam:</td>
		<td><INPUT TYPE="text" NAME="naam" class=button size=36 maxlength="35"></td>
	</tr>
	<tr>
		<td>E-mail:</td>
		<td><INPUT TYPE="text" NAME="email" class=button size=36 maxlength="35"></td>
	</tr>
	<tr>
		<td valign=top>Blaat:</td>
		<td><TEXTAREA NAME="bericht" ROWS="10" COLS="35" class=button></TEXTAREA></td>
	</tr>
	<tr>
		<td></td>
		<td><br><INPUT TYPE="submit" value="Kommaar op!" class=button></td>
	</tr>
	</table>
	</FORM>
<script type="text/javascript" language="javascript">
	document.forms['reactie'].elements['naam'].focus();
</script>
	<%

elseif actie = "contactbedankt" then
	%>
	<H1>Contact</H1>
	Bedankt voor het opsturen van dit formuliertje.<p>
	Klik <a href='weblog.asp'>hier</a> om terug te gaan naar de weblog.
	<%


elseif actie = "statistiekjes" then
	dim rsAantal, rsReactie, rsBlaat, aantallogs, aantalreacties, aantalgeblaat, rsRpp, i

	w "<H1>Statistiekjes</H1>"

	set rsAantal = Conn.Execute("SELECT count(*) as aantallogs FROM log")
		aantallogs = rsAantal("aantallogs")
	rsAantal.Close
	set rsAantal = nothing

	set rsReactie = Conn.Execute("SELECT count(*) as aantalreacties FROM reactie")
		aantalreacties = rsReactie("aantalreacties")
	rsReactie.Close
	set rsReactie = nothing
	
	set rsBlaat = Conn.Execute("SELECT count(*) as aantalgeblaat FROM gastenboek")
		aantalgeblaat = rsBlaat("aantalgeblaat")
	rsBlaat.Close
	set rsBlaat = nothing

	w "<b>Algemene Statistieken</b>"
	w "<table width='210' border='0' cellspacing='5' cellpadding='0'>"
	w "<tr><td width=20>&nbsp</td><td width=150>Aantal logs:</td><td align=right width=40>" &aantallogs& "</td></tr>"
	w "<tr><td width=20>&nbsp</td><td>Aantal reacties:</td><td align=right>" &aantalreacties& "</td></tr>"
	w "<tr><td width=20>&nbsp</td><td>Aantal geblaat:</td><td align=right>" &aantalgeblaat& "</td></tr>"
	w "</table>"

	w "<p><b>Top 10 Reageerders *</b>"
	w "<table width=250 border='0' cellspacing='5' cellpadding='0'>"

	set rsRpp = Conn.Execute("SELECT top 10 naam, count(id) as aantal FROM reactie WHERE naam not in (SELECT naam FROM reactie WHERE naam='Mhuukas' OR naam='Lukas') GROUP BY naam ORDER BY 2 desc, 1 asc")
	do while not rsRpp.EOF
		i = i+1
		w "<tr><td width=20 align=right>" &i& "</td>"
		w "<td width=150><a href='nutteloos.asp?actie=reactiepp&id=" &rsRpp("naam")& "'>" &rsRpp("naam")& "</a></td>"
		w "<td align=right width=40>" &rsRpp("aantal")& "</td>"
		w "<td align=right width=40>(" &Cint(100 / aantalreacties * rsRpp("aantal"))& "%)</td></tr>"
	rsRpp.MoveNext
	Loop
	rsRpp.close
	set rsRpp=nothing
		
	w "</table><br>"
	w "<i>&nbsp;* Klik op een naam om zijn reacties te zien</i>"
	
	w "<p><b>Zoek reacties</b>"
	w "<FORM METHOD=POST ACTION='actie.asp?actie=zoekreactie'>"
	w "&nbsp;Typ hieronder de persoon van wie je reacties wilt zien:<p>"
	w "&nbsp;<INPUT TYPE='text' NAME='naam' class=button width=30> <INPUT TYPE='submit' class=button value='zoek'>"
	w "</form>"
	
	w "<p><b>Referers</b></p>"
	w "<p>Referers zijn pagina's waarvandaan mensen op 3L.nl terecht komen. In dit geval specifieke zoektermen via welke mensen hier zijn beland. <a href=""nutteloos.asp?actie=referers"">Bekijk de referers-lijst.</a></p>"


elseif actie = "referers" then%>
<!-- #include file="datateller.asp" -->
<H1>Referrers</H1>
Referrers zijn pagina's waarvandaan mensen op 3L.nl terecht komen. In dit geval specifieke zoektermen via welke mensen hier zijn beland.<br>
Onderstaande termen is op gezocht in google, ilse, altavista en/of MSN:
<p> </p>
	<%
	dim CounterRs
	CounterDataConn.Execute("DELETE * FROM referrer")
	Set CounterRs = CounterDataConn.Execute("SELECT http_referer, datum FROM tbltel WHERE http_referer LIKE '%.google.%' OR http_referer like '%search.msn.%' OR http_referer like '%.altavista.com.%' OR http_referer like '%search.yahoo.com%' GROUP BY http_referer, datum ORDER BY 2 asc")
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
		link = Replace(link, "&", "")
		link = Replace(link, "%22", "")
		link = Replace(link, "%2B", " ")
		link = Replace(link, "%28", "(")
		link = Replace(link, "%29", ")")
		link = Replace(link, "%2C", ",")
		link = Replace(link, "%2D", "-")
		link = Replace(link, "%5C", "\")
		link = Replace(link, "%3A", ":")
	
		link = left(trim(link),50)
	
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
			'eerst in database zetten
			CounterDataConn.Execute("INSERT INTO referrer (zoekterm) VALUES ('"& link &"')")
		end if
		CounterRS.MoveNext
		loop
		CounterRS.close
		Set CounterRs = nothing
		
		'en dan weer er uit halen
		dim rsReferrer
		set rsReferrer = CounterDataConn.Execute("SELECT zoekterm, count(id) as bla FROM referrer GROUP BY zoekterm ORDER BY 2 desc, 1 asc")
		%><table width="340">
		<tr><td width="300"><strong>Zoekterm</strong></td><td width="40" align="right"><strong>Aantal<br>keer</strong></td></tr>
		<%
		do until rsReferrer.EOF
			link = Replace(rsReferrer("zoekterm"), "%27", "'")
			%>
			<tr><td><%=link%></td><td align="right"><%=rsReferrer("bla")%></td></tr>
			<%
			rsReferrer.MoveNext
			loop
		rsReferrer.close
		set rsReferrer = nothing
	CounterDataConn.Close
	Set CounterDataConn = nothing
	%></table><%


elseif actie = "reactiepp" then
	dim rsRpp2, rsAantal2, rsLog

	w "<H1>Reacties van " &id& "</H1>"
	set rsRpp2 = Conn.Execute("SELECT * FROM reactie WHERE naam='" &id& "' ORDER BY id desc")

	if rsRpp2.EOF then
		w "Deze persoon heeft (nog) niet gereageerd.<br>"
		w "Misschien bestaat de hele persoon wel niet, of reageert-ie onder een andere naam!<p>"
		w "Probeer het gewoon nog een keertje:"
		w "<FORM METHOD=POST ACTION='actie.asp?actie=zoekreactie'>"
		w "<INPUT TYPE='text' NAME='naam' class=button width=30 value='"&id&"'> <INPUT TYPE='submit' class=button value='zoek'>"
		w "</form>"
	else
		set rsAantal2 = Conn.Execute("SELECT count(*) as aantal FROM reactie WHERE naam='" &id& "' GROUP BY naam")
			w id& " heeft al <b>" &rsAantal2("aantal")& "</b> keer gereageerd.<br>"
			w "Hier volgen zijn/haar reacties:<p>"

		rsAantal2.close
		set rsAantal2 = nothing

		do while not rsRpp2.EOF
	
			set rsLog = Conn.Execute("SELECT * FROM log WHERE id = "&rsRpp2("log_id"))
				w "(log " &rsLog("id")& ") <a href='reactie.asp?id=" &rsLog("id")& "'>" &rsLog("titel")& "</a><br>"
			rsLog.close
			set rsLog=nothing

			w "<i>op " &rsRpp2("datum")& " om " &rsRpp2("tijd")& "</i><br>"
			w Left(rsRpp2("bericht"), 50)& "...<p>"

		rsRpp2.MoveNext
		Loop
	end if

	rsRpp2.close
	set rsRpp2=nothing

elseif actie="links" then
	%>
	<H1>Internet Links</H1>
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td valign=top width=180>
		<b>Webloggers</b>:<p>
		<a href="http://www.mhuu.nl" target="_blank">Mhuu</a><br>
		<a href="http://fret.mhuu.nl" target="_blank">Koesper</a><br>
		<a href="http://www.sanderspies.nl/" target="_blank">Sanderspies.nl</a><br>
		<a href="http://www.egodrama.com" target="_blank">Egodrama</a><br>
		<a href="http://www.awaking.nl" target="_blank">Awaking.nl</a><br>
		<a href="http://kwakoekwakoe.mhuu.nl" target="_blank">Kwakoekwakoe</a><br>
		<a href="http://www.mijnkopthee.nl" target="_blank">Mijn Kop Thee</a><br>
		<a href=""></a><br>
		</td>
		<td valign=top>
		<b>Vrienden</b>:<p>
		<a href="http://www.suusje.com" target="_blank">Suusje</a><br>
		<a href="http://www.sperdegroot.nl" target="_blank">C@sperdegroot.nl</a><br>
		<a href="http://www.marov.nl/" target="_blank">Marov.nl</a><br>
		<a href="http://www.haaguit.nl" target="_blank">Haag Uit 2003</a><br>
		<a href=""></a><br>
		</td>
	</tr>
	<tr>
		<td valign=top>
		<b>Nutteloos</b>:<p>
		<a href="http://www.koelman.com/" target="_blank">Koelman</a><br>
		<a href="http://www.rathergood.com/" target="_blank">Rathergood .com</a><br>
		<a href="http://www.ikbendom.com" target="_blank">Ik ben dom .com</a><br>
		<a href="http://www.groenbrothers.com" target="_blank">Groenbrothers</a><br>
		<a href="http://www.kabaal.net/" target="_blank">Kabaal.net</a><br>
		<a href="http://www.playplay.be" target="_blank">Playplay.be</a><br>
		<a href=""></a><br>
		</td>
		<td valign=top>
		<b>Nuttelvol</b>:<p>
		<a href="http://www.nu.nl" target="_blank">Nu.nl</a><br>
		<a href="http://zoekopnummer.ath.cx/" target="_blank">Zoeken op telefoonnummer</a><br>
		<a href="http://g4g.3l.nl" target="_blank">Gifts for Girls</a><br>
		</td>
	</tr>
		<tr>
		<td valign=top>
		<b>Skaten</b>:<p>
		<a href="http://www.skateology.org/" target="_blank">Skateology (Leiden)</a><br>
		<a href="http://www.skateology.org/agenda/dinsdag.htm" target="_blank">Tuesdaynightskate (Leiden)</a><br>
		<a href="http://www.fridaynightskate.nl" target="_blank">Fridaynightskate (A'dam)</a><br>
		<a href="http://www.u-skateparade.nl" target="_blank">Fridaynightskate (Utrecht)</a><br>
		<a href="http://www.wednesdaynightskate.nl" target="_blank">Wednesdaynightskate (R'dam)</a><br>
		<a href="#" target="_blank"></a><br>
		<a href=""></a><br>
		</td>
		<td valign=top>
		<b></b><p>
		<a href="" target="_blank"></a><br>
		</td>
	</tr>
	<tr>
		<td colspan=2 bgcolor=ff6633 height=1><img src=inc/blank.gif height=1 width=1></td>
	</tr>
	<tr>
		<td colspan=2 align=right><a href=weblog.asp><i>Terug naar het weblog</i></a></td>
	</tr>
	</table>
	<%
end if
%>

<!-- #include file="_bottom.asp" -->