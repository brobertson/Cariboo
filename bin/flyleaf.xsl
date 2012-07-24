<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" omit-xml-declaration="yes" />
  <xsl:template match="/"> 
<!--In-line CSS cannot be used-->
    <html xmlns="http://www.w3.org/1999/xhtml">
    <body>
     <h1 text-align="center"> -Metadata Flyleaf- </h1>
     <p> <xsl:value-of select="//title"/>, <xsl:value-of select="//author"/></p>
     <p> <xsl:value-of select="//publisher"/></p>
     <p> <xsl:value-of select="//date"/></p>
     <p> <xsl:value-of select="//pubPlace"/></p>
     <p> <xsl:value-of select="//Editor"/></p>
     <p> <xsl:value-of select="//extent"/></p>
     <p> <xsl:value-of select="//notesStmt"/></p>
     <p> <xsl:value-of select="//imprint"/></p>
    </body>
    </html>  
  
  
  
  
  </xsl:template>
</xsl:stylesheet>
