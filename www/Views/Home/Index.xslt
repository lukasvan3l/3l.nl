<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:Html="urn:HtmlHelper">

  <xsl:param name="GoogleAnalyticsKey" select="''"/>
  <xsl:param name="services" />

  <xsl:template match="/">
    <html>
      <head>
        <title>3L.nl - Lukas van 3L</title>
        <link href="/Content/home.css" rel="stylesheet" type="text/css" />
        <link href="/Content/print.css" rel="stylesheet" type="text/css" media="print" />
        <link href="/favicon.ico" rel="shortcut icon" />
        <script src="/Scripts/jquery-1.3.2.js" language="javascript" type="text/javascript"></script>
        <script src="/Scripts/home.js" language="javascript" type="text/javascript"></script>
        <xsl:if test="$GoogleAnalyticsKey != ''">
          <script type="text/javascript">var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www."); document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));</script>
          <script type="text/javascript">
            <xsl:text>try { var pageTracker = _gat._getTracker("</xsl:text>
            <xsl:value-of select="$GoogleAnalyticsKey"/>
            <xsl:text>"); pageTracker._trackPageview(); } catch (err) { }</xsl:text>
          </script>
        </xsl:if>
      </head>

      <body>

        <div id="articles">
          <h1>Lukas van 3L</h1>
          <a href="#" class="more" onclick="loadContent(''); return false;">About to start loading...</a>
        </div>

        <div id="feed-selector">
          <h2>Toon alleen:</h2>
          <xsl:apply-templates select="$services/articleservice" />
        </div>

      </body>
    </html>
  </xsl:template>

  <xsl:template match="articleservice">
    <div class="feed" id="{@name}">
      <xsl:value-of select="@name"/>
    </div>
  </xsl:template>

</xsl:stylesheet>