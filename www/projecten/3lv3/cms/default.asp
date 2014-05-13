<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Lukas van 3L - CMS Login</title>
	<link rel="STYLESHEET" type="text/css" href="inc/style.css">
</head>

<body>
<p>&nbsp;</p>
<H1 align="center">3L CMS Inlog</H1>
<H2 align="center">&nbsp;
<%if request.querystring("fout") = "fout" then%>
L O E S E R ! !
<%end if%>
</H2>
<form action="actie.asp?actie=login" method="post" name="loginform">
<table width="200" align="center">
	<tr>
		<td>Naam:</td>
		<td><input type="text" name="naam" value="<%=request.cookies("3LCMSnaam")%>" size="20" maxlength="20"></td>
	</tr>
	<tr>
		<td>Wachtwoord:</td>
		<td><input type="password" name="wachtwoord" value="" size="20" maxlength="20"></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="log in"></td>
	</tr>
</table>
</form>

<%if request.cookies("3LCMSnaam") = "" then%>
<!-- dit script moet onder het formulier zelf geplaats worden -->
<script type="text/javascript" language="javascript">
	document.forms['loginform'].elements['naam'].focus();
</script>
<%else%>
<!-- dit script moet onder het formulier zelf geplaats worden -->
<script type="text/javascript" language="javascript">
	document.forms['loginform'].elements['wachtwoord'].focus();
</script>
<%end if%>


</body>
</html>
