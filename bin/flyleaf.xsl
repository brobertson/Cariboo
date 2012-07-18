<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">

    <xhtml:html>

    <xhtml:body>

     <xhtml:h1 style="font-size:20px;text-decoration:underline;text-align:center"> -Metadata Flyleaf- </xhtml:h1>
 
     <xhtml:p style="text-align:center;line-heigth:10%"> <xsl:value-of select="//title"/>, <xsl:value-of select="//author"/></xhtml:p>
 
     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//publisher"/></xhtml:p>

     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//date"/></xhtml:p>
     
     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//pubPlace"/></xhtml:p>

     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//Editor"/></xhtml:p>

     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//extent"/></xhtml:p>

     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//notesStmt"/></xhtml:p>

     <xhtml:p style="text-align:center;line-height:10%"> <xsl:value-of select="//imprint"/></xhtml:p>
   

     
    
    </xhtml:body>
<xhtml:pb/> 
    
    </xhtml:html>  
  
  
  
  
  </xsl:template>
</xsl:stylesheet>
