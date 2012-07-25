<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" omit-xml-declaration="yes" />
  <xsl:template match="/"> 

    <html xmlns="http://www.w3.org/1999/xhtml">
    <body><center>
     <p> <xsl:value-of select="//author"/>, <xsl:value-of select="//title"/></p>
     <p> <xsl:value-of select="//publisher"/></p>
     <p> <xsl:value-of select="//date"/></p>
     <p> <xsl:value-of select="//pubPlace"/></p>
     <p> <xsl:value-of select="//Editor"/></p>
     <p> <xsl:value-of select="//extent"/></p>
     <p> <xsl:value-of select="//notesStmt"/></p>
     <p> <xsl:value-of select="//imprint"/></p>
     </center>
     <p>This epub document is based on a TEI source document produced by the Perseus Project. It was transformed using the Cariboo tools available at <code>https://github.com/brobertson/Cariboo</code>. Comments regarding the epub document should be addressed to Bruce Robertson at brobertson@mta.ca.</p>
    </body>
    </html>  
  
  
  
  
  </xsl:template>
</xsl:stylesheet>
