<%
	Response.Expires = 0

	' create instance of AspJpeg
	Set jpg = Server.CreateObject("Persits.Jpeg")

	' Open source file
	jpg.Open( request("path") )

	' Set resizing algorithm
	jpg.Interpolation = 1

	' Set new height and width
	jpg.Height = 300
	jpg.Width = _
	  jpg.OriginalWidth * jpg.Height / jpg.OriginalHeight

	' Sharpen resultant image
	jpg.Sharpen 1, 110

	' Save it to disk
	jpg.Save( "D:\www\3l.nl\www\fotolog\foto\" &request("naam")& ".jpg" )

	response.redirect("fotolog.asp?actie=aanmaken2&id=" &request("naam"))
%>