<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="utf-8"/>
<xsl:template match="/">
	<h2>Transitions SolFX News Feed</h2>
	<ul id="ulNews"> 
	<xsl:for-each select="rss/channel/item">
    	<li><span>News Release | <xsl:value-of select="pubDate" /></span>
        <a class="">
            <xsl:attribute name="href">
                <xsl:value-of select="link"/>
            </xsl:attribute>
            <xsl:value-of select="title"/>
        </a>
        </li>
    </xsl:for-each>
    </ul>
</xsl:template>
</xsl:stylesheet>