<!-- #include virtual="/projecten/3lv3/lukas/_top.asp" -->

<%
actie = Request("actie")
if actie = "" then
	%>

	<H1>Over Lukas</H1>

	Welkom op 3L.nl.<br>
	Deze site is eigenlijk opgericht om de weblog. Maar daar omheen zijn nog enkele onderdelen gemaakt, zoals dit stukje over mijzelf.<p>

	Je vind hier informatie over mijn leventje, over mijn hobby's en surfgedrag. Ik hoop hier later nog iets interessants neer te zetten. Maar daar kan je lang op blijven wachten.<p>

	In het linker stukkie staan een paar subpagina's van dittum. Leef je uit.

	<%






elseif actie = "fietsen" then
%>
	<H1>Fietsen</H1>
	<center><img src="inc/fietsen.jpg"></center><p>
	Velen van jullie zullen ongetwijfeld weten dat ik nogal fiets. Van enkele van die leuke vakanties heb ik digitale dagboeken liggen, die hier uiteraard te lezen zijn:

	<p>
	<center><img src='inc/ff6633.gif' width='300' height='1'></center>
	<p>
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td><a href="santiago/index.htm" target=_blank>Santiago de Compostella (2000)</a></td>
		<td align=right><img src="inc/fietsen_santiago.jpg"><br>&nbsp</td>
	</tr>
	<tr>
		<td><a href="dordogne/index.htm" target=_blank>Dordogne & Ardeche (2002)</a></td>
		<td align=right><img src="inc/fietsen_dordogne.jpg"></td>
	</tr>
	</table>

	<%






elseif actie = "hardlopen" then
	%>

	<H1>Hardlopen</H1>
	<center><img src="inc/hardlopen.jpg"></center><p>
	Het zit in m'n genen. Ik kán gewoon niet anders. Mijn zus traint 5 keer per week, m'n ouders hebben allebij de marathon al gedaan en ik ben als buitenbeentje enkel op wedstrijden te vinden. Trainen is niets voor mij.
	<p>De 5 kilometer heb ik in 19 minuten gelopen, en de 10 kilometer in 40:15. Langere afstanden heb ik mij nog niet aan gewaagd. Staat wel in de planning, maar voorlopig nog niet.<br>
	<p><center><img src='inc/ff6633.gif' width='300' height='1'></center><p>
	Trainen doe ik eigenlijk alleen voor de <a href="http://www.marathon.nl" target=_blank>Leiden Marathon</a> waar ik dan ook elk jaar weer een persoonlijk record loop.<p> Verder doe ik mee aan het <a href="http://home.concepts-ict.nl/~dockhorn/zorgenzekerheid/LopenFrame.htm" target=_blank>Zorg en Zekerheid-circuit</a>, een circuit met 7 lopen doorheen het harloopseizoen. <p>Daarnaast zijn er nog allerlei andere wedstrijden zoals de City-pier-city, Golden Ten-loop, Zevenheuvelen en natuurlijk onze eigen Kulker-Cup.
	<%




elseif actie = "skaten" then
	%>

	<H1>Skaten</H1>
	<center><img src="inc/skaten.jpg"></center><p>
	Leiden heeft een ontzettend gezellige skate-vereniging, <a href="http://www.skateology.org" target=_blank>Skateology</a>. Sinds juli '03 ben ik hier lid van en sinds september zelfs financieel coördinator!<p>
Mocht je ook van skaten houden, kom dan dinsdagavond (mits het droog is) naar de Beestenmarkt in Leiden. Rond een uurtje of 8 vertrekken we daar voor een lekker skatetochtje met iedereen die maar mee wil doen. Tot dan!
	<%




elseif actie = "films" then
	%>
	<H1>Films & MP3</H1>
	Mocht ik eens de tijd hebben om mij te vervelen, kan ik een graai doen in m'n heerlijke filmverzameling. Mochten jullie dat willen doen, dan komt hier binnenkort een lijstje met films die je bij me kan lenen. <p>
	Hoe binnenkort kom je nog wel achter.
	<%




elseif actie = "links" then
%>
	<H1>Internet Links</H1>
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td valign=top>
		<b>Webloggers</b>:<p>
		<a href="http://www.mhuu.nl" target=_blank>Mhuu</a><br>
		<a href="http://fret.mhuu.nl" target=_blank>Koesper.mhuu.nl</a><br>
		<a href="http://www.egodrama.com" target=_blank>Egodrama</a><br>
		<a href="http://www.doucheputje.com" target=_blank>Doucheputje</a><br>
		<a href="http://www.suusje.com" target=_blank>Suusje</a><br>
		<a href=""></a><br>
		</td>
		<td valign=top>
		<b>Vrienden</b>:<p>
		<a href="http://www.sanderspies.nl" target=_blank>Sanderspies.nl</a><br>
		<a href="http://www.sperdegroot.nl" target=_blank>C@sperdegroot.nl</a><br>
		<a href="http://www.marov.nl/" target=_blank>Marov.nl</a><br>
		<a href="http://www.haaguit.nl" target=_blank>Haag Uit 2003</a><br>
		<a href=""></a><br>
		</td>
	</tr>
	<tr>
		<td valign=top>
		<b>Nuttelloos</b>:<p>
		<a href="http://www.ikbendom.com" target=_blank>Ik ben dom .com</a><br>
		<a href="http://www.groenbrothers.com" target=_blank>Groenbrothers</a><br>
		<a href="http://www.kabaal.net/" target=_blank>Kabaal.net</a><br>
		<a href="http://www.playplay.be" target=_blank>Playplay.be</a><br>
		<a href=""></a><br>
		</td>
		<td valign=top>
		<b>Nuttelvol</b>:<p>
		<a href="http://www.nu.nl" target=_blank>Nu.nl</a><br>
		<a href="http://zoekopnummer.ath.cx/" target=_blank>Zoeken op telefoonnummer</a><br>
		</td>
	</tr>

	</table>
	<%







elseif actie = "contact" then
	%>

	<H1>Contact</H1>
	<center><img src="inc/contact.jpg"></center><p>
	Je kan mij natuurlijk altijd een <a href="mailto:lukas@3l.nl">mailtje sturen</a>.<p>
	Maar voor degene die er écht werk van willen maken, kunnen dit formuliertje invullen.<p>
	Veel plezier!

	<FORM METHOD=POST ACTION="actie.asp?actie=contact" name="reactie" onSubmit="return checkFieldsReactie();">
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>Naam:</td>
		<td><INPUT TYPE="text" NAME="naam" class=button size=26 maxlength="50"></td>
	</tr>
	<tr>
		<td>E-mail:</td>
		<td><INPUT TYPE="text" NAME="email" class=button size=26 maxlength="50"></td>
	</tr>
	<tr>
		<td valign=top>Blaat:</td>
		<td><TEXTAREA NAME="bericht" ROWS="10" COLS="25" class=button></TEXTAREA></td>
	</tr>
	<tr>
		<td></td>
		<td><br><INPUT TYPE="submit" value="Kommaar op!" class=button></td>
	</tr>
	</table>
	</FORM>
	<%




elseif actie = "contactbedankt" then
	%>
	<H1>Contact</H1>
	<center><img src="inc/contact.jpg"></center><p>
	Bedankt voor het opsturen van dit formuliertje.
	<%


end if
%>

<!-- #include virtual="/projecten/3lv3/_bottom.asp" -->