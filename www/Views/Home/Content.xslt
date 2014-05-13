<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:Html="urn:HtmlHelper">

  <xsl:param name="todate" />
  <xsl:param name="articles" />

  <xsl:template match="/">
    <xsl:apply-templates select="$articles/articlelist/article" />
    <a href="/home.aspx/content/{$todate}" class="more" id="btnMore"
      onclick="loadContent({$todate}); return false;">More!</a>
  </xsl:template>

  <xsl:template match="article">
    <div class="article article-{@type}">
      <xsl:apply-templates select="title[.!='']"/>
      <xsl:apply-templates select="." mode="body"/>
      <xsl:apply-templates select="." mode="metadata"/>
      <xsl:apply-templates select="reactionlist[reaction]" />
    </div>
  </xsl:template>

  <xsl:template match="title">
    <h3>
      <xsl:apply-templates select="node()" />
    </h3>
  </xsl:template>

  <xsl:template match="article" mode="body">
    <div class="body">
      <xsl:apply-templates select="body/node()"/>
    </div>
  </xsl:template>
  <xsl:template match="html">
    <xsl:apply-templates select="node()" />
  </xsl:template>

  <xsl:template match="article" mode="metadata">
    <div class="metadata">
      <span class="metadata-text">
        <xsl:apply-templates select="creationdate"/>
        <xsl:apply-templates select="user"/>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="creationdate">
    <xsl:choose>
      <xsl:when test="contains(.,' 0:00:00') or contains(.,' 12:00:00')">
        <xsl:value-of select="substring-before(.,' ')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="node()" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="user">
    <xsl:text> by </xsl:text>
    <xsl:apply-templates select="node()" />
  </xsl:template>
  <xsl:template match="article[@type='tweet']/user[.!='Lukasvan3L']">
    <xsl:text> by </xsl:text>
    <a href="http://www.twitter.com/{.}">
      <xsl:apply-templates select="node()" />
    </a>
  </xsl:template>
  <xsl:template match="article[@type='tweet']/user">
    <xsl:text> via </xsl:text>
    <xsl:apply-templates select="../source/node()" />
  </xsl:template>
  <xsl:template match="user[.='']" />

  <xsl:template match="reactionlist">
    <div class="reactions">
      <h4 class="reactions-header">Reacties</h4>
      <xsl:apply-templates select="reaction" />
    </div>
  </xsl:template>
  <xsl:template match="reaction">
    <div class="reaction">
      <div class="reaction-metadata">
        <span class="reaction-user">
          <xsl:apply-templates select="user/node()"/>
        </span>
        <span class="reaction-date">
          <xsl:apply-templates select="date/node()"/>
        </span>
      </div>
      <div class="reaction-body">
        <xsl:apply-templates select="body/node()"/>
      </div>
    </div>
  </xsl:template>
  <!-- text -->

  <xsl:template match="div">
    <p>
      <xsl:apply-templates select="node()|@*" />
    </p>
  </xsl:template>
  <xsl:template match="div[not(*) and .='']" />

  <xsl:template match="*|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>