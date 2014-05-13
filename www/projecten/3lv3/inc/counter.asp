<%
' Om uw paginabezoek te tellen de volgende tekst toevoegen aan uw .asp pagina's:
' <!-- #include virtual="/inc/counter.asp" -->

Dim CounterSQL, CounterRs, CounterHits, NieuwSQL, DNS, pathinfo, referer
%><!-- #include file="../datateller.asp" --><%

set CounterRS = CounterDataConn.Execute("SELECT id FROM path_info WHERE path_info='"&Request.ServerVariables("PATH_INFO")&"'")
	pathinfo = CounterRS("id")
CounterRS.close
set CounterRS = nothing

referer = Request.ServerVariables("HTTP_REFERER")

if instr(referer, "3l.nl") <> 0 AND instr(referer, "google") = 0 OR trim(referer) = "http://home.planet.nl/~vdriel/start/" then
	NieuwSQL = "INSERT INTO TblTel (SessionID, REMOTE_ADDR, PATH_INFO) VALUES ("
	NieuwSQL = NieuwSQL & "'" & session.SessionID & " '" &", "
	NieuwSQL = NieuwSQL & "'" & Request.ServerVariables("REMOTE_ADDR") & "'" &", "
	NieuwSQL = NieuwSQL & "'" & pathinfo & "')"
else
	NieuwSQL = "INSERT INTO TblTel (SessionID, REMOTE_ADDR, PATH_INFO, HTTP_REFERER) VALUES ("
	NieuwSQL = NieuwSQL & "'" & session.SessionID & " '" &", "
	NieuwSQL = NieuwSQL & "'" & Request.ServerVariables("REMOTE_ADDR") & "'" &", "
	NieuwSQL = NieuwSQL & "'" & pathinfo & "'" &", "
	NieuwSQL = NieuwSQL & "'" & referer & "')"
end if

CounterDataConn.Execute(NieuwSQl)

Set CounterDataConn = nothing
%>