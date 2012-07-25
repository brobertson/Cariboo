<?xml version='1.0' encoding='UTF-8'?>
  <xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template match="/">
<xsl:if test="/TEI.2/teiHeader/fileDesc/sourceDesc//author=''">
  <xsl:value-of select="'Anonymous'"/>
</xsl:if>
  <xsl:value-of select="TEI.2/teiHeader/fileDesc/sourceDesc//author"/>
</xsl:template>

</xsl:stylesheet>
