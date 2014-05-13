<!-- #include file="../databla.asp" -->

<html>

<HEAD>
<TITLE>Lukas van 3L</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="lukas@3l.nl">
<META NAME="Description" CONTENT="Lukas van 3L presenteert zich: Weblog, Fotoalbum en Portfolio">
<META NAME="Keywords" CONTENT="Lukas van 3L, Lukas van Driel, Lukas, 3L, Luckylukie, Lucky_lukie, lukasvandriel, lukasvdriel, portfolio, weblog, Mhuukas, mhuu, mhuuen, mhuu-en, fotolog">

<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">

<SCRIPT language=JavaScript><!--

window.defaultStatus = "3L.nl";

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
		<td height="123" width="734" 
		<%
		set cr=server.createobject("MSWC.ContentRotator")
		response.write(cr.ChooseContent("../inc/logolukas.txt"))
		%>
		><img src="../inc/logo.gif"></td>
	</tr>
</table><table width="734" border="0" cellspacing="5" cellpadding="0" align="center">
	<tr>
		<td width="176" valign="top">
				<H1>Over Lukas</H1>
				<a href="default.asp?actie=fietsen">Fietsen</a><br>
				<a href="default.asp?actie=hardlopen">Hardlopen</a><br>
				<a href="default.asp?actie=skaten">Skaten</a><br>
				<a href="default.asp?actie=films">Films & MP3</a><br>
				<a href="default.asp?actie=links">Links</a><br>
			<img src="inc/ff6633.gif" width="171" height="1">
			<H1>Sub-3L</H1>
				<a href="http://weblog.3l.nl">Weblog</a><br>
				<a href="http://fotolog.3l.nl">Fotolog</a><br>
				<a href="http://fotoalbum.3l.nl">Fotoalbum<br>
				<a href="http://portfolio.3l.nl">Portfolio</a><br>
				<a href="http://lukas.3l.nl">Lukas</a><br>
				<a href="http://g4g.3l.nl">Gifts for Girls</a><br>
			<img src="inc/ff6633.gif" width="171" height="1">
				<H1>Fotoalbum</H1>
<%
set rsFa=Conn.Execute("SELECT top 5 * FROM fotoalbum ORDER BY id desc")
do while not rsFa.EOF
	response.write "<a href='http://fotoalbum.3l.nl/fotolog/fotoalbum.asp?actie=album&id=" &rsFa("id")& "'>"
	response.write rsFa("titel")& "</a><br>"
rsFa.MoveNext
Loop
rsFa.close
set rsFa=nothing
%>
			<img src="inc/ff6633.gif" width="171" height="1">
				<H1>Contact</H1>
				<a href="default.asp?actie=contact">Formuliertje</a><br>
			</td>
		<td width="1" bgcolor="ff6633"><img src="inc/blank.gif" width="1"></td>
		<td width="380" valign="top">
