<%saveReferrer()
if request.querystring("reis") <> "" then
	session("reis") = cint(request.querystring("reis"))
elseif session("reis") = "" then
  set rs = execquery("SELECT max(id) as id FROM hesteropreis_reizen", conn)
  session("reis") = rs("id")
  set rs = nothing
end if

set rs = execquery("SELECT * FROM hesteropreis_reizen WHERE id="&session("reis"), conn)
dim landnaam
landnaam = rs("land")
set rs = nothing
%>
<html>
<head>
	<title>Hester op reis - <%=landnaam%></title>
	<link href="inc/css/hester.css" rel="stylesheet" type="text/css" />
	
	<script language="javascript" type="text/javascript">

	window.defaultStatus = "Hester op reis - Guatemala (en India)";
	
	// image rollover
	function newImage(arg) {
		if (document.images) {
			rslt = new Image();
			rslt.src = arg;
			return rslt;
		}
	}
	
	function changeImages() {
		if (document.images && (preloadFlag == true)) {
			for (var i=0; i<changeImages.arguments.length; i+=2) {
				document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
			}
		}
	}
	
	var preloadFlag = false;
	function preloadImages() {
		if (document.images) {
			nav_fotoalbums_over = newImage("hesteropreis/images/nav_fotoalbums-over.jpg");
			nav_nutteloos_over = newImage("hesteropreis/images/nav_nutteloos-over.jpg");
			nav_personen_over = newImage("hesteropreis/images/nav_personen-over.jpg");
			arrowleft_over = newImage("inc/images_wit/arrowleft2.gif");
			arrowright_over = newImage("inc/images_wit/arrowright2.gif");
			preloadFlag = true;
		}
	}
	
	// -->
	</script>
</head>

<body leftmargin=0 topmargin=10 marginwidth=0 marginheight=10 onload="preloadImages();">
<table border=0 cellpadding=0 width="768" cellspacing=0 align="center">
	<tr>
		<td colspan=8 background="hesteropreis/images/layer1.jpg" WIDTH=768 HEIGHT=91> </td>
	</tr>
	<tr>
		<td colspan=2 background="hesteropreis/images/layer2_1.jpg" WIDTH=297 HEIGHT=15> </td>
		<td><img src="hesteropreis/images/nav_weblog.jpg" width=89 height=15 border=0 alt=""></td>
		<td><img src="hesteropreis/images/nav_fotolog.jpg" width=82 height=15 border=0 alt=""></td>
		<td>
			<a href="<%= request.servervariables("script_name") %>"
				onmouseover="changeImages('nav_fotoalbums', 'hesteropreis/images/nav_fotoalbums-over.jpg'); return true;"
				onmouseout="changeImages('nav_fotoalbums', 'hesteropreis/images/nav_fotoalbums.jpg'); return true;">
				<img name="nav_fotoalbums" src="hesteropreis/images/nav_fotoalbums.jpg" width=107 height=15 border=0 alt="Voorpagina"></a></td>
		<td>
			<a href="<%= request.servervariables("script_name") %>?m=reisverhalen"
				onmouseover="changeImages('nav_nutteloos', 'hesteropreis/images/nav_nutteloos-over.jpg'); return true;"
				onmouseout="changeImages('nav_nutteloos', 'hesteropreis/images/nav_nutteloos.jpg'); return true;">
				<img name="nav_nutteloos" src="hesteropreis/images/nav_nutteloos.jpg" width=122 height=15 border=0 alt="Reisverhalen"></a></td>
		<td colspan=2>
			<a href="<%= request.servervariables("script_name") %>?m=fotos"
				onmouseover="changeImages('nav_personen', 'hesteropreis/images/nav_personen-over.jpg'); return true;"
				onmouseout="changeImages('nav_personen', 'hesteropreis/images/nav_personen.jpg'); return true;">
				<img name="nav_personen" src="hesteropreis/images/nav_personen.jpg" width=71 height=15 border=0 alt="Foto's"></a></td>
	</tr>
	<tr>
		<td colspan=8 background="hesteropreis/images/layer3.jpg" WIDTH=768 HEIGHT=19> </td>
	</tr>
	<tr>
		<td valign="top" background="hesteropreis/images/bottom_left.gif">
		
			<img src="hesteropreis/images/layer4_1.jpg" width=211 height=300 alt="background image"><br>
			
			<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td width="5" valign="top" rowspan="2">
					<img src="hesteropreis/images/spacer.gif" alt="spacer" border="0" width="5" height="5"></td>
				<td valign="top" style="padding-left:20px;">
					<!-- navigatie zijkant -->
					
					<%set rs = execquery("SELECT * FROM hesteropreis_reizen WHERE not id="&session("reis")&" ORDER BY begindatum DESC", conn)
					if not rs.EOF then
						response.write("<h2>Andere Reizen</h2>")
						do until rs.EOF
							response.write("<a href=""default.asp?m="&request.querystring("m")&"&reis="&rs("id")&""">"&rs("land")&"</a><br>")
						rs.movenext : loop
						rs.close
					end if
					set rs = nothing%>
					
					<!-- /navigatie zijkant -->
					</td>
			</tr>

			</table>
			
			</td>
		<td colspan=6 width=536 style="background-image: url(hesteropreis/images/layer4_2.jpg); background-color: #ffffff; background-repeat: no-repeat; overflow: hidden;" valign="top">

			<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
			<!-- content -->
			
<%if request.querystring("m") = "reisverhalen" and request.querystring("id") = "" then
	set rs = conn.execute("SELECT * FROM hesteropreis WHERE type=2 and verwijderd=false AND reis="&session("reis")&" ORDER BY datum DESC")%>
	<h1>Reisverhalen</h1>
	<table width="95%" cellspacing="0" cellpadding="4" align="center">
	<tr><td colspan="2"><hr></td></tr>
	<%if rs.EOF then
		response.write("<tr><td colspan=""2"">Er zijn nog geen reisverhalen toegevoegd.</td></tr>")
	else
	do until rs.EOF%>
		<tr>
			<td width="150"><a href="default.asp?m=reisverhalen&id=<%=rs("id")%>"><%=date2datum(rs("datum"),false)%></a></td>
			<td><a href="default.asp?m=reisverhalen&id=<%=rs("id")%>"><%=rs("oorsprong")%></a></td>
		</tr>
	<%rs.movenext : loop
	end if
	rs.close : set rs = nothing%>
	<tr><td colspan="2"><hr></td></tr>
	</table>
	<%if landnaam="Guatemala" then%>
	<h1>Kaart</h1>
	<table width="95%" cellspacing="0" cellpadding="4" align="center">
	<tr><td><hr></td></tr>
	<tr><td><a href="default.asp?m=kaart">Klik hier om de kaart van <%=landnaam%> te bekijken.</a></td></tr>
	<tr><td><hr></td></tr>
	</table>
  <% end if %>

<%elseif request.querystring("m") = "reisverhalen" and not request.querystring("id") = "" then
	set rs = conn.execute("SELECT * FROM hesteropreis WHERE verwijderd=false and reis="&session("reis")&" AND id="&request.querystring("id"))%>
	<h1>Reisverhalen</h1>
	<table width="100%" cellspacing="0" cellpadding="4" align="center">
	<tr>
		<td><strong><%=rs("oorsprong")%></strong></td>
		<td align="right"><%=date2datum(rs("datum"),true)%></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
	<%if request.querystring("gereageerd") = "true" then%>
	<tr>
		<td colspan="2" align="center" style="color:red;"><em>Bedankt voor de reactie! Hij is per e-mail naar mij verstuurd.</em></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
	<%end if%>
	<tr>
		<td colspan="2"><%=rs("tekst")%></td>
	</tr>
	<tr>
		<td colspan="2"><hr></td>
	</tr>
	<tr>
		<td width="60%"><a href="default.asp?m=reageren&r_id=<%=rs("id")%>">Stuur een persoonlijke reactie op dit reisverhaal!</a></td>
		<td width="40%" align="right"><a href="default.asp?m=reisverhalen">Terug naar het overzicht</a></td>
	</tr>
	</table>
	<%set rs = nothing

elseif request.querystring("m") = "fotos" and request.querystring("f_id") = "" then
	if session("reis") = 2 then
		set rs = ExecQuery("SELECT * FROM hesteropreis WHERE type=3 AND verwijderd=false and reis="&session("reis")&" ORDER BY id DESC", conn)
		response.write("<h1>Foto's</h1>De foto's zijn aflopend in datum.")
	else
		set rs = ExecQuery("SELECT * FROM hesteropreis WHERE type=3 AND verwijderd=false and reis="&session("reis")&" ORDER BY id ASC", conn)
		response.write("<h1>Foto's</h1>De foto's staan op chronologische volgorde.")
	end if
	if rs.EOF then
		response.write("Er zijn nog geen foto's toegevoegd.")
	else
	if request.querystring("pagina") = "" then
		huidige_pagina = 1
	else 
		huidige_pagina = Cint(request.querystring("pagina"))
	end if
	rs.PageSize=25
	aantal_paginas = rs.PageCount 
	If Cint(huidige_pagina) < 1 Then huidige_pagina = 1 
	If Cint(huidige_pagina) > aantal_paginas Then huidige_pagina = aantal_paginas 
	rs.AbsolutePage = cint(huidige_pagina)
	%>
	<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td colspan="5" align="right">
		<%	call Print_Navigation(rs, huidige_pagina, 8)%>
		<br>&nbsp;
	</td></tr>
	<tr>
	<%
	i = 0
	Do While rs.AbsolutePage = huidige_pagina AND Not rs.EOF
		i = i + 1
    dim foto2
    foto2 = rs("foto")
    if session("reis") = 3 then
      foto2 = foto2 & ".jpg"
    end if
    %>

			<td width=104 align=center valign=top height=70>
				<a href="<%= request.servervariables("SCRIPT_NAME") %>?m=fotos&f_id=<%=rs("id")%>&pagina=<%=(huidige_pagina-1)*rs.PageSize + i%>"><img src="http://hester.3l.nl/hesteropreis/fotos/thumbs/<%=foto2%>" height=50 alt="Hester op Reis - <%=rs("tekst")%>"></a>
				</td>
			<%
			If (i MOD 5 = 0 ) Then
				response.write("</tr><tr>")
			end if
		RS.MoveNext : Loop
	%>
	</tr>
	<tr><td colspan="5" align="right">
		<%call Print_Navigation(rs, huidige_pagina, 8)%><br>&nbsp;
	</td></tr>
	</table>
	<%end if
	rs.Close : 	set rs=nothing

elseif request.querystring("m") = "fotos" and not request.querystring("f_id") = "" then
	if session("reis") = 2 then
		set rs = ExecQuery("SELECT * FROM hesteropreis WHERE type=3 AND verwijderd=false and reis="&session("reis")&" ORDER BY id DESC", conn)
	else
		set rs = ExecQuery("SELECT * FROM hesteropreis WHERE type=3 AND verwijderd=false and reis="&session("reis")&" ORDER BY id ASC", conn)
	end if
	rs.PageSize=1
	if request.querystring("pagina") = "" then 
		huidige_pagina = 1 
	else 
		huidige_pagina = Cint(request.querystring("pagina")) 
	end if 
	If 1 > huidige_pagina Then
		huidige_pagina = 1
	end if
	If huidige_pagina > rs.PageCount Then
		huidige_pagina = rs.PageCount
	end if
	
	rs.AbsolutePage = huidige_pagina
	%>
	<h1>Foto's</h1>
	<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
	<%Do While rs.AbsolutePage = huidige_pagina AND Not rs.EOF
  dim foto
  foto = rs("foto")
  if session("reis") = 3 then
    foto = foto & ".jpg"
  end if
  %>
	<tr>
		<td width=410 height=260><div width=410 style="overflow: hidden;" align="center">
			<img src="http://hester.3l.nl/hesteropreis/fotos/<%=foto%>" alt="Hester op Reis"></div></td>
		<td valign="top" colspan=2>
			<%=rs("oorsprong")%>
			<p><%=date2datum(rs("datum"),false)%>
			<p><%if not rs("tekst") = "" then
					response.write(replace(rs("tekst"), vbCRLF, "<br>"))
				end if%>
		</td>
	</tr>
	<%rs.MoveNext : Loop%>
	<tr>
		<td valign="middle" height=30 align="center" colspan=2><%Print_Navigation rs, huidige_pagina, 5%></td>
	</tr>
	<tr>
		<td height=20 valign="top" align="left" colspan="2"><a href="default.asp?m=fotos&pagina=<%=cint(left(cstr(huidige_pagina / 25),1))+1%>">Terug naar overzicht</a></td>
	</tr>
	</table>
	<%rs.Close : Set rs = Nothing


elseif request.querystring("m") = "reageren" then
	if request.querystring("a") = "versturen" and isnumeric(request.form("r_id")) then
		
		sql = "INSERT INTO hesteropreisreactie ([datum], [afzender], [email], [bericht], [hesteropreis_id], [ipadres]) VALUES(FORMAT('" & day(now) & "-" & month(now) & "-" & year(now) & " " & hour(now) & ":" & minute(now) & ":" & second(now) &"','dd-mm-yyyy hh:mm:ss'), '"&changequotes(request.form("naam"))&"', '"&changequotes(request.form("email"))&"', '"&changequotes(request.form("bericht"))&"', "&request.form("r_id")&", '"& Request.ServerVariables("REMOTE_ADDR") &"')"
		on error resume next
		conn.execute(sql)
		
		Response.Cookies("3l.nl")("naam") = request.form("naam")
		Response.Cookies("3l.nl")("email") = request.form("email")
		Response.Cookies("3l.nl").Expires = Date + 365
		
		bericht = "<html><head>"
		bericht = bericht & "<title>Reactie op hester.3l.nl</title>"
		bericht = bericht & "<style type=""text/css"">.hesteropreis { background-color: #ffffff; font-family: verdana, arial; font-size: 12px; color: #ff6633; } .hesteropreis:a { color: #ff6633; }</style>"
		bericht = bericht & "</head><body><table>"
		bericht = bericht & "<tr><td class=""hesteropreis"">Naam:</td><td class=""hesteropreis"">" & request.form("naam") & "</td></tr>"
		bericht = bericht & "<tr><td class=""hesteropreis"">Email:</td><td class=""hesteropreis"">" & request.form("email") & "</td></tr>"
		bericht = bericht & "</table><p class=""hesteropreis"">" & replace(request.form("bericht"), vbcrlf, "<br>") & "</p>"
		bericht = bericht & "</body></html>"
		
		dim msg
		set msg 		= CreateObject("CDONTS.NewMail")
		if instr(request.form("email"),"@") = 0 then
			msg.from	= "lukas@3l.nl"
		else
			msg.from 	= request.form("email")
		end if
		msg.to			= "hester_van_d@hotmail.com"
		'msg.to			= "lukas@3l.nl"
		'msg.to			= "h.s.vandeutekom@students.uu.nl"
		msg.subject 	= request.form("naam") & " heeft gereageerd op hester.3l.nl"
		msg.BodyFormat	= 0		'html
	    msg.MailFormat	= 0		'mime
		msg.Body		= bericht
		msg.Send		
		set msg = nothing
		
		response.redirect("default.asp?m=reisverhalen&gereageerd=true&id="&request.form("r_id"))
	end if
	%>
	<h1>Reageren</h1>
	Onderstaande reactie wordt bezorgd op mijn e-mailadres, en zal niet door anderen dan mij gelezen worden.
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<form method=post action="default.asp?m=reageren&a=versturen" name="reactie_form">
	<input type="hidden" value="<%=request.querystring("r_id")%>" name="r_id">
	<tr>
		<td>Naam:</td>
		<td align="right"><input type="text" name="naam" class=button size=36 maxlength="35" value="<%=request.cookies("3l.nl")("naam")%>"></td>
	</tr>
	<tr>
		<td>E-mail:</td>
		<td align="right"><input type="text" name="email" class=button size=36 maxlength="35" value="<%=request.cookies("3l.nl")("email")%>"></td>
	</tr>
	<tr>
		<td colspan="2"><br>
		<textarea cols="47" rows="15" name="bericht"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan=2 align="right"><br><input type="submit" value="Verstuur" class=button></td>
	</tr>
	</form>
	</table>
	<script type="text/javascript" language="javascript">
		document.forms['reactie_form'].elements['naam'].focus();
	</script>

<%elseif request.querystring("m") = "kaart" then
	%><h1>Kaart</h1>
	<p>Onderstaande kaart geeft de route weer die ik af heb gelegd, en de data.<br>
	Het is wel een beetje scrollen, aangezien het een grote kaart is.</p>
	<div style="width: 515px; height: 400px; overflow: auto;">
	<%if session("reis") = 2 then
		response.write("<img src=""hesteropreis/images/guatemala_kaart.jpg"">")
	else
		response.write("geen kaart beschikbaar")
	end if
	response.write("</div>")
	
else
	set rs = conn.execute("SELECT tekst FROM hesteropreis WHERE type=1 and verwijderd=false and reis="&session("reis")&"")
  response.write(rs("tekst"))
	set rs = nothing%>
	<br>&nbsp;
	<hr>
	<h1>Recente toevoegingen</h1>
	<table width="90%" align="center">
	<tr>
		<td width="30%"><strong>Datum</strong></td>
		<td width="50%"><strong>Titel</strong></td>
		<td width="20%"><strong>Pagina</strong></td>
	</tr>
	
	<%set rs = conn.execute("SELECT top 7 * FROM hesteropreis WHERE type=2 and verwijderd=false and reis="&session("reis")&" ORDER BY datum DESC")
	do until rs.EOF
		dim module2
		if rs("type") = 2 then
			module2 = "reisverhalen"
		elseif rs("type") = 3 then
			module2 = "fotos"
		end if%>
		<tr>
			<td><a href="default.asp?m=<%=module2%>&id=<%=rs("id")%>"><%=date2datum(rs("datum"),false)%></a></td>
			<td><a href="default.asp?m=<%=module2%>&id=<%=rs("id")%>"><%=rs("oorsprong")%></a></td>
			<td><a href="default.asp?m=<%=module2%>"><%=module2%></a></td>
		</tr>
	<%rs.movenext : loop
	rs.close : set rs = nothing%>
	</table>
	
<%end if%>
			
			<!-- /content -->
			</td></tr></table>
			</td>
		<td bgcolor="#ffffff" valign="top" background="hesteropreis/images/bottom_right.gif" style="background-repeat:repeat-y;">
			<img src="hesteropreis/images/layer4_3.jpg" width=21 height=300 alt="background image"></td>
	</tr>

	<tr>
		<td colspan="8" background="hesteropreis/images/bottom.gif" width="768" height="21" valign="top" style="background-repeat:no-repeat;"></td>
	</tr>
	
	<tr>
		<td width=211> </td>
		<td width=86> </td>
		<td width=89> </td>
		<td width=82> </td>
		<td width=107> </td>
		<td width=122> </td>
		<td width=50> </td>
		<td width=21> </td>
	</tr>
</table>
<%

'if request.querystring("del") = "true" then
'	response.write("DELETE FROM hesteropreis WHERE type=3 AND reis=2")
'	conn.execute("DELETE FROM hesteropreis WHERE type=3 AND reis=2")
'	for i = 207 to 1 step -1
'		response.write("INSERT INTO hesteropreis(foto, type, reis) VALUES('guat_"&i&".jpg',3,2)")
'		conn.execute("INSERT INTO hesteropreis(foto, type, reis) VALUES('guat_"&i&".jpg',3,2)")
'	next
'end if

%>
</body>
</html>