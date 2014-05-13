<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<IArticleService>>" %>

<%@ Import Namespace="Driel.Website.Services" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"> 
<html>
  <head>
    <title>3L.nl - Lukas van 3L</title>
    <link href="/Content/home.css" rel="stylesheet" type="text/css" />
    <link href="/Content/print.css" rel="stylesheet" type="text/css" media="print" />
	  <link href="/favicon.ico" rel="shortcut icon" />
    <script src="/Scripts/jquery-1.3.2.js" language="javascript" type="text/javascript"></script>
    <script src="/Scripts/home.js" language="javascript" type="text/javascript"></script>
    <% if (!string.IsNullOrEmpty(Driel.Website.App.Settings.GoogleAnalyticsKey)) { %>
    <script type="text/javascript">
      var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
      document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript">
      try {
        var pageTracker = _gat._getTracker("<%= Driel.Website.App.Settings.GoogleAnalyticsKey %>");
        pageTracker._trackPageview();
      } catch (err) { } 
    </script>
    <% } %>
  </head>
  
  <body>
  
    <div id="articles">
      <h1>Lukas van 3L</h1>
      <a href="#" class="more" onclick="loadContent(''); return false;">About to start loading...</a>
    </div>
  
    <div id="feed-selector">
      <h2>Toon alleen:</h2>
      <%
        foreach (System.Xml.XmlElement el in ((System.Xml.XmlElement)ViewData["services"]).ChildNodes)
        {
          %><div class="feed" id="<%= el.GetAttribute("name") %>"><%= el.GetAttribute("name")%></div>
          <%
        }
      %>
      
      <!--<div class="feed"><h2>Upcoming!</h2></div>
      <div class="feed">Fotolog</div>
      <div class="feed">Gifts4Girls</div>
      <div class="feed">Hester op reis</div>
      <div class="feed">Delicious</div>
      <div class="feed">Flickr</div>
      <div class="feed">LastFM</div>
      <div class="feed">LinkedIn</div>
      <div class="feed">YouTube</div>
      <div class="feed">Hyves</div>
      <div class="feed">Facebook</div>
      <div class="feed">Foursquare</div>
      <div class="feed">Google Reader</div>-->

    </div>
  
  </body>
</html>