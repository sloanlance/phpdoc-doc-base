<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 

  PHP.net web site specific stylesheet

  $Id: phpweb.xsl,v 1.4 2003-04-21 12:52:28 goba Exp $

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:import href="./docbook/html/chunkfast.xsl"/>
<xsl:include href="html-common.xsl"/>

<!-- Output files to the 'php' dir, use the '.php' extension
     and name them using the IDs in documents -->
<xsl:param name="base.dir" select="'php/'"/>
<xsl:param name="html.ext" select="'.php'"/>
<xsl:param name="use.id.as.filename" select="1"/>

<!-- Speed up generation (no file name printouts) -->
<xsl:param name="chunk.quietly">1</xsl:param>

<!-- Special PHP code navigation for generated pages
     Note: I have used xsl:text instead of
     xsl:processing-instrunction, because the later
     added > to end the PI, instead of ?> with saxon
 --> 
<xsl:template name="header.navigation">
 <xsl:param name="prev" select="/foo"/>
 <xsl:param name="next" select="/foo"/>
 <xsl:variable name="home" select="/*[1]"/>
 <xsl:variable name="up" select="parent::*"/>

 <xsl:call-template name="phpweb.header"/>
 
 <xsl:call-template name="phpdoc.nav.array">
  <xsl:with-param name="node" select="$home"/>
 </xsl:call-template>
  
 <xsl:text disable-output-escaping="yes">,
    'prev' =&gt; </xsl:text>

 <xsl:call-template name="phpdoc.nav.array">
  <xsl:with-param name="node" select="$prev"/>
 </xsl:call-template>

 <xsl:text disable-output-escaping="yes">,
    'next' =&gt; </xsl:text>

 <xsl:call-template name="phpdoc.nav.array">
  <xsl:with-param name="node" select="$next"/>
 </xsl:call-template>
 
 <xsl:text disable-output-escaping="yes">,
    'up' =&gt; </xsl:text>

 <xsl:call-template name="phpdoc.nav.array">
  <xsl:with-param name="node" select="$up"/>
 </xsl:call-template>

 <xsl:text disable-output-escaping="yes">,
    'toc' =&gt; array(</xsl:text>
 
 <xsl:for-each select="../*">
  <xsl:variable name="ischunk"><xsl:call-template name="chunk"/></xsl:variable>
  <xsl:if test="$ischunk='1'">
   <xsl:text>
      </xsl:text>
   <xsl:call-template name="phpdoc.nav.array">
    <xsl:with-param name="node" select="."/>
   </xsl:call-template>
   <xsl:text>,</xsl:text>
  </xsl:if>
 </xsl:for-each>

 <xsl:text>
    )
  ));
  manualHeader('</xsl:text>
  <xsl:apply-templates select="." mode="phpdoc.object.title"/>
  <xsl:text>','</xsl:text>
  <xsl:call-template name="href.target">
   <xsl:with-param name="object" select="."/>
  </xsl:call-template>
  <xsl:text>');</xsl:text>
<xsl:text disable-output-escaping="yes">
?&gt;
</xsl:text>

</xsl:template>

<xsl:template name="footer.navigation">

<!-- Same as the manualHeader() call above -->
<xsl:text disable-output-escaping="yes">
&lt;?php
</xsl:text>
  <xsl:text>manualFooter('</xsl:text>
  <xsl:apply-templates select="." mode="phpdoc.object.title"/>
  <xsl:text>','</xsl:text>
  <xsl:call-template name="href.target">
   <xsl:with-param name="object" select="."/>
  </xsl:call-template>
  <xsl:text>');</xsl:text>
<xsl:text disable-output-escaping="yes">
?&gt;
</xsl:text>

</xsl:template>

<!-- Eliminate HTML from chunked file contents -->
<xsl:template name="chunk-element-content">
 <xsl:param name="prev"></xsl:param>
 <xsl:param name="next"></xsl:param>
 <xsl:param name="content">
   <xsl:apply-templates/>
 </xsl:param>

 <xsl:call-template name="header.navigation">
  <xsl:with-param name="prev" select="$prev"/>
  <xsl:with-param name="next" select="$next"/>
 </xsl:call-template>

 <xsl:copy-of select="$content"/>

 <xsl:call-template name="footer.navigation">
  <xsl:with-param name="prev" select="$prev"/>
  <xsl:with-param name="next" select="$next"/>
 </xsl:call-template>

</xsl:template>

<!-- Prints out one PHP array with page name and title -->
<xsl:template name="phpdoc.nav.array">
 <xsl:param name="node" select="/foo"/>  
 <xsl:text>array('</xsl:text>
 <xsl:call-template name="href.target">
  <xsl:with-param name="object" select="$node"/>
 </xsl:call-template>
 <xsl:text>','</xsl:text>
 <xsl:apply-templates select="$node" mode="phpdoc.object.title"/>
 <xsl:text>')</xsl:text>
</xsl:template>

<!-- Custom mode for titles for navigation without
     "Chapter 1" and other autogenerated content -->
<xsl:template match="*" mode="phpdoc.object.title">
 <xsl:call-template name="substitute-markup">
  <xsl:with-param name="allow-anchors" select="0"/>
  <xsl:with-param name="template" select="'%t'"/>
 </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
