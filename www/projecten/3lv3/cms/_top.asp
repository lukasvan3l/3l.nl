<!-- #include file="../databla.asp" -->
<%
Response.Expires=0 '0 is het aantal minuten dat de pagina in de cache wordt opgeslagen 
response.CacheControl="private" 'private geeft aan dat je pagina niet door proxy servers gecached wordt.


if session("user") <> "lukas" then
	response.redirect("default.asp")
end if


dim id, actie
id = Request("id")
actie = Request("actie")

Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub
%>
<HTML>
<HEAD>
	<TITLE>CMS.3L.nl</TITLE>
	<LINK HREF="inc/style.css" REL="stylesheet" TYPE="text/css">
	<SCRIPT language=JavaScript>
	
		window.defaultStatus = "CMS.3L.nl";
		
		//deze code in je HEAD opnemen
		//de waardes van de kleuren kan je aanpassen
		//
		//highlights de rij waar je muiscursor overheen gaat
		//Row moet this zijn, Action moet 'over' of 'out' zijn
		function setPointer(Row, Action)
		{
			var Cells = null;
			var newColor = null;
			Cells = Row.getElementsByTagName('td');
			if (Action == 'over') {
		    	newColor = '#efefef';
			}
			if (Action == 'out') {
				newColor = '#ffffff';
			}
			var c = null;
		    var rowCellsCnt	= Cells.length;
			for (c = 0; c < rowCellsCnt; c++) {
				Cells[c].setAttribute('bgcolor', newColor, 0);
			}
		}
	
	</SCRIPT>
</HEAD>

<BODY>
<table width="700" height=100% border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td height=15></td>
	</tr>
	<tr>
		<!-- TOP IMAGE -->
		<td height=15 align=center><a href='welkom.asp'><img src='../inc/logo.gif'></a></td>
	</tr>
	<tr>
		<td align=center height=30>
			<!-- NAVIGATIE -->
			<a href='weblog.asp'>Weblog</a> | 
			<a href='fotolog.asp'>Fotolog</a> | 
			<a href='fotoalbum.asp'>Fotoalbum</a> | 
			<a href='geblaat.asp'>Geblaat</a> |
			<a href='portfolio.asp'>Portfolio</a> |
			<a href='stats.asp'>Statistieken</a>
		</td>
	</tr>
	<tr>
		<td height=10></td>
	</tr>
	<tr>
		<td height=100% valign=top>