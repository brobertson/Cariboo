<xsl:stylesheet version="1.0" xmlns:opf="http://www.idpf.org/2007/opf" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="opf:metadata">
		<opf:metadata>
			<opf:meta name="cover" content="cover.jpg"/>
			<xsl:apply-templates/>
		</opf:metadata>
	</xsl:template>
        <xsl:template match="opf:manifest">
		<opf:manifest>
			<opf:item id="cover.jpg" href="cover.jpg" media-type="image/jpeg" />
			<opf:item id="chapter-00" href="chapter-00.html" media-type="application/xhtml+xml"/>
   			<opf:item id="chapter-01" href="chapter-01.html" media-type="application/xhtml+xml"/>
			<xsl:apply-templates/>
		</opf:manifest>
	</xsl:template>
	<xsl:template match="opf:spine">
		<opf:spine toc="ncx">
			<opf:itemref idref="chapter-00"/>
			<opf:itemref idref="chapter-01"/>
			<xsl:apply-templates/>
		</opf:spine>
	</xsl:template>
	<xsl:template match="opf:package">
		<opf:package>
			<xsl:apply-templates/>
			<opf:guide>
				<opf:reference type="cover" title="Cover Page" href="cover.xhtml"/>
			</opf:guide>
		</opf:package>
	</xsl:template>
</xsl:stylesheet> 







