<!-- #include virtual="/projecten/3lv3/cms/_top.asp" -->
<%
actie=request("a")

if actie="" then
	%>
	<p>&nbsp<p>Dit stukkie is gemaakt om teller databases over te pompen naar elkaar. Ofzo.<br>Leef je uit.
	<FORM METHOD=POST ACTION="overpompen.asp?a=1">
		<INPUT TYPE="text" NAME="db1" value="teller.mdb" class=button> moet opgenomen worden in: <INPUT TYPE="text" NAME="db2" value="teller1.mdb" class=button><INPUT TYPE="submit" value="hoppa!" class=button>
	</FORM>
	<%
elseif actie="1" then
	db1=request.form("db1")
	db2=request.form("db2")

	set ConnTelVol=Server.CreateObject("ADODB.Connection")
	ConnTelVol.Provider="Microsoft.ACE.OLEDB.12.0"
	ConnTelVol.Open "D:/www/3l.nl/database/"&db1

	set ConnTelLeeg=Server.CreateObject("ADODB.Connection")
	ConnTelLeeg.Provider="Microsoft.ACE.OLEDB.12.0"
	ConnTelLeeg.Open "D:/www/3l.nl/database/"&db2

	ConnTelVol.Execute("DELETE FROM tblTel WHERE ID=1")

	Set rsTelVol = ConnTelVol.execute("SELECT * FROM Tbltel ORDER BY ID ASC")
	do while NOT rsTelVol.EOF
		ConnTelLeeg.Execute("Insert into Tbltel (SessionID, Datum, Tijd, REMOTE_ADDR, REMOTE_HOST, PATH_INFO, HTTP_USER_AGENT, HTTP_REFERER) values('"&rsTelVol("SessionID")&"', '"&rsTelVol("Datum")&"', '"&rsTelVol("Tijd")&"', '"&rsTelVol("REMOTE_ADDR")&"', '"&rsTelVol("REMOTE_HOST")&"', '"&rsTelVol("PATH_INFO")&"', '"&rsTelVol("HTTP_USER_AGENT")&"', '"&rsTelVol("HTTP_REFERER")&"')")
	rsTelVol.MoveNext
	Loop 
	rsTelVol.Close 
	Set rsTelVol = Nothing 

	response.write "Het overpompen is succesvol beëindigd."
	response.redirect "http://www.3l.nl/cms"
end if%>
<!-- #include virtual="/projecten/3lv3/cms/_bottom.asp" -->