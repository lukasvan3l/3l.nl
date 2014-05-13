<!-- #include virtual="databla.asp" -->
<% 'query voor het ophalen van alle onzin / gegevens ..
dim rsLog, datum, tijd
set rsLog = conn.execute("SELECT top 10 * FROM log ORDER BY datum desc, tijd desc")

'aanroepen van het filesystemobject
dim fs,tfile
set fs=Server.CreateObject("Scripting.FileSystemObject")
set tfile=fs.CreateTextFile("D:\www\3l.nl\www\rss\weblog.xml")

tfile.WriteLine("<?xml version=""1.0"" encoding=""ISO-8859-1"" ?>") 
tfile.WriteLine("<rss version=""2.0"" xmlns:dc=""http://purl.org/dc/elements/1.1/"" xmlns:sy=""http://purl.org/rss/1.0/modules/syndication/"" xmlns:admin=""http://webns.net/mvcb/"" xmlns:rdf=""http://www.w3.org/1999/02/22-rdf-syntax-ns#"" xmlns:content=""http://purl.org/rss/1.0/modules/content/"">")
tfile.WriteLine("<channel>")
tfile.WriteLine("<title>3L.nl</title>") 
tfile.WriteLine("<link>http://www.3l.nl</link>") 
tfile.WriteLine("<description>Lukas van 3L: Weblog</description>") 
tfile.WriteLine("<dc:language>nl</dc:language>") 
tfile.WriteLine("<dc:creator />") 
tfile.WriteLine("<dc:rights>Copyright 2003</dc:rights>") 
tfile.WriteLine("<dc:date>"&date()&"T"&Time()&"+2:00</dc:date>") 
tfile.WriteLine("<admin:generatorAgent rdf:resource=""http://www.3l.nl"" />") 
tfile.WriteLine("<admin:errorReportsTo rdf:resource=""mailto:rss@3l.nl"" />") 
tfile.WriteLine("<sy:updatePeriod>hourly</sy:updatePeriod>") 
tfile.WriteLine("<sy:updateFrequency>1</sy:updateFrequency>") 
tfile.WriteLine("<sy:updateBase>2000-01-01T12:00+00:00</sy:updateBase>") 

do while not rsLog.EOF

	dim rss_log, rss_titel 
	rss_log = Server.HTMLEncode(rsLog("bericht"))
	rss_titel = server.HTMLEncode(rsLog("titel"))

	tfile.WriteLine("<item>")
	tfile.WriteLine("<title>"&rss_titel&"</title>") 
	tfile.WriteLine("<link>"&server.HTMLEncode("http://www.3l.nl/reactie.asp?id=")&rsLog("id")&"</link>") 
	tfile.WriteLine("<description>"&rss_log&"</description>")
	tfile.WriteLine("<content:encoded>") 
	tfile.WriteLine("<![CDATA[ "&rsLog("bericht")&" ]]>")
	tfile.WriteLine("</content:encoded>") 
	tfile.WriteLine("<dc:date>"&rsLog("datum")&"T"&rsLog("tijd")&"+02:00</dc:date>") 
	tfile.WriteLine("</item>")

rsLog.MoveNext
Loop 


tfile.WriteLine("</channel>")
tfile.WriteLine("</rss>")

tfile.close
set tfile=nothing
set fs=nothing
set rsLog = nothing

Conn.Close 
Set Conn=Nothing

response.redirect ("weblog.asp")
%>