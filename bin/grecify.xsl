<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- IdentityTransform -->
<xsl:template match="/">
  <xsl:apply-templates />
</xsl:template>


<xsl:template match="/  | @* | node()" >
 <xsl:copy>
  <xsl:apply-templates select="@* | node()"/>
 </xsl:copy>
</xsl:template>

<xsl:template match="/ | @* | node()" mode="show">
    <xsl:copy>
       <xsl:apply-templates select="@* | node()" mode="show" />
     </xsl:copy>
</xsl:template>

<xsl:template match="@lang[.='greek']">
  <xsl:attribute name="lang">grc</xsl:attribute>
</xsl:template>

<xsl:template match="note">
  <xsl:element name="note">
   <xsl:attribute name="lang">eng</xsl:attribute>
   <xsl:apply-templates select="./@*"/>
   <xsl:apply-templates />
  </xsl:element>
</xsl:template>

<xsl:template match="body">
  <xsl:element name="body">
    <xsl:attribute name="lang">grc</xsl:attribute>
   <xsl:apply-templates select="./@*"/>
   <xsl:apply-templates />
  </xsl:element>
</xsl:template>
</xsl:stylesheet>
