<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">

    <html>

    <body>

     <h1 style="font-size:20px;text-decoration:underline;text-align:center"> -Metadata Flyleaf- </h1>
 
     <p style="text-align:center;line-heigth:10%"> <xsl:value-of select="//title"/>, <xsl:value-of select="//author"/></p>
 
     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//publisher"/></p>

     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//date"/></p>
     
     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//pubPlace"/></p>

     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//Editor"/></p>

     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//extent"/></p>

     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//notesStmt"/></p>

     <p style="text-align:center;line-height:10%"> <xsl:value-of select="//imprint"/></p>
   

     
    
    </body>
<pb/> 
    
    </html>  
  
  
  
  
  </xsl:template>
</xsl:stylesheet>
