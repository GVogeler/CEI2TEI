<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
  xmlns:xalan="http://xml.apache.org/xslt" exclude-result-prefixes="xs" version="3.0">
  <xsl:output method="xml" indent="yes" xalan:indent-amount="4"/>
  
  <xsl:template match="/">
    <xsl:processing-instruction name="xml-model">href="file:/Z:/Documents/CEI_TEIP5/tei_cei/out/tei_cei.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
    <xsl:apply-templates select="node()|@*"></xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="TEI/text/body[empty(node())]">
    <div type="tenor">
      <p/>
    </div>
  </xsl:template>
  
</xsl:stylesheet>