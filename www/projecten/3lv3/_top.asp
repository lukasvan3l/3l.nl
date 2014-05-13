<!-- #include file="../../inc/dbdriel.asp" -->

<%
dim conn
Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

Sub maandvanjaar(maandnr)
	Select case maandnr
		case "1"  response.write("jan")
		case "2"  response.write("feb")
		case "3"  response.write("mrt")
		case "4"  response.write("apr")
		case "5"  response.write("mei")
		case "6"  response.write("jun")
		case "7"  response.write("jul")
		case "8"  response.write("aug")
		case "9"  response.write("sep")
		case "10"  response.write("okt")
		case "11"  response.write("nov")
		case "12"  response.write("dec")
	End Select
End Sub
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<HEAD>
<TITLE>Lukas van 3L</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="lukas@3l.nl">
<META NAME="Description" CONTENT="Lukas van 3L presenteert zich: Weblog, Fotoalbum en Portfolio">
<META NAME="Keywords" CONTENT="Lukas van 3L, Lukas van Driel, Lukas, 3L, Luckylukie, Lucky_lukie, lukasvandriel, lukasvdriel, portfolio, weblog, Mhuukas, mhuu, mhuuen, mhuu-en, fotolog">

<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">

<SCRIPT language=JavaScript><!--

window.defaultStatus = "Lukas van 3L";

function checkFieldsBlaten() {
	missinginfo = "";

	if (document.blaten.naam.value == "") {
	missinginfo += "\n     -  Naam";
	}
	if (document.blaten.bericht.value == "") {
	missinginfo += "\n     -  Bericht";
	}

	if (missinginfo != "") {
	missinginfo ="Je bent wat gegevens vergeten:\n" +
	missinginfo + "\n\nVul ze in voordat je reageert.";
	alert(missinginfo);
	return false;
	}
	else return true;
	}

function checkFieldsReactie() {
	missinginfo = "";

	if (document.reactie.naam.value == "") {
	missinginfo += "\n     -  Naam";
	}
	if (document.reactie.bericht.value == "") {
	missinginfo += "\n     -  Bericht";
	}

	if (missinginfo != "") {
	missinginfo ="Je bent wat gegevens vergeten:\n" +
	missinginfo + "\n\nVul ze in voordat je reageert.";
	alert(missinginfo);
	return false;
	}
	else return true;
	}

//--></SCRIPT>

</HEAD>
<BODY>

<table width="734" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
<!-- BOVENSTE CELL MET VERANDERENDE ACHTERGROND -->
		<td height="123" width="734"
		<%
		dim cr
		set cr=server.createobject("MSWC.ContentRotator")
		response.write(cr.ChooseContent("inc/logo.txt"))
		%>
		><img src="inc/logo.gif"></td>
	</tr>
</table>

<table width="734" border="0" cellspacing="5" cellpadding="0" align="center">
	<tr>
		<td width="176" valign="top">
				<H1>Fotolog</H1>
<!-- FOTOLOG -->
<%
dim rsFl
set rsFl=Conn.Execute("SELECT top 1 id, titel FROM fotolog ORDER BY id desc")
	w "<center><a href='fotolog/'>"
	w "<img src='http://www.3l.nl/fotolog/thumbs/" &rsFl("id")& ".jpg' width=160 class=foto alt='" &rsFl("titel")& "'></a><br></center>"
rsFl.close
set rsFl=nothing
%>
			<br>
			<img src="inc/ff6633.gif" width="171" height="1">
			<H1>Fotoalbum</H1>
<!-- FOTOALBUM -->
<%
dim rsFa
set rsFa=Conn.Execute("SELECT top 5 * FROM fotoalbum ORDER BY id desc")
do while not rsFa.EOF
	w "<a href='http://fotoalbum.3l.nl/fotolog/fotoalbum.asp?actie=album&id=" &rsFa("id")& "' title='Bekijk de fotos van "&rsFa("titel")&"'>"
	w rsFa("titel")& "</a><br>"
rsFa.MoveNext
Loop
rsFa.close
set rsFa=nothing
%>
<P><a href="http://fotoalbum.3l.nl" title='Alle fotoalbums op een rijtje'>Lijst met fotoalbums</a><br>
			
			<br>
			<img src="inc/ff6633.gif" width="171" height="1">
<!-- WIE lijst	<H1>Aanwezigen</H1>
				<script language="JavaScript" src="http://www.gdeesha.com/wie/wie.php?user=luckylukie"></script>
			<img src="inc/ff6633.gif" width="171" height="1"> -->
				<H1>Archief</H1>
				<a href="weblog.asp">Vandaag</a><br>
				<a href="weblog_archief.asp?id=2003">Archief 2003</a><br>
				<a href="weblog_archief.asp?id=2002">Archief 2002</a><br>
				
			<br> 
			<img src="inc/ff6633.gif" width="171" height="1">
				<H1>Nuttelhoos</H1>
				<a href="nutteloos.asp?actie=links">Internet Links</a><br>
				<a href="nutteloos.asp?actie=contact">Contactformuliertje</a><br>
				<a href="http://lukas.3l.nl/">Over Lukas</a><br>
				<a href="http://portfolio.3l.nl/">Portfolio</a><br>
				<a href="nutteloos.asp?actie=referers">Referrers</a><br>
				<a href="nutteloos.asp?actie=statistiekjes">Statistiekjes</a><br><br>
				<a href="http://www.3l.nl/rss/weblog.xml"><img src="inc/xml.gif"></a><br>
				
			<br>
			<img src="inc/ff6633.gif" width="171" height="1">
			<br><br>
				<font color="#ffffff">&copy; Lukas van Driel<br>Website is gemaakt door Lukas van Driel, alle teksten en foto's zijn door ook door Lukas van Driel gemaakt.</font>
		</td>
		<td width="1" bgcolor="#ff6633"><img src="inc/blank.gif" width="1"></td>
		<td width="380" valign="top">
