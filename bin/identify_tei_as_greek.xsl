<?xml version='1.0' encoding='UTF-8'?>
  <xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>


<xsl:template match="body">
  <xsl:attribute name="lang">grc</xsl:attribute>
  <xsl:apply-templates select="@*|node()"/>
</xsl:template>

<xsl:template match="*" mode="inbody">
<xsl:copy>
  <xsl:copy-of select="@*"/>
  <xsl:apply-templates  mode="inbody"/>
</xsl:copy>
</xsl:template>
<!--
<xsl:template match="@*|node()" mode="inbody">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()" mode="inbody"/>
  </xsl:copy>
</xsl:template-->

<xsl:template match="text()" mode="inbody">
    <xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
</xsl:template>

</xsl:stylesheet>
