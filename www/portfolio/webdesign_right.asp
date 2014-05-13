<!-- #include file="../inc/dbdriel.asp" -->

<html>
<head>
<style type="text/css">
BODY{
	font-family: verdana;
	font-size: 11;
	color: #000000;
	margin-left: 0;
	margin-right: 0;
	margin-top: 0;
	margin-bottom: 0;
	}

.head {
	font-family: verdana;
	font-size: 12;
	color: #FF3300; 
	text-decoration: none; 
	font-weight: bold;
	}

A	{
	font-family: verdana;
	font-size: 11;
	color: #660099; 
	text-decoration: none; 
	font-weight: normal;
	}

A:HOVER {
	color : #FF3300;
	}

img {
	border-width: 0px;
	border-color: #663399;
	}
</style>
</head>
<body>

<%
website_id = Request("id")

if website_id = "" then
	response.write "<p class=head>Gebruiksaanwijzing</p>"
	response.write "Als u in het linker venster op een afbeelding klikt, krijgt u hier de informatie van de betreffende site te zien. <p>Tevens kunt u dan doorklikken naar de site zelf."
else
	sql = "SELECT * FROM portfolio WHERE id = "&website_id&" ORDER BY id ASC"
	Set rsSite= Conn.Execute(sql)
	Do while not rsSite.EOF

		bericht = replace((rsSite.Fields.Item("bericht").Value), vbCRLF, "<BR>")

		response.write "<p class=head>" &rsSite("titel")& "</p>"
		response.write bericht & "<p>"
		response.write "<b>Gebruikte technieken:</b><br>" &rsSite("techniek")& "<p>"
		response.write "<a href=" &rsSite("url")& " target=_blank>Bezoek deze site</a>"

	rsSite.MoveNext
	Loop 
	rsSite.Close 
	Set rsSite = Nothing
end if
%>


</body>
</html>