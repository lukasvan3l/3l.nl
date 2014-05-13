
			</td>
		<td width="1" bgcolor="ff6633"><img src="inc/blank.gif" width="1"></td>
		<td width="176" valign="top">
			<H1>Geblaat</H1>

<%
Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

sqlGast = "SELECT top 7 * FROM lukas ORDER BY datum desc, tijd desc"
Set rsGast = Conn.Execute(sqlGast)
Do while not rsGast.EOF

	w "<i><a href='mailto:" &rsGast("email")& "'>" &rsGast("naam")& "</a> "

	if rsGast("datum") = date() then
		w " (om " &rsGast("tijd")& ")</i><br>"
	else
		w " (op " &rsGast("datum")& ")</i><br>"
	end if

	w rsGast("bericht")
	w "<p align=center><img src='inc/ff6633.gif' width='171' height='1'></p>"

rsGast.MoveNext
Loop
rsGast.Close 
Set rsGast = Nothing 

%>

			<FORM METHOD=POST ACTION="actie.asp?actie=gastenboek" name="blaten" onSubmit="return checkFieldsBlaten();">
			Naam:<br>
			<INPUT TYPE="text" size="26" maxlength="25" NAME="naam" class="button" value="<%=request.cookies("3Lnaam")%>">
			E-mail:<br>
			<INPUT TYPE="text" size="26" maxlength="25" NAME="email" class="button" value="<%=request.cookies("3Lemail")%>">
			Bericht:<br>
			<TEXTAREA NAME="bericht" ROWS="4" COLS="25" class="button"></TEXTAREA><br>
			<img src="inc/blank.gif" width="113" height="1"><INPUT TYPE="submit" class="button" value="Reageer">
			</FORM>
			</td>
	</tr>
</table>

</BODY>
</HTML>