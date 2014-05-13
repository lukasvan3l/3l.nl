<%
Option Explicit
Select Case request.ServerVariables("HTTP_HOST")

Case "3l.nl" response.redirect("weblog.asp")
Case "www.3l.nl" response.redirect("weblog.asp")
Case "weblog.3l.nl" response.redirect("weblog.asp")
Case "portfolio.3l.nl" response.redirect("/portfolio/")
Case "fotolog.3l.nl" response.redirect("/fotolog/")
Case "lukas.3l.nl" response.redirect("/lukas/")

Case "dzb.3l.nl" response.redirect("/projecten/dzb/")
Case "g4g.3l.nl" response.redirect("/projecten/g4g/")
Case "src.3l.nl" response.redirect("/projecten/src/")
Case "delise.3l.nl" response.redirect("/projecten/delise/")
Case "haaguit.3l.nl" response.redirect("/projecten/haaguit/")

End Select
%>

<html>

<HEAD>
<TITLE>Lukas van 3L</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="lukas@3l.nl">
<META NAME="Description" CONTENT="Lukas van 3L presenteert zich: Weblog, Fotoalbum en Portfolio">
<META NAME="Keywords" CONTENT="Lukas van 3L, Lukas van Driel, Lukas, 3L, Luckylukie, Lucky_lukie, lukasvandriel, lukasvdriel, portfolio, weblog, Mhuukas, mhuu, mhuuen, mhuu-en, fotolog">

<SCRIPT language=JavaScript>
window.defaultStatus = "3L.nl";
</SCRIPT>

</HEAD>
<BODY>

Ik, Lukas van 3L, heb hier een websiteje opgezet. Deze site bevat een fotolog, weblog, gastenboek, portfolio en allerlei projectjes er omheen. Veel plezier met rondkijken en Mhuu maar raak!

</BODY>
</HTML>