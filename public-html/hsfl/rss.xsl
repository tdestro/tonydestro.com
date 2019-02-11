<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8"/>
<xsl:template match="/">
	<xsl:for-each select="rss/channel/item">
        <li class="newsItem">
            <span class="date"><xsl:value-of select="pubDate" /></span>
            <span class="headline"><xsl:value-of select="title" disable-output-escaping="yes" /></span>
            <a class="pdf">
            <xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
            Click here (<xsl:value-of select="description"/>)
            </a>
        </li>
    </xsl:for-each>
</xsl:template>
</xsl:stylesheet>