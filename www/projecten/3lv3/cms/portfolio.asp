<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<%
actie = request("actie")
id = request("id")
%>
<a href="http://portfolio.3l.nl" target=_blank><H1>Portfolio</H1></a>

<%
if actie = "" then
	w "<table width='100%' align=center>"

	set rsPf = Conn.Execute("SELECT * FROM portfolio ORDER BY id desc")
	do while not rsPf.EOF
		w "<tr><td><a href=portfolio.asp?actie=aanpassen&id="&rsPf("id")&">"&rsPf("id")&"</a></td>"
		w "<td><a href=portfolio.asp?actie=aanpassen&id="&rsPf("id")&">"&rsPf("titel")&"</a></td>"
		w "<td><a href='"&rsPf("url")&"' target=_blank>"&rsPf("url")&"</a></td>"
		w "<td align=right><a href=actie.asp?actie=pfdel&id="&rsPf("id")&"><img src='inc/prullenbak.gif' alt='verwijderen'></a></td>"
		w "</tr>"
	rsPf.MoveNext
	loop
	rsPf.close
	set rsPf=nothing

	w "<tr><td colspan=4 height=15></td></tr>"
	w "<tr><td colspan=4><a href=portfolio.asp?actie=toevoegen>Nieuwe toevoegen</a></td></tr>"
	w "</table>"


elseif actie="aanpassen" then
	w "<FORM METHOD=POST ACTION='actie.asp?actie=pfaanpassen'><INPUT TYPE='hidden' name='id' value='"&id&"'><table align=center>"
	set rsPf = Conn.Execute("SELECT * FROM portfolio WHERE id="&id)
		w "<tr><td></td><td align=center><img src=http://portfolio.3l.nl/portfolio/website_t/"&rsPf("id")&".jpg height=100></td></tr>"
		w "<tr><td>Naam:</td><td><INPUT TYPE='text' NAME='titel' value='"&rsPf("titel")&"' class=button size=41></td></tr>"
		w "<tr><td>URL:</td><td><INPUT TYPE='text' NAME='url' value='"&rsPf("url")&"' class=button size=41></td></tr>"
		w "<tr><td>Techniek:</td><td><INPUT TYPE='text' NAME='techniek' value='"&rsPf("techniek")&"' class=button size=41></td></tr>"
		w "<tr><td valign=top>Bericht:</td><td><TEXTAREA NAME='bericht' ROWS='12' COLS='40' class=button>"&rsPf("bericht")&"</TEXTAREA></tr>"
		w "<tr><td colspan=2 align=right><INPUT TYPE='submit' class=button value='opslaan'></td></tr>"
	set rsPf=nothing
	w "</table></form>"


elseif actie="toevoegen" then
	w "<FORM METHOD=POST ACTION='actie.asp?actie=pfnieuw'><table align=center>"
	w "<tr><td></td><td align=center>geen foto beschikbaar</td></tr>"
	w "<tr><td>Naam:</td><td><INPUT TYPE='text' NAME='titel' class=button size=41></td></tr>"
	w "<tr><td>URL:</td><td><INPUT TYPE='text' NAME='url' class=button size=41></td></tr>"
	w "<tr><td>Techniek:</td><td><INPUT TYPE='text' NAME='techniek' class=button size=41></td></tr>"
	w "<tr><td valign=top>Bericht:</td><td><TEXTAREA NAME='bericht' ROWS='12' COLS='40' class=button></TEXTAREA></tr>"
	w "<tr><td colspan=2 align=right><INPUT TYPE='submit' class=button value='opslaan'></td></tr>"
	w "</table></form>"

end if
%>
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->