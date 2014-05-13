
			</td>
		<td width="1" bgcolor="#ff6633"><img src="inc/blank.gif" width="1"></td>
		<td width="176" valign="top">
			<H1>Geblaat</H1>
<div id="geblaat">
<%
dim rsGast
Set rsGast = Conn.Execute("SELECT top 7 * FROM geblaat ORDER BY datum desc, tijd desc")
Do while not rsGast.EOF

	response.write("<i><a href='mailto:" &rsGast("email")& "' title='mail "&rsGast("naam")&"'>" &rsGast("naam")& "</a> ")

	if rsGast("datum") = date() then
		response.write(" (om " &rsGast("tijd")& ")</i><br>")
	else
		response.write(" (op " &rsGast("datum")& ")</i><br>")
	end if

	response.write(left(rsGast("bericht"),300))
	response.write("<p align=center><img src='inc/ff6633.gif' width='171' height='1'></p>")

rsGast.MoveNext
Loop
rsGast.Close 
Set rsGast = Nothing 
%>
</div>
			<FORM METHOD=POST ACTION="actie.asp?actie=gastenboek" name="blaten" onSubmit="return checkFieldsBlaten();">
			Naam:<br>

			<%if IsNull(request.cookies("3Lnaam")) = true then%>
				<INPUT TYPE="text" size="26" maxlength="25" NAME="naam" class="button">
				E-mail:<br>
				<INPUT TYPE="text" size="26" maxlength="25" NAME="email" class="button">
			<%Else%>
				<INPUT TYPE="text" size="26" maxlength="25" NAME="naam" class="button" value="<%=request.cookies("3Lnaam")%>">
				E-mail:<br>
				<INPUT TYPE="text" size="26" maxlength="25" NAME="email" class="button" value="<%=request.cookies("3Lemail")%>">
			<%End if%>
			Bericht:<br>
			<TEXTAREA NAME="bericht" ROWS="4" COLS="25" class="button"></TEXTAREA><br>
			<img src="inc/blank.gif" width="113" height="1"><INPUT TYPE="submit" class="button" value="Blaat!">
			</FORM>

			<font color="#ffffff">Een aantal steekwoorden die deze website beschrijven zijn: Weblog, 3L, Lukas van 3L, mhuukas, Lukas van Driel, weblog, webdesign, Lukas, 3L, portfolio, weblog, onzin, geblaat, Mhuukas, mhuu, fotolog, fotoalbum, weblog. Dat was het wel weer.</font>

			</td>
	</tr>
</table>

</BODY>
</HTML>