<%option explicit
dim conn%>
<!-- #include file="../../../inc/dbdriel.asp" -->

<HTML>
<HEAD>
<TITLE>Fotoalbum.3L.nl</TITLE>
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language=JavaScript>
window.defaultStatus = "Fotoalbum.3L.nl";

function MM_swapImgRestore() {
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() {
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) {
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() {
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function NewWindow(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//-->
</SCRIPT>
</HEAD>
<BODY onLoad="MM_preloadImages('inc/arrowleft2.gif','inc/arrowright2.gif')">

<table width=700 cellpadding=0 cellspacing=0 align=center>
	<tr>
		<td height=15 colspan=2></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2 colspan=2></td>
	</tr>
	<tr>
		<td align=center valign=center colspan=2><img src='inc/3lfotoalbum.gif'></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2 colspan=2></td>
	</tr>
	<tr>
		<td height=50 colspan=2></td>
	</tr>
	<tr>
		<td align=center colspan=2>

<%
Public Sub w(txt)
	Response.Write (txt & VBCRLF)
End Sub

dim actie, album, id
actie = Request("actie")
album = Request("album")
id = Request("id")


'Bij binnenkomst moejje alle fotoalbums op een rijtje zien in een iframe
if actie = "" then
	%>
	<table width=680 height=300 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td width=680 valign=top align=center>
			<IFRAME SRC="fotoalbum_lijst.asp" name="iframe" frameborder="0" height="300" width="680" noresize> </IFRAME>
		</td>
	</tr>
	</table>
	<%

'Van één album zie je alle thumbnails
elseif actie = "album" then
	dim rsFa, bericht
	%>
	<table width=680 height=300 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td width=435 valign=top align=center rowspan=2>
			<IFRAME SRC="fotoalbum_lijst.asp?id=<%=id%>" name="iframe" frameborder="0" height="300" width="435" noresize> </IFRAME>
		</td>
		<td valign=top height=230>
			<%
			set rsFa = Conn.Execute("SELECT * FROM fotoalbum WHERE id="&id)
			bericht = replace((rsFa.Fields.Item("bericht").Value), vbCRLF, "<BR>")
			%>
				<b><%=rsFa("titel")%>
				<br><%=rsFa("aantal")%> Foto's</b>
				<p><%=rsFa("datum")%>
				<p><%=bericht%>
			<%
			rsFa.close
			set rsFa=nothing
			%>
		</td>
	</tr>
	<tr>
		<td valign=bottom height=30 align=right>
			<a href="fotoalbum.asp">Lijst met fotoalbums</a>
		</td>
	</tr>
	</table>
	<%


'Van één album zie je elke keer één foto, net als in het log
elseif actie = "albumfoto" then
	dim rsFa2, bericht2, laatstefoto, links, rechts
	%>		
	<table width=680 height=300 cellpadding=0 cellspacing=0 border=0>
	<tr>

	<%
	set rsFa2 = Conn.Execute("SELECT * FROM fotoalbum WHERE id="&album)
	bericht2 = replace((rsFa2.Fields.Item("bericht").Value), vbCRLF, "<BR>")
	laatstefoto = rsFa2("aantal")	

	%>
		<td width=435 rowspan=3><img src='http://www.3l.nl/fotoalbum/<%=album%>/<%=id%>.jpg'></td>
		<td valign=top height=260 colspan=2>
			<b><%=rsFa2("titel")%>
			<br>(<%=id%> van <%=laatstefoto%>)</b>
			<p><%=rsFa2("datum")%>
			<p><%=bericht2%>
		</td>
	</tr>
	<%

	%>
	<tr>
		<td valign=bottom height=40>
	<%
			'PIJLTJE NAAR LINKS
			if id=1 then
				links=laatstefoto
			else
				links=id-1
			end if
	%>		
			<a href="fotoalbum.asp?actie=albumfoto&album=<%=album%>&id=<%=links%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('arrowleft','','inc/arrowleft2.gif',1)">
			<img src="inc/arrowleft.gif" name="arrowleft"></a>

	<%
			'PIJLTJE NAAR RECHTS
			if strComp(id, laatstefoto, 0)=0 then
				rechts=1
			else
				rechts=id+1
			end if
	%>
			<a href="fotoalbum.asp?actie=albumfoto&album=<%=album%>&id=<%=rechts%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('arrowright','','inc/arrowright2.gif',1)">
			<img src="inc/arrowright.gif" name="arrowright"></a>
		</td>
		<td align=right valign=bottom>
			<a href="fotoalbum.asp?actie=album&id=<%=album%>">Lijst met fotos</a> 
		</td>
	</tr>

	</table>

	<%
	rsFa2.close
	set rsFa2 = nothing

end if%>

		</td>
	</tr>
	<tr>
		<td height=50 colspan=2></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2 colspan=2></td>
	</tr>
	<tr>
		<td><A href="default.asp"><i>naar Fotolog.3l.nl</i></a></td>
		<td align=right><A href="../"><i>naar www.3l.nl</i></a></td>
	</tr>
</table>

</body>
</HTML>