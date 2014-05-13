<% option explicit %>
<!-- #include virtual="/projecten/3lv3/_top.asp" -->

<%
response.expires=0 '0 is het aantal minuten dat de pagina in de cache wordt opgeslagen 
response.CacheControl="private" 'private geeft aan dat je pagina niet door proxy servers gecached wordt.
%>

<H1>Weblog</H1>

<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">

<%
dim id, rsLog, bericht, rsLog2, reactietxt
id = Request("id")

if id > "2002" then
	if id = "2004" then
		Set rsLog = Conn.Execute("SELECT * FROM log WHERE datum < #01-01-2005# AND datum >= #01-01-2004# ORDER BY datum desc, tijd desc")
	elseif id = "2003" then
		Set rsLog = Conn.Execute("SELECT * FROM log WHERE datum < #01-01-2004# AND datum >= #01-01-2003# ORDER BY datum desc, tijd desc")
	end if

	Do while not rsLog.EOF

		bericht = replace((rsLog.Fields.Item("bericht").Value), vbCRLF, "<BR>")
		bericht = Replace(bericht, ":D", "<img src=http://www.3l.nl/inc/smilies/biggrin.gif>")
		bericht = Replace(bericht, ":&#40", "<img src=http://www.3l.nl/inc/smilies/frown.gif>")
		bericht = Replace(bericht, ":&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
		bericht = Replace(bericht, ":-&#41", "<img src=http://www.3l.nl/inc/smilies/smile.gif>")
		bericht = Replace(bericht, "&#59&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
		bericht = Replace(bericht, "&#59-&#41", "<img src=http://www.3l.nl/inc/smilies/wink.gif>")
		bericht = Replace(bericht, ":P", "<img src=http://www.3l.nl/inc/smilies/tongue.gif>")


		w "<tr><td width='180' class='logtitel'>" &rsLog("titel")
		w "</td><td width='160' class='logdatum'>" &rsLog("datum")& "<br>" &rsLog("tijd")& "</td></tr>"
		w "<tr><td colspan='2' class='logbericht'>" &bericht& "</td></tr>"
		w "<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=" &rsLog("id")& " style='reageren'>"
			
		Set rsLog2= Conn.Execute("SELECT count(*) as aantal_reacties FROM reactie where log_id=" & rsLog("id"))
		if rsLog2("aantal_reacties") = 0 then
			reactietxt = "Reageer als eerste!"
		elseif rsLog2("aantal_reacties") = 1 then
			reactietxt = "Reeds één reactie, reageer ook!"
		else
			reactietxt = rsLog2("aantal_reacties")& " reacties, reageer je mee?"
		end	if

		w reactietxt& "</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>"

		rsLog2.Close 
		Set rsLog2 = Nothing 

	rsLog.MoveNext
	Loop
	rsLog.Close 
	Set rsLog = Nothing 

elseif id = "2002" then
%>
	<table width="340" border="0" cellspacing="0" cellpadding="0" align="center">

	<tr><td width='180' class='logtitel'>Finishing touch
	</td><td width='160' class='logdatum'>30-12-2002<br>19:49:48</td></tr>
	<tr><td colspan='2' class='logbericht'>Mijn <a href=http://www.3l-online.tk>website</a> is bezig met de finishing touches. Zo heb ik <a href=http://www.3l.nl/lukas/santiago/index.htm>mijn fietsdagboek</a> van Santiago weer helemaal in styl gemaakt met foto&#39s en al, en wilde ik dat ook gaan doen voor het dagboek van m&#39n <a href=http://www.3l.nl/lukas/dordogne/>2002 fietsvakantie</a>. Maar die blijkt nog helemaal niet vol te zijn! ik mis nog een heleboel dagen!<BR>Eerst maar eens de dagen die ik mis er bij schrijven, en daarna komt dat dagboek ook online. Met foto&#39s, of course.</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=56 style='reageren'>
	Reageer als eerste!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Nieuwjaarsduik
	</td><td width='160' class='logdatum'>30-12-2002<br>1:23:30</td></tr>
	<tr><td colspan='2' class='logbericht'>Ik krijg net te horen dat je je kan voorinschrijven voor de Unox Nieuwjaarsduik dit jaar! <BR><BR>En aangezien wij ALLEMAAL aan dit evenement gaan deelnemen, meld ik het hier eventjes. Op <a href=http://www.nieuwjaarsduik.nl>www.nieuwjaarsduik.nl</a> kun je je inschrijving uitprinten zodat je deze bij de duik zelf niet in hoeft te vullen.<BR><BR>C u there!<BR><BR><a href=http://www.nieuwjaarsduik.nl><img src=http://www.3l.nl/fotos//nieuwjaarsduik.jpg></a></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=55 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Oliebollenloop
	</td><td width='160' class='logdatum'>29-12-2002<br>21:21:15</td></tr>
	<tr><td colspan='2' class='logbericht'>Afgelopen vakantie heb ik mijn knieën vernacheld tijdens m&#39n fietsvakantie in de Dordogne en Ardeche. Sindsdien heb ik niet meer hardgelopen (wel gefietst). Tot vandaag...<BR><BR>Vanochtend was de Oliebollenloop in Leiden. Zó dichtbij, dat mag ik niet missen. Dus ik ben er toch maar voor gegaan, en zowaar hebben m&#39n knieën de vijf kilometer gehouden. Weliswaar in 23 minuten, maar toch.<BR><BR>Nou moet ik de komende paar weken even flink m&#39n spieren weer aansterken en flink trainen. Kijken hoe lang ik dat volhou, want ik ben eigenlijk alleen voor wedstrijden en niet zo voor het trainen daarnaast ;)<BR><BR>26 Januari is m&#39n volgende wedstrijd, die moet weer binnen de 21!!<BR><BR><b>Updeet: ik heb spierpijn!!!!</b></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=54 style='reageren'>
	Reageer als eerste!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Break Out 360
	</td><td width='160' class='logdatum'>28-12-2002<br>17:59:32</td></tr>
	<tr><td colspan='2' class='logbericht'><a href=http://www.skybox.org/breakout/>Een nieuw spelletje</a> om de kerstdagen door te komen.</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=53 style='reageren'>
	9 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>OV-Jaarkaart
	</td><td width='160' class='logdatum'>28-12-2002<br>1:49:21</td></tr>
	<tr><td colspan='2' class='logbericht'>Elk jaar is het weer een probleem. Dan heb je je OV weer niet op tijd opgehaald. En het postkantoor is natuurlijk maar 2 uurtjes per dag open, juist de tijdstippen dat de normale student in bed ligt...<BR><BR>En als je er eenmaal staat  ben je natuurlijk je paspoort en twee pasfoto&#39s vergeten :( Nou, inmiddels heb ik weer vier pasfoto&#39s er bij (stervesdure dingen!) en m&#39n paspoort weer opgeduikeld. Maar toen ik daar eenmaal mee klaar was, was het postkantoor alweer dicht. Morgen nog een keer proberen. Als dat ding op zaterdag wel open is<BR><BR><table><tr><td align=right width=50%>ps. m&#39n haarkleur<br> is hier paars :S</td><td><img src=http://www.3l.nl/fotos//ovfoto.jpg></td></tr></table></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=52 style='reageren'>
	5 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Kerstdiner numero uno
	</td><td width='160' class='logdatum'>26-12-2002<br>1:44:58</td></tr>
	<tr><td colspan='2' class='logbericht'>Elk jaar proberen we het weer. De nieuwe aanhang die voor het eerst op het jaarlijkse Kulker-kerstdiner aanwezig is schotelen we voor met een traditie. Een traditie die al jaren op het program staat. Een traditie die vandaag voor het eerst is volbracht. Die traditie houd in dat de nieuwe aanhang een gedichtje moet voorlezen, of een verhaaltje, of een toneelstukje of een muziekstukje, maakt niet uit.<BR><BR>Vorig jaar was Mark aan de beurt, Nicole d&#39r tijdelijke vlam. Hij was uiteindelijk zó nerveus dat we het hem niet aan gedaan  hebben om het door te zetten. Maarja, dit figuur heeft het daarna ook niet lang meer gemaakt binnen de Kulker Familie. Twee maanden later was-ie pleite.<BR><BR>Hester was dit jaar voor het eerst op het kerstdiner. Samen met Ivo, de nieuwe vriend van Yildiz. Deze twee hebben samen een hartstikke leuk spelletje met ons gespeeld, en zo de harten van alle Kulkertjes gewonnen. Het spel ging als volgt.<BR>Hester en Ivo verzonnen het begin van een kerstverhaaltje. Wij (de andere 25 man in  de kamer) moesten dan de rest verzinnen, door omstebeurt, van links naar rechts, een paar zinnen aan het verhaal toe te voegen.<BR><BR>De creatieve geesten werden flink aan het werk gezet en er ontstond een hartstikke leuk verhaal over houte benen gemaakt van kreupelhout en het Jezuskruis dat met koper zó gemaakt was dattie ontzettend schitterde en... we hebben gelachen :)<BR><BR>Hester en Ivo, welkom tot de Kulker-familie :D<BR><BR>(ps. bij gebrek aan digitale camera duurt het nog ff voor de foto&#39s er zijn)</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=51 style='reageren'>
	Reageer als eerste!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Nationale Wetenschapsquiz
	</td><td width='160' class='logdatum'>25-12-2002<br>0:34:05</td></tr>
	<tr><td colspan='2' class='logbericht'>Vanavond was de jaarlijkse Wetenschapsquiz weer op de buis te volgen. Geboeid heb ik ernaar gekeken en lekker ingewikkeld mee zitten denken. En het heeft zijn vruchten afgeworpen, die-met-die-duikboot had ik goed :D<BR><BR>Heb je de vragen gemist? <a href=http://noorderlicht.vpro.nl/wetenschap/nwq/index.shtml?3626936+3837523>Hier</a> kan je ze nogmaals voorgeschoteld krijgen. En als je die-met-die-duikboot nog niet snapt, wil ik hem je best uitleggen!<BR><BR><a href=http://noorderlicht.vpro.nl/wetenschap/nwq/index.shtml?3626936+3837523><img src=http://www.3l.nl/fotos//nwq.gif></a></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=50 style='reageren'>
	6 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>the irony of it all
	</td><td width='160' class='logdatum'>24-12-2002<br>14:35:52</td></tr>
	<tr><td colspan='2' class='logbericht'><I>It really bugs me when people try and tell me i&#39m a thug. <BR>Just for getting drunk.<BR>I like getting drunk!<BR>I&#39m an upstanding citizen<BR>If the war came along,<BR>i&#39d be on the front line with &#39em<BR><BR>Now Terry, you&#39re repeating yourself. <BR>But that&#39s OK, drunk people can&#39t help that.<BR>A chemical reaction in your brain causes you to forget what you&#39re saying. <BR><BR>What?!?! I know exactly what i&#39m saying<BR>I&#39m perfectly sane<BR>You stinkin&#39 student lame-o!<BR><BR>© <a href=http://www.the-streets.co.uk/>The Streets</a></I><BR><BR><img src=http://www.3l.nl/fotos//streets.jpg></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=49 style='reageren'>
	Reageer als eerste!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Schizofrenie
	</td><td width='160' class='logdatum'>23-12-2002<br>20:56:27</td></tr>
	<tr><td colspan='2' class='logbericht'>Wat vinden jullie van mijn nieuwe <a href=http://www.mhuu.nl/mhuukas/3lonline>homepage design</a>?<BR>Binnenkort zal deze mijn huidige <a href=http://www.3l-online.tk>3L Online</a> vervangen.<BR><i>update: 3L Online is inmiddels al vervangen</i><BR><BR>Het ontwerp is ontleend aan de moeder van m&#39n vriendin, die met veel zelflol meldde dat ik m&#39n oranje kleding niet aan kan doen nu ik een paarse haarkleur heb. Nou, DUS WEL!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=48 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Digitale camera
	</td><td width='160' class='logdatum'>22-12-2002<br>19:23:50</td></tr>
	<tr><td colspan='2' class='logbericht'>7 Maanden geleden heb ik een digitale camera geleend van de buurman, Sjaak. <BR>Gisterochtend om 11 uur &#39s ochtends haalde m&#39n moeder me uit m&#39n REM-slaap.<BR><BR>"Sjaak staat voor de deur, hij wil z&#39n camera terug!" Na zeven maanden had hij hem eindelijk een keertje nodig. Momenteel vertoon ik enige ontwenningsverschijnselen. Gister vleesfonduën, vandaag nieuw haarkleurtje, en ik kan het allemaal niet vastleggen met een digitaal kiekje. <BR><BR>Gelukkig is m&#39n vader van plan om een camera&#39tje te kopen via z&#39n werk. Hij heeft er eentje nodig voor een opdracht, en als die opdracht dan klaar is, staat die camera daar ongebruikt, en beland-ie in mijn schoot :) Maarja, da&#39s pas in eind januari. </td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=47 style='reageren'>
	3 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Vakantie!
	</td><td width='160' class='logdatum'>21-12-2002<br>3:25:49</td></tr>
	<tr><td colspan='2' class='logbericht'>Yeah, het is eindelijk zover! Twee weken lang geen reet uitvoeren, op m&#39n luie aars vertoeven en heeeel lang uitslapen. Zoals je ziet zit vroeg naar bed gaan er niet helemaal bij inbegrepen, maar anders heb ik niets om van bij te komen als school weer begint. <BR><BR>Bij deze; iedereen fantastische vakantie gewenst, en degene die ik hierdoor minder ga zien mis ik nu al (Sommigen ervan dan ;-) ). Owh en Job en Boers; bedankt voor een gezellig uurtje kroeg ;)<BR><BR>Welterusten!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=46 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Zweet
	</td><td width='160' class='logdatum'>20-12-2002<br>1:19:16</td></tr>
	<tr><td colspan='2' class='logbericht'>Ik wordt er bijzonder vaak mee geconfronteerd dat ik een redelijk "aanwezige" lichaamsgeur heb. Vooral m&#39n zus valt elke keer flauw als ze me &#39s ochtends net uit bed tegenkomt. Hester weet het nog enigszins voor zich te houden, maar ze blijft wel verdacht lang buiten bewustzijn &#39s ochtends...<BR><BR>Vanavond merkte ik het zowaar zelf op! Daar hing ik, vasthoudend aan een paar uitsteeksels aan een muur, op 15 meter hoogte te overdenken hoe ik de volgende meters ging overbruggen. Ik weet niet of het inspanningszweet of angstzweet was maar het was iig een flink sterke odeur. <BR><BR>Van flauwte liet ik los en lazerde bijna de 15 meter naar beneden, ware het niet dat ik nog aan een touwtje vastzat met aan het andere end Hester die mij netjes in de lucht hield. Talk about je leven in iemand anders handen geven!!<BR><BR>Ik ga echt vaker klimmen!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=45 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Dumb and Dumberer
	</td><td width='160' class='logdatum'>19-12-2002<br>0:22:26</td></tr>
	<tr><td colspan='2' class='logbericht'>Naast Bad Boys II en Terminator III en Harry Potter II en weetikveel hoeveel vervolgfilms er zijn, komt er nu een "Dumb and Dumberer" uit!!<BR><BR>Wie herinnert zich niet de twee mafkezen die op een scootertje achter een vrouw aangingen en dat eentje met z&#39n tong aan de skilift bleef zitten? Geweldige grandioze film. En als ik de <a href="http://www.apple.com/trailers/newline/dumb_and_dumberer/dumb_trl_high.html" target=_blank>trailer</a> van de film bekijk, dan issie toch verdacht mhuu-niveau! <BR><BR>Job, op naar de bios!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=44 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Kerstkaarten
	</td><td width='160' class='logdatum'>17-12-2002<br>22:41:40</td></tr>
	<tr><td colspan='2' class='logbericht'>Jaren en jaren heb ik niets aan kerstkaarten gedaan. Af en toe kreeg ik er wel eentje van een goedgehumeurde vriendin, maar zelf nooit iets verstuurd. Burgelijke onzin allemaal!<BR><BR>Dit jaar heb ik het anders gedaan, omdat het me leuk leek om een hele mooie kaart te maken. Naar mijn mening is dat niet geheel gelukt, maar Hester begon m&#39n gepunnik achter die pc flink zat te worden...<BR><BR>Uiteindelijk ben ik dan toch ook maar het burgelijke pad in geslagen. Tot grote ergernis van mijn lieve zussie ;) Nou Lin, die kaart kan je dus wel op je buik schrijven!<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/kerstkaart.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=43 style='reageren'>
	5 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Netjes
	</td><td width='160' class='logdatum'>17-12-2002<br>0:18:13</td></tr>
	<tr><td colspan='2' class='logbericht'>GODVERGETENGATVERDAMME!<BR><BR>Nette pakken zijn echt NIET voor mij weggelegd. Elk jaar moet ik er een of twee keer aan geloven tijdens een diner of gala. Dat houdt het spannend en leuk!<BR><BR>Afgelopen sinterklaas heb ik zelf een pak gekregen en vandaag was dé dag. Voor het eerst ging ik mij erin hijsen!<BR><BR>Eerst de broek. Dan het overhemd, gilet, colbertjas, sokken, blinkende schoenen, stropdas wil godver nie lukken, likkie gel in m&#39n haar, dat moet &#39m toch zijn.<BR>Na een blik naar buiten toch nog maar een lange loodzware jas aan, sjaal om m&#39n nek en een stevige paraplu mee. Op naar de bus, want met zo&#39n bepakking ga ik dus NIET fietsen.<BR><BR>Een half uur later klop ik uiteindelijk bij m&#39n vriendin aan. Eerst staat ze vijf minuten stomverbaast in de deuropening en dan "ken ik jou?". Na een kopje thee wil je toch eigenlijk wel lekker naast elkaar op de bank gaan zitten. Benen netjes naast elkaar want een ander standje is gewoon niet mogelijk met die gigantische klompen aan m&#39n poten. <BR>Een arm om haar heen slaan => gilet scheurt uit. Lekker onderuit gaan zitten => gilet scheurt uit. NIETS KAN gewoon!<BR>We zijn &#39s avonds een filmpje gaan kijken, en ik heb de hele avond gewoon rechtop op de bank gezeten :( <BR><BR>Een pak is leuk, maar hou hem voor speciale gelegenheden. Nooit zomaar thuis of bij iemand anders thuis aan gaan doen, hoe trots je ook op dat pokke-ding bent!<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/kerstbal.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=42 style='reageren'>
	6 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Sint z&#39n laatste feest
	</td><td width='160' class='logdatum'>16-12-2002<br>0:26:16</td></tr>
	<tr><td colspan='2' class='logbericht'>Relaxed onderuitgezakt, met een buik vol pepernoten, chocola en marsepein, zit ik de gezellige avond te overdenken.<BR><BR>Leuke cadeau&#39s gingen er over en weer, vergezeld van prachtige bouwwerken als surprise en mooie gedichten.<BR>Zo heb ik van Johan een huis gekregen, gemaakt van luciferhoutjes. Onder de vloerplanken was heel sneaky een supervette Parker-pen verstopt met &#39Lukas&#39 erin gegraveerd.<BR><BR>Toevalligerwijs had ik Johan op mijn lootje staan, en voor hem heb ik ook een soort huis gebouwd. &#39Gonneke&#39s Palace&#39 heette de tent. De rest kunnen insiders wel raden... <BR>Maar ik ben beter in dichten dan in surprises, en <a href="http://home.wxs.nl/~vdriel/fotos/gedicht.htm" target=_blank>hier</a> kun je m&#39n gedichie aan Johan nog eens nalezen.<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/huis.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=41 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Tandarts
	</td><td width='160' class='logdatum'>15-12-2002<br>14:30:17</td></tr>
	<tr><td colspan='2' class='logbericht'>Vorige week ben ik voor m&#39n halfjaarlijks bezoekje naar de tandarts geweest. Zo op het eerste gezicht geen problemen, maar hij heeft toch maar een foto gemaakt.<BR><BR>Kom ik vandeweek thuis, ligt er een briefje; "Tandarts terugbellen! Afspraak maken voor 20 minuten" Uh-oh!<BR><BR>Blijkt dat ik een tand teveel heb! Op een plekkie achterin m&#39n grote muil zit een verstandskies die door wil komen maar niet kan omdat er een andere kies in de weg zit. Nu komt die verstandskies er maar gewoon naast zitten, wat er bijzonder vreemd uit ziet. Ik heb een gewone kies, en dan komt daarboven nog een verstandskies door aan de zijkant van m&#39n tandvlees.<BR><BR>Trekken die hap! </td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=40 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Nijntje krijgt boete
	</td><td width='160' class='logdatum'>12-12-2002<br>16:35:51</td></tr>
	<tr><td colspan='2' class='logbericht'>Een verontrustend krantenbericht in de spits vandaag! Eenofandere commissie wil Nijntje 18.000 €urotjes aftroggelen. En dat omdat ze aan &#39merchandizing&#39 zouden doen in &#39een aflevering in april&#39.<BR><BR>Ik vind dat dit NIET moet kunnen! Nijntje heeft bestaansrecht, en daarbij is het heel goed om kinderen in een vroeg stadium al allerlei Nijntje-troep aan te smeren. En als ze dan helemaal Nijntje-verslaafd zijn, dan is de markt klaar voor de grote slag.<BR><BR>Nijntje-sigaretten, Nijntje brommers, Nijntje schoenen (maat 46!!), en natuurlijk de gigantische Nijntje broeken maat VeelsteXTRALarge. Dát is wat Nijntje nodig heeft! Een flinke dosis publiciteit en een verandering van doelgroep. Ik ben voor!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=39 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Dikke LUL!
	</td><td width='160' class='logdatum'>11-12-2002<br>23:18:22</td></tr>
	<tr><td colspan='2' class='logbericht'>ASP breng zulke leuke stemmingen naar boven! Als je de ene na de andere onbegrijpelijke foutmelding krijgt (believe me; i&#39ve seen them all) is dat zoooooo frustrerend!<BR><BR>Maarrrr mocht het onverhoopt toch werken schiet je ego de lucht in van pure opwinding!<BR>Vanmiddag was zo&#39n middag. Na een hele reeks foutmeldingen eindelijk het gewenste resultaat eruit, geweldig! <BR><BR><a href="http://delise.mhuu.nl" target=_blank>Delise</a> is nog niet helemaal af, maar er ligt een hele nette basis! Nu nog afmaken en dan is er weer een volwaardige Mhuu site erbij! Powered by Mhuukas© =-D</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=38 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>T begint frisjes te worden...
	</td><td width='160' class='logdatum'>9-12-2002<br>23:11:53</td></tr>
	<tr><td colspan='2' class='logbericht'>Ik las in de krant dat er in het noorden en oosten van t land alweer geschaatst kan worden. Nou, het verbaast me nix want na een kwartiertje fietsen hingen de ijspegels ook aan m&#39n neusvleugels te bengelen.<BR><BR>Daarbij heb ik nog eens een uur lang op verlaten stationnetjes gestaan doordat het treinverkeer stil lag in Amsterdam én Delft. Ik kon dus geen kant op.<BR><BR>En als je dan thuis komt, helemaal verkleumt van de kou en bijna zwarte tenen is de verwarming bezet door het huisbeest... Wat een luizeleventje heeft die kat toch!<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/verwarming.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=37 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Eitje!
	</td><td width='160' class='logdatum'>8-12-2002<br>14:45:00</td></tr>
	<tr><td colspan='2' class='logbericht'>Van de lieve goed Sint heb ik een kookpannetje gekregen. Een heel kleintje, in de vorm van een hartje. Eigenlijk voor pannenkoeken/poffertjes/flensjes-achtige dingen. <BR><BR>Vanochtend heb ik er lekker een eitje in gemikt. Eerst t eigeel en toen het eiwit. Allebij tegelijk en hij zou overstromen...<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/ei.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=36 style='reageren'>
	10 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Kerst in aantocht
	</td><td width='160' class='logdatum'>7-12-2002<br>17:11:19</td></tr>
	<tr><td colspan='2' class='logbericht'>Sinterklaas is alweer eergisteren geweest. Hoogste tijd om de Kerstman op te wachten! Ookal is december een drukke maand (gister was m&#39n broertje ook nog jarig, en volgende week m&#39n vriendin..) ik hou er wel van. Al begint het enigszins overdreven te worden.<BR><BR>Ik kan me maar weinig van mijn tweejarig verblijf in Amerika herinneren, maar Kerst zal me toch wel bijblijven. Elk (gigantisch) huis in elke straat had de hele voorgevel en tuin onder de lichtjes bedolven. De een had in de voortuin een Kerstman en slede met 8 herten ervoor, bestaande uit gekleurde lampjes. Daarnaast was een huis van top tot teen in nep-sneeuw gehuld en een gigantische boom midden in de tuin. Natuurlijk onder de lampjes en ballen.<BR><BR>Ik vond het prachtig om te zien, al dat geflikker van lampjes en ander geweld aan je ogen. Toch vind ik Sinterklaas een veel gezelliger feest. De gedichten doen het hem. De open stemming waarmee ze worden ontvangen en de knuffel die je ervoor terug krijgt. En natuurlijk het eten :D. Pepernoten, chocoladeletters en het traditionele (bij ons dan) gourmetten.<BR><BR>Gelukkig gaat het kerstfeest bij ons niet verder dan een boom in de voorkamer en een gezellig familie-diner op eerste Kerstdag. Houden zo.</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=35 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Sinterklaas de goede heer
	</td><td width='160' class='logdatum'>6-12-2002<br>11:40:56</td></tr>
	<tr><td colspan='2' class='logbericht'>Gisteravond hebben we weer heerlijk oude herinneringen op zitten halen. Sinterklaas vieren we namelijk sinds forever al met onze oude buren uit Leiden. Vroeger maakten de vaders in onze garage de gigantische surprises, waaronder een krokodil van 2 meter, een raket, een sneeuwpop, noem maar op. Allemaal dezelfde gigantische afmetingen. En natuurlijk bomvol met cadeautjes!<BR>Daarna gingen we meer over op de kleinere surprises die we dan aan iemand anders gaven, dmv lootjes trekken.<BR>En de laatste paar jaren zijn de surprises erbij ingestoken en wordt alle creativiteit in de gedichten gestopt. Daar komen dan ook fikse liederen uit van tegen de 4 A4tjes vol! <BR>Ik zal ze hier dan ook maar niet opschrijven...<BR><BR>Waar Sinterklaas mij mee heeft verblijd dit jaar, is een net pak! Zo kennen jullie me niet he! Nou ik zal er eens een fototje van maken. En ik heb een pannenkoekenbakpan gekregen! in de vorm van een hartje :-D En natuuuuurlijk haarverf in de kleur van m&#39n nieuwe overhemd en stropdas ;-)<BR>Kerst, kom maar op met je diners!!<BR><BR>ps. Job, beterschap!!!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=34 style='reageren'>
	3 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>de Tandarts
	</td><td width='160' class='logdatum'>5-12-2002<br>10:55:59</td></tr>
	<tr><td colspan='2' class='logbericht'>*GAAAAP*<BR>M&#39n vader had vanochtend om ACHT UUR eenafspraak met de tandarts geregeld. De eerste dag in 2 weken dat ik lekker uit kan slapen, en dan moet ik om 7 uur op voor de tandarts. Nou ik heb d&#39rna nog lekker tot 11 uur geslapen!<BR><BR>Maarruh we zijn met z&#39n vijven naar de tandarts gegaan. Bij elkaar zijn we er een kwartiertje geweest, en raad eens hoeveel we die geldwolf moeten betalen om ff in ons schattig smoelwerk te kijken?! <BR><BR>128 EURO! Ligt het aan mij of is dat enigszins overdreven vooreen kwartiertje werk? dat betekent dat hij 500 euro per uur verdiend.<BR>Afperser<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=33 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Onze leiders
	</td><td width='160' class='logdatum'>4-12-2002<br>11:09:22</td></tr>
	<tr><td colspan='2' class='logbericht'>In de Metro staat elke dag (of elke week, weetikut) een stukje over een potentiëel Tweede Kamerlid. Elke keer dat ik dat stukje lees staat er een nog grotere knurft op. Met Emile Ratelband als hoofdknurft natuurlijk.<BR><BR>Deze week Arie v/d Sluijs. De vent heeft zelf van z&#39n leven nog nooit gestemd, was vroeger extreem-rechts en is momenteel extreem-links, en ziet de verkiezingen als een roeping. <BR>Nou Arie, roep maar wat je wilt, je doelgroep ("liefst zoveel mogelijk mensen") staat vast niet om je te springen!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=32 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Shoppen bij de HHS
	</td><td width='160' class='logdatum'>3-12-2002<br>0:11:53</td></tr>
	<tr><td colspan='2' class='logbericht'>Vandaag heb ik even gewinkeld bij de Haagse Hogeschool. Nieuwe  onderdelen van mijn garderobe;<blockquote>T-shirt<BR>Jas<BR>Bodywarmer<BR>Knuffel (beertje met BEÂH op z&#39n shirt)<BR>Tas (heel groot DECAAN er op gedrukt)<BR>En natuurlijk een lading pennen (maar die zitten niet in m&#39n garderobe)</blockquote>Zo is het niet erg om te werken voor de Haagse Hogeschool!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=31 style='reageren'>
	3 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Hij komt, hij komt...
	</td><td width='160' class='logdatum'>1-12-2002<br>18:07:15</td></tr>
	<tr><td colspan='2' class='logbericht'>Sinterklaas is een heerlijk feest. Taaitaai, pepernoten, chocoladeletters en leuke gedichtjes geven. <BR><BR>Dichten is een leuke bezigheid. Tenminste, als het een beetje wil vlotten. Wat het dus momenteel niet doet. Nog vier te gaan, pas één gehad. Zo gaat het nou elk jaar, de week voor 5 december. <BR><BR>Ik weet mij altijd te troosten met de wetenschap dat heel Nederland deze tijd aan het dichten is, en dat het niemand vlotjes verloopt. Dus heren/dames; succes!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=30 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>SLETTEBAKKEN!!!
	</td><td width='160' class='logdatum'>30-11-2002<br>13:03:24</td></tr>
	<tr><td colspan='2' class='logbericht'>In Zweden weten ze pas echt hoe het moet! Alle slettebakken in één <a href="http://www.gs.bergen.hl.no/~slettebakk/" target=_blank>school</a>, verder geen omkijken naar.<BR><BR>Misschien moet Nederland hier eens een voorbeeldje aan nemen...<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=29 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>stelletje BOEREN!!!
	</td><td width='160' class='logdatum'>29-11-2002<br>11:25:26</td></tr>
	<tr><td colspan='2' class='logbericht'>Gisteren was ik, Mhuukas, in het Westland te vinden. Als promoter van de Haagse Hogeschool moest ik ze daar vertellen van het bestaan van een stad ZONDER kassen!<BR><BR>Ja heren/dames, er is ook leven buiten de Tuin. Met grote gebouwen en een school met 16.000 studenten. Gigantische betonnen dozen waar mensen in wonen. En, heel handig, een TREIN. <BR><BR>Ik heb zoveel mogelijk geprobeerd de Westlanders de HHS af te raden. Blijf lekker in Westland, bij je kassen en tuinen. De grote boze randstad overleven jullie niet!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=28 style='reageren'>
	3 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>
	<tr><td width='180' class='logtitel'>Weerspiegeling
	</td><td width='160' class='logdatum'>26-11-2002<br>9:19:30</td></tr>
	<tr><td colspan='2' class='logbericht'>Als je in een plas kijkt, zie je jezelf. Alleen dan ondersteboven. Hierover kan menig weblogger een fascinerend stuk schrijven.<BR><BR>Ik, daarentegen, denk er verder nie bij na, en stamp met m&#39n maat zeilboot midden in de plas. Het liefst als er allemaal mensen om me heen lopen. Prachtig gezicht, al dat opspattende water en de wegrennende mensen. <BR><BR>Owh, en ik krijg net een smsje van m&#39n zus dat er op Leiden Centraal een fiets staat zonder slot. Die&#39s voor mij!! :D</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=27 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Wat een drukte!!
	</td><td width='160' class='logdatum'>24-11-2002<br>17:43:00</td></tr>
	<tr><td colspan='2' class='logbericht'>Van twaalf tot drie heb ik vandaag op de HCC beurs rondgelopen. De hele Jaarbeurshallen stonden tot de nok toe vol met kraampjes waar je computertroep kon kopen, en spellen kon spelen. Alles voor ongelofelijk lage prijzen, ik heb m&#39n ogen uitgekeken.<BR><BR>Helaas voor deze jongen stond er nog € 7,35 op zijn bankrekening. Anders was ik met wat leukers thuisgekomen dan een wagonlading aan mentosjes en pennen.<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/hcc.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=26 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Kerst in aantocht
	</td><td width='160' class='logdatum'>23-11-2002<br>17:09:34</td></tr>
	<tr><td colspan='2' class='logbericht'>"Zullen we dit jaar weer gezellig in nette kleding uit eten?" vroeg m&#39n vriendin gisteravond.<BR><BR>Afgelopen jaren hebben we dat ook gedaan. Hartstikke gezellig en leuk om gewoon een-of-ander maf restaurant binnen te stappen in je drie-delig pak en lekker tussen het &#39gewone volk&#39 plaats te nemen. <BR>Alleen de voorbereidingen vallen elk jaar weer tegen. Een drie-delig pak behoort namelijk niet tot mijn garderobe. Alle kledingstukken zullen dus weer bijeen gesprokkeld moeten worden. Colbert-jasje van de buurman. Broek van een andere buurman. Overhemd van m&#39n vader (veelsteklein maar zolang ik het jasje aan houd valt dat niemand op) en nog mooie manchetknopen ook. En als eigen inbreng een paar mooie kisten er onder. <BR><BR>En dat allemaal voor een avondje eten! Zal ik dit jaar gewoon m&#39n sportschoenen aan doen en m&#39n mooie oranje wegwerkersbroek? Is een stuk makkelijker want die trek ik zo uit de kast!<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=25 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Tafelverhalen
	</td><td width='160' class='logdatum'>21-11-2002<br>19:52:51</td></tr>
	<tr><td colspan='2' class='logbericht'>Oude herinneringen werden vandaag aan tafel weer opgehaald.<BR><BR>Zo hadden wij vroeger een demente buurvrouw. Mevrouw de Nie heette ze. Op een gegeven middag klopte ze bij ons aan. "Hallo, ik ben op zoek naar familie de Nie... weet u misschien waar die woont?"<BR><BR>Ze wist dus nog wel dat ze op weg was naar een "familie de Nie", maar ze was vergeten dat ze dat zelf was. Wat een beetje leeftijd al niet met je kan doen!<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=24 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Vrienden (2)
	</td><td width='160' class='logdatum'>21-11-2002<br>1:34:16</td></tr>
	<tr><td colspan='2' class='logbericht'>Echte vrienden <u>blijven</u> echte vrienden.</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=23 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Neuzen
	</td><td width='160' class='logdatum'>20-11-2002<br>23:14:46</td></tr>
	<tr><td colspan='2' class='logbericht'>Wipneuzen, schattige kleine neuzen, snotneuzen, feestneuzen, loopneuzen, natte neuzen, ter neuzen...<BR><BR>Er zijn zó veel verschillende neuzen! Ik zat vandaag in de trein, en heb tien minuten lang de neus van een medepassagier onderzocht. Het gevaarte was een perfecte driehoek, en was net zo groot als het oor dat aan dezelfde hoofd vast zat. Ik kon mijn ogen er niet vanaf houden.<BR><BR>Hier moest ik opeens weer aan denken toen Hester mij vanochtend na een heerlijk ontbijtje uitgebreid aan het onderzoeken was. Ze zat alle veranderingen aan m&#39n lichaam op te noemen (meeste was gegroeid natuurlijk :D) maar wat haar nog steeds opviel was een nare puist op m&#39n neus. Die er volgens haar al minstens twee jaar nestelt. <BR>Ben ik ff blij dat ik m zelf niet kan zien! :D<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=22 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Vrienden
	</td><td width='160' class='logdatum'>19-11-2002<br>0:17:39</td></tr>
	<tr><td colspan='2' class='logbericht'>In zulke situaties leer je wie je echte vrienden zijn. <BR>Echte vrienden nemen de tijd voor je. <BR>Echte vrienden zijn bezorgd om je.<BR>Echte vrienden nemen je even apart en schelden je huid verrot. Omdat ze bezorgd om je zijn.<BR>En die scheldpartij is nodig om je nog sterker te weerhouden van een volgende keer.<BR><BR>Ik ben blij dat ik nog een paar echte vrienden heb. Al zijn het er zoals altijd iets minder dan verwacht.<BR><BR>en omdat ik zoveel songteksten gequote zie bij weblogs; hier nog een quote van Deftones:<BR><center><BR><i><b><font size="+1">SHOVE IT!</font></b></i></center<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=21 style='reageren'>
	5 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Delise in Aanbouw
	</td><td width='160' class='logdatum'>18-11-2002<br>10:54:56</td></tr>
	<tr><td colspan='2' class='logbericht'>Mhuukas wil ook gaan asp-en, en heeft nu een schetsje klaar voor de <a href="http://mhuukas.mhuu.nl/delise/" target=_blank>Delise-Fanpage</a>. Hier gaat ik een forum en nog wat achtergrondinformatie asp-en over onze geliefde nieuwe idool.<BR><BR>Met hulp van Mhuu.nl moet dat toch wel gaan lukken!!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=20 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>MilkaMhuu en MiniMhuu
	</td><td width='160' class='logdatum'>15-11-2002<br>12:05:42</td></tr>
	<tr><td colspan='2' class='logbericht'>De meeste van jullie kennen ze al; onze geliefde Milka-mascottes in de kantine op school!<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/milka.jpg"><BR><BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=19 style='reageren'>
	5 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>At your fucking service!
	</td><td width='160' class='logdatum'>13-11-2002<br>3:03:18</td></tr>
	<tr><td colspan='2' class='logbericht'>Ik kom net terug van een heerlijk avondje Lebbis en Jansen. Hun nieuwe voorstelling, <a href="http://www.lebbisenjansen.nl/htm/beuken_op_de_buhne.html" target=_blank>Beuken op de buhne </a>was weer een fenomeen als vanouds! <BR><BR>Opvallend was de tirade aan het einde tegen Bush en de LPF. Ik heb genoten van de manier waarop die jongens zulke mensen flink de grond in kunnen stampen. Daar kunnen wij nog wat van leren!<BR><BR>Maar het opvallendste is toch, moet ik zeggen, Jansen z&#39n haar. Rood eilandje bovenop, dan een streep blond en de onderkant blauw. Geweldig! Ik ga kijken of m&#39n zus dat ook bij mij kan doen de volgende keer dat mijn haar weer aan een verfbeurt toe is!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=18 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>HaagUit moeilijk peilbaar
	</td><td width='160' class='logdatum'>12-11-2002<br>13:37:39</td></tr>
	<tr><td colspan='2' class='logbericht'>Sinds ik Staffer ben bij HaagUit, krijg ik van allerhande mensen frustraties naar me hoofd. Onder de oppervlakte blijkt er nog een onpeilbare diepte te zitten! Voor sommigen een beerput als ik dat zo hoor.<BR><BR>Het lijkt wel alsof ik opeens een praatpaal ben geworden voor stafkwesties. Iedereen die ook maar iets tegen staffers heeft komt naar mij toe en probeert mij te behoeden voor het gevaar van "staffer worden". Ze denken dat ik opeens m&#39n leven ga veranderen omdat er iets anders op m&#39n rug staat!<BR><BR>Nou, don&#39t worry want ik was het niet van plan. <BR>Leider. In hart en nieren. En maag :D<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/modder.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=17 style='reageren'>
	9 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Senioren achter de pc
	</td><td width='160' class='logdatum'>10-11-2002<br>17:13:23</td></tr>
	<tr><td colspan='2' class='logbericht'>Mijn opa heeft laatst een laptop gekocht via Albert Heijn. Geweldig natuurlijk, nu kan hij vanuit z&#39n stoeltje mailen met z&#39n broer die in Australië woont, en met al z&#39n kinderen en kleinkinderen. En af en toe een beetje rondsurfen op het internet. <BR><BR>Zo af en toe kom ik daar nog over de vloer om hem uit de brand te helpen met eenofander computerprobleempje. Een virusscanner installeren, telebankieren, een bijlage mailen, een www adres opzoeken, dat soort dingen kan ik hem mee helpen. Maar één voorval zal me altijd bijblijven.<BR><BR>"Waarom is mijn internetverbinding nou deze keer sneller dan de vorige keer?" vroeg hij tijdens een download... "Het balkje loopt veel sneller vol dan de vorige!"</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=16 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Afterparty roels!
	</td><td width='160' class='logdatum'>9-11-2002<br>22:38:33</td></tr>
	<tr><td colspan='2' class='logbericht'>Onder leiding van de <a href="http://home.wanadoo.nl/fambouma/paboys/" target=_blank>PABOys</a> is het personeel van de open dag lekker uit z&#39n pan gegaan, including me.<BR>Was leuk om ze te zien twisten!! (k ben blij dat ík niet op de foto sta!)<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/twist.jpg"><BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=15 style='reageren'>
	Reageer als eerste!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Einde van de tentamens!
	</td><td width='160' class='logdatum'>9-11-2002<br>1:01:40</td></tr>
	<tr><td colspan='2' class='logbericht'>Zo, dat was me het weekje wel! Vier tentamens gehad. Het enige dat ik heb geleerd is ASP :D En dat was nieteens omdat de school dat zo belangrijk vond, maar omdat ik zo graag de Delise-Fanpeetsj wil maken op delise.mhuu.nl. <BR><BR>En ik heb koekjes gebakken! Eerste keer voor moi, maar zekersteweten niet de laatste! Hoewel... die koekjes waren niet zo bijzonder. Het deeg daarentegen is zoooo lekker voordat het de oven in gaat! volgende keer maak ik gewoon leuke vormpjes in die deeg en vreet ik het gelijk op :D <BR><BR>Wat staat er voor morgen op het programma, vraagt men zich af? (ik althans) Nou, aandachtige luisteraar, het is open dag op de Haagse Hogeschool! En ik heb de boeiende taak toegedeeld gekregen van enqueteformulieren innemen!! Hele godgandse dag "ja dankuwel" "yo, veel plezier" enzo zitte lullen. <BR>Als goedmakertje daartegenover staat een lekker diner met een leuke meid :D<BR><BR>groetzels en tot sinas!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=14 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Kopstoot van een ...
	</td><td width='160' class='logdatum'>7-11-2002<br>10:31:59</td></tr>
	<tr><td colspan='2' class='logbericht'>Wij hadden het vanavond aan tafel over verliefdheid. M&#39n broertje beweerde nog altijd hoteldebotel op zijn Roxanne, en m&#39n zus hoopt het nooooit van d&#39r langzalzeleven te worden. <BR>Moeders meldde dat bij haar het "hoteldebotel" toch wel enigszins over was, waarop mijn vader onthutst meldde dat hij elke dag weer de vlinders in zijn buik kreeg. Telkens weer, stipt tussen 5 en 6 (alstie weer "hard" gewerkt had) besloop een kriebelend gevoel hem in zijn maagstreek. Nou, als dát geen verliefdheid is!!!<BR><BR>En ik? Ik hou zielsveel van m&#39n Hester, met vlagen van hoteldebotelheid. Maar dat zeg ik niet hardop aan tafel.<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/vlinders.jpg"><BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=13 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>World Wide Koeien
	</td><td width='160' class='logdatum'>6-11-2002<br>19:08:48</td></tr>
	<tr><td colspan='2' class='logbericht'>Het internet STIKT van de koeien!!! Moejje dit eens lezen:<BR><BR><i>Long before the Web, cows were already a vital part of uselessness via the Internet. If I had thought to write "Uselessness of ARPANet," cows would have figured prominently. You can look at The Jargon File for examples of this. Of course, now that everyone has their own Web page, cows have popped up EVERYWHERE...</i><BR><BR>Echt, je rolt zo van de ene cow naar de andere. Hier een leuke "<a href="http://members.tripod.com/~spows/cow.html" target=_blank>knutsel je eigen koe</a>"<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=12 style='reageren'>
	2 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Waar bier al niet goed voor is...
	</td><td width='160' class='logdatum'>6-11-2002<br>0:10:52</td></tr>
	<tr><td colspan='2' class='logbericht'>Bier is goed. Voor van alles. Voor alles eigenlijk. <BR><BR>Dankzij de drank zie je oplossingen voor problemen die er zonder drank nooit waren geweest. Zo ontwikkelt het je creatieve geest. En iedereen weet, dat vrouwen vallen op mannen met een creatieve geest :D<BR><BR>Bewezen is, dat na 4 eenheden alcohol je je medemens tot 25% aantrekkelijker vindt! Dus als jij in t gezelschap van een leuke dame haar een paar biertjes achterover giet, is succes haast gegarandeerd!!<BR><BR>Alcohol vermorzelt hersencellen. Hier passen we de wet van "survival of the fittest" op toe, en dan komt het erop neer dan alcohol slechte hersenceller vernachelt, en zo het gemiddelde niveau van de hersenen opwaardeert! En iiiieeeedereen weet, dan vrouwen van intelligent mannen houden!<BR><BR>Hoe dan ook, met een biertje op ben je een vrouwenmagneet!! En welk hoger nut is er nou in dit leven, vraag ik u?<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/heneuken.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=11 style='reageren'>
	9 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Eerste tentamen
	</td><td width='160' class='logdatum'>4-11-2002<br>15:23:27</td></tr>
	<tr><td colspan='2' class='logbericht'>DB blijft DB. Niet te genieten. <img src=http://www.mhuu.nl/smilies/pukey.gif width=15 height=15 class=noborder> <BR>(dit is mijn eerste experiment met smilies, maar ze passen niet in het ontwerp. Op naar de emotikoe&#39s!)<BR><BR>Opzich zijn databases wel een interessant en nuttig onderwerp. Maar zolang ik er niet zelf een paar in elkaar heb gesleuteld, blijft het allemaal abracadabra voor me. <BR>Nou maar hopen op een voldoende, dan heb ik dit vak tenminste achter de rug.<BR><BR>En nu NOG drie van die kleretentamens!!<BR>wish me luck<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=10 style='reageren'>
	9 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Moeilijk wakker worden
	</td><td width='160' class='logdatum'>3-11-2002<br>14:58:12</td></tr>
	<tr><td colspan='2' class='logbericht'>Ik ben al twee dagen druk in de weer om OI-02 te leren voor de komende tentamenweek.  Ik vond mezelf al helemaal geweldig vanwege mijn strakke planning!<BR><BR>Totdat JOB vanmiddag rond 2 uur wakker werd en moeilijke DB-01 vragen begon te stellen. Ik zei hem: "first things first, k ben met OI bezig"<BR>Waarop Job antwoordde: "First things first, morgen hebben we DB, zummie"<BR><BR>Oeps! <BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=9 style='reageren'>
	6 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Leukste week van het jaar
	</td><td width='160' class='logdatum'>2-11-2002<br>14:29:08</td></tr>
	<tr><td colspan='2' class='logbericht'>Ondanks het vorige berichtje, durfde mijn vriendin het vannacht toch aan om bij mij onder de dekens te kruipen. <BR>En wat zag mijn oog? Nieuwe LINGERIE!! (job steek die tong terug in je mond) <BR>Wat blijkt? het is de wéék van de Lingerie geweest! Dus Hester heeft volop ingeslagen :D Daar heb ik natuurlijk geen problemen mee! Ik ben benieuwd wat ze morgen voor me uit de kast tovert...<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/lingerie.jpg"></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=8 style='reageren'>
	7 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Ondingen
	</td><td width='160' class='logdatum'>31-10-2002<br>23:48:17</td></tr>
	<tr><td colspan='2' class='logbericht'>Vanmiddag las m&#39n vriendin weer eens een stukje van mijn geblaat op Mhuu.nl. Haar reactie:<BR>"Luuk, je hebt veel talenten. Maar schrijven is er niet één van."<BR><BR>Én bedankt!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=7 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Productief dagje
	</td><td width='160' class='logdatum'>30-10-2002<br>22:18:46</td></tr>
	<tr><td colspan='2' class='logbericht'>Vandaag was DE dag. Eindelijk kon ik mijn Get the Portal Picture spel presenteren, samen met Paula Udondek. En Job, die ook zo graag mee wilde. <BR><BR>Na een gezellig uurtje presenteren en twee ongezellige uurtjes naar een presentatie van eenofandere jandoedel luisteren kreeg ik mijn 150 euro uitbetaald, plus een aanbieding voor een stageplek. Dáár doe ik het toch maar weer voor!<BR><BR>En de eerste euro&#39s zijn gelijk verbrast in café Xieje. <BR>Geld moet rollen<BR><BR><img src="http://home.wxs.nl/~vdriel/fotos/gtpp.jpg"><BR>ps. Hier een kiekje van de bekendmaking van de winnaars. Met charmante assistente Delise</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=6 style='reageren'>
	4 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Return of the Laptop
	</td><td width='160' class='logdatum'>29-10-2002<br>23:31:32</td></tr>
	<tr><td colspan='2' class='logbericht'>20 Augustus 2002 was een rotdag. Ik werd om 6 uur &#39s ochtends wakker van een ontzettend geraas buiten. Bliksemflitsen vind ik donders interessant, dus ik ging lekker staan kijken aan m&#39n raam.<BR><BR>Totdat er opeens een gigantische KNAL kwam vlak voor m&#39n neus. Ik schrok me het apezuur! Bij de Peugeot-garage naast ons begonnen de alarmen te loeien, maar ik kon de plaats van inslag niet bepalen. <BR><BR>Later bleek dat wijzelf de pechvogels waren. In onze hele buurt waren aardlekschakelaars omgeslagen en zekeringen doorgeslagen. Bij ons was de CV ketel naar de knoppen en ... m&#39n laptop zat nog in het stopcontact. Geen vonkje leven meer in te krijgen. <BR><BR>Een weekje later kon ik hem op school afgeven aan de helpdesk, en dan zouden zij hem fixen.<BR><BR>Na twee weken stuur ik een mailtje om te vragen hoe het ermee staat. Als antwoord:<BR>"De gemiddelde reparatie duurt 3 tot 4 weken."<BR><BR>30 September. Mhuukas helemaal blij; zijn laptop gearriveerd!! Voordat je je handtekening zet natuurlijk eerst even kijken of hij het wel echt doet. Zowaar! Hij werkt! Dacht ik.<BR>Alles bleek te werken, maar thuis kwam ik er achter dat hij niet op netwerken aangesloten kon worden!! TEEERRRRRRRRUUUUUUGGGGGGGG<BR><BR>28 Oktober opnieuw spanning; hij lag alweeer bij de helpdesk op me te wachten. Deze keer werkte alles (na windows NT eraf te hebben gegooid, baggersysteem), en ik post nu lekker vanaf m&#39n laptop. Met nieuw moederbord, netwerkkaart, toetsenbord, touchpad, en speakerset. <BR><BR>Alleen... m&#39n rechterspeaker produceert hitte ipv geluid. Dan maar geen muziek, ik zet dat ding niet NOG een maand bij de helpdesk!!<BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=5 style='reageren'>
	5 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>... van een vlinder
	</td><td width='160' class='logdatum'>26-10-2002<br>3:30:32</td></tr>
	<tr><td colspan='2' class='logbericht'>Onder weg van de kroeg naar het station kwam ik een Rotterdammert tegen de ik dacht een fijne avond te bezorgen door hem gedag te zeggen.<BR><BR>De broer (overduidelijk ook een Rotterdammert) vond het niet zo&#39n al te fijn gebaar. Sindsdien loop ik rond met een bloedneus :S<BR><BR>Rotterdammers zijn niet lief.</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=4 style='reageren'>
	7 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Man-Vrouw relatie
	</td><td width='160' class='logdatum'>25-10-2002<br>10:33:02</td></tr>
	<tr><td colspan='2' class='logbericht'>Ergens in zuidelijk Afrika...<BR><BR>Een man verlaat zijn vrouw om elders geld te zoeken. Na 20 jaar weggeweest, verslechterd zijn gezondheid. Hij besluit terug te keren naar zijn dorp. <BR>Terug in het dorp, vraagt hij aan zijn mannelijke dorpsgenoten hoe zijn vrouw zich heeft gedragen tijdens zijn afwezigheid. "goed gedragen, eerlijk geld verdiend, goed voor de kinderen gezorgd, bladiebla"<BR>Mooizo, dacht de man. Hij betreedt het huis dat hij 20 jaar geleden verlaten had en vraagt zijn vrouw: "waar blijft m&#39n eten?!"<BR>Er wordt verder geen woord over de afgelopen 20 jaar gewisseld.<BR><BR>(c) hoorcollege Culturele Antropology<BR><BR><a href="http://luckylukie.pleasekiss.us/index3db902c20.htm" target="_blank"><img src="http://home.wxs.nl/~vdriel/fotos/ca.jpg"></a><BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=3 style='reageren'>
	Reeds één reactie, reageer ook!</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>Mobiel
	</td><td width='160' class='logdatum'>23-10-2002<br>17:10:36</td></tr>
	<tr><td colspan='2' class='logbericht'>In deze tijd van mobiele communicatie ben ik jarenlang -vooral op mijn informatica opleiding- een van de enigen geweest die niet mobiel bereikbaar was. <BR><BR>Soms een zegen, soms een hell, maar nu ik er eentje in m&#39n schoot geworpen krijg sla ik het niet af natuurlijk. Simkaart van Johan en een Ericsson T10s (met wat ductape bij elkaar gehouden) van Chris, en ik hoor er ook weer bij!<BR><BR>Tot bels!</td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=2 style='reageren'>
	6 reacties, reageer je mee?</a><p><center><img src='inc/ff6633.gif' width='300' height='1'></center></td></tr>

	<tr><td width='180' class='logtitel'>MedeMhuu-er
	</td><td width='160' class='logdatum'>22-10-2002<br>12:58:55</td></tr>
	<tr><td colspan='2' class='logbericht'>Mhuuuuuuuu!!!<BR><BR>Ik deel de mening van Mhuu.nl dat typen na een shoarma-ontbijt en een nacht lang films kijken een bijzonder ingewikkelde bezigheid is.<BR><BR>Toch ben ik zeer verheugd dat ik mag typen op dit wonderlijke websiteje! <a href="http://www.mhuu.nl">Mhuu.nl</a> bedankt!<BR><BR>Ik kijk nog even met een brede grijns achterom naar de twee schoonheden die liggen te rusten in m&#39n bedje. Die hebben ook wel genoten van de films!<BR><BR>-- Kijk s wat ik vanochtend in m&#39n bed vond!!<BR><img src="http://www.mhuu.nl/foto/wenco.jpg"><BR><BR></td></tr>
	<tr><td colspan='2' class='logreageren'><a href=reactie.asp?id=1 style='reageren'>
	13 reacties, reageer je mee?</a><p align=center></p><img src='inc/ff6633.gif' width='300' height='1'></p></td></tr>
<%
end if
%>
</table>

<!-- #include virtual="/projecten/3lv3/_bottom.asp" -->