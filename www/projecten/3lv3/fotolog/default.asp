<%option explicit%>
<!-- #include file="../../../inc/dbdriel.asp" -->
<%
dim conn
Response.Expires=0 '0 is het aantal minuten dat de pagina in de cache wordt opgeslagen 
response.CacheControl="private" 'private geeft aan dat je pagina niet door proxy servers gecached wordt.
%>
<HTML>
<HEAD>
<TITLE>Fotolog.3L.nl</TITLE>
<LINK HREF="style.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language=JavaScript>
window.defaultStatus = "Fotolog.3L.nl";

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
		<td align=center valign=center colspan=2><img src='inc/3lfotolog.gif'></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2 colspan=2></td>
	</tr>
	<tr>
		<td height=50 colspan=2></td>
	</tr>
	<tr>
		<td align=center colspan=2>
		
<table width=680 height=300 cellpadding=0 cellspacing=0 border=0>
<tr>

<%
dim rsLaatste, laatstefoto, rsEerste, eerstefoto, id, rsFoto
dim rsReactie, gereageerd, links, rechts, fotologid, bericht

'HET ID VAN DE LAATSTE EN EERSTE FOTO OPHALEN
set rsLaatste = Conn.Execute("SELECT top 1 * FROM fotolog ORDER BY id desc")
	laatstefoto = rsLaatste("id")
rsLaatste.close
set rsLaatste = nothing

set rsEerste = Conn.Execute("SELECT top 1 * FROM fotolog ORDER BY id asc")
	eerstefoto = rsEerste("id")
rsEerste.close
set rsEerste = nothing

id = request("id")

'VERSCHILLENDE QUERYS VOOR DE BINNENKOMSTPAGINA EN VERVOLGPAGINAS
if id = "" then
	set rsFoto = Conn.Execute("SELECT top 1 * FROM fotolog ORDER BY id desc")
else
	set rsFoto = Conn.Execute("SELECT * FROM fotolog WHERE id="&id)
end if

bericht = replace((rsFoto.Fields.Item("bericht").Value), vbCRLF, "<BR>")
fotologid = rsFoto("id")
%>
	<td width=435 rowspan=3><img src='http://www.3l.nl/fotolog/<%=fotologid%>.jpg'></td>
	<td valign=top height=230>
		<b>(<%=fotologid%>) <%=rsFoto("titel")%></b>
		<p><%=rsFoto("datum")%>
		<p><%=bericht%>
	</td>
<%
rsFoto.close
set rsFoto = nothing

'AANTAL REACTIES TELLEN
set rsReactie = Conn.Execute("SELECT count(*) as aantal_reacties FROM fotoreactie where foto_id=" & fotologid)

if rsReactie("aantal_reacties") = 0 then
	gereageerd = "Reageer op deze foto!"
elseif rsReactie("aantal_reacties") = 1 then
	gereageerd = "Reeds één reactie"
else
	gereageerd = rsReactie("aantal_reacties")& " Reacties"
end if

%>

</tr>
<tr>
	<td valign=bottom align=right height=30>
	<a href='reactie.asp?id=<%=fotologid%>' onclick="NewWindow(this.href,'name','400','400','yes');return false;"><%=gereageerd%></a></td>
</tr>
<tr>
    <td valign=bottom height=40>
<%
		'PIJLTJE NAAR LINKS
		if eerstefoto=fotologid then
			links=laatstefoto
		else
			links=fotologid-1
		end if
%>		
		<a href="default.asp?id=<%=links%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('arrowleft','','inc/arrowleft2.gif',1)">
		<img src="inc/arrowleft.gif" name="arrowleft"></a>
<%
		'PIJLTJE NAAR RECHTS
		if id = "" or laatstefoto=fotologid then
			rechts=1
		else
			rechts=fotologid+1
		end if
%>
		<a href="default.asp?id=<%=rechts%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('arrowright','','inc/arrowright2.gif',1)">
		<img src="inc/arrowright.gif" name="arrowright"></a>
	</td>

</tr>

</table>

<%
rsReactie.close
set rsReactie = nothing
%>

		</td>
	</tr>
	<tr>
		<td height=50 colspan=2></td>
	</tr>
	<tr>
		<td bgcolor='#cccccc' height=2 colspan=2></td>
	</tr>
	<tr>
		<td><A href="fotoalbum.asp"><i>naar Fotoalbum.3l.nl</i></a></td>
		<td align=right><A href="../"><i>naar www.3l.nl</i></a></td>
	</tr>
</table>

</body>
</HTML>