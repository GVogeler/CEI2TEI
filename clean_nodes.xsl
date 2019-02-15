<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns="http://www.tei-c.org/ns/1.0" xmlns:cei="http://www.monasterium.net/NS/cei"
  xmlns:xalan="http://xml.apache.org/xslt" exclude-result-prefixes="xs" version="3.0">
  <xsl:output method="xml" indent="yes" xalan:indent-amount="4"/>

  <xsl:strip-space elements="*"/>
  
  <xsl:template match="*[descendant::text() or descendant-or-self::*/@*[string()]]">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*[string()]">
    <xsl:copy/>
  </xsl:template>
  
</xsl:stylesheet>
