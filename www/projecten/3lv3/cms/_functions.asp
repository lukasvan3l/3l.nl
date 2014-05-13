<!-- #include file="../databla.asp" -->
<%
dim id, actie, txt
id = Request("id")
actie = Request("actie")

Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub
%>