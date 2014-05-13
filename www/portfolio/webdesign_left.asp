<!-- #include file="../inc/dbdriel.asp" -->

<HTML>
<HEAD>
<TITLE>Lukas van 3L</TITLE>

<style type="text/css">
BODY{
	font-family: verdana;
	font-size: 11;
	color: #000000;
	margin-left: 0;
	margin-right: 0;
	margin-top: 0;
	margin-bottom: 0;
	}

A	{
	font-family:verdana;
	font-size:11;
	color: #333333; 
	text-decoration: none; 
	font-weight: bold;
	}

A:HOVER {
	color : #660099;
	}

img {
	border-width: 2px;
	border-color: #663399;
	}
</style>

<script language="JavaScript" type="text/JavaScript"><!--
window.defaultStatus = "Lukas van 3L";

function MM_preloadImages() {
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() {
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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
//--></SCRIPT>

</HEAD>
<BODY>
<center>

<%
sql = "SELECT * FROM portfolio ORDER BY id desc"
set rsPf = Conn.Execute(sql)
Do while not rsPf.EOF

response.write "<a href='webdesign_right.asp?id="&rsPf("id")&"' target=uitleg>"
response.write "<img src='website_t/"&rsPf("id")&".jpg'></a><br><img src='img/blank.gif' height=20><br>"

rsPf.MoveNext
Loop
rsPf.Close 
Set rsPf = Nothing 
%>

</center>
</BODY>
</HTML>