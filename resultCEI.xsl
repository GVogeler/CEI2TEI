<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"  xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:cei="http://www.monasterium.net/NS/cei" xmlns:atom="http://www.w3.org/2005/Atom"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <xsl:variable name="idno" select="//cei:body/cei:idno"/>
   
    <xsl:result-document href="cei/{$idno}.charter.xml">     
        <atom:entry xmlns:atom="http://www.w3.org/2005/Atom">
            <xsl:copy-of select="//atom:id"/>
            <xsl:copy-of select="//atom:title"></xsl:copy-of>
            <!-- the $originalpfad takes the date from a full backup of the illuminierteUrkunden private collection  -->
            <xsl:variable name="originalpfad" select="concat('file:/C:/Users/buergerm/VolumeD/mom/backup/full20171031-1000/db/mom-data/xrx.user/illuminierteurkunden@gmail.com/metadata.charter/IlluminierteUrkunden/', $idno, '.charter.xml')"></xsl:variable>
            <xsl:copy-of select="document($originalpfad)//atom:published"/>            
            <atom:updated>
                <xsl:value-of select="current-dateTime()"/>
            </atom:updated>
            <atom:author>
                <atom:email>illuminierteurkunden@gmail.com</atom:email>
            </atom:author>
            <app:control xmlns:app="http://www.w3.org/2007/app">
                <app:draft>no</app:draft>
            </app:control>           
            <xsl:if test="//atom:link">
                <xsl:copy-of select="//atom:link"/>
            </xsl:if>
            <atom:content type="application/xml">
            <xsl:copy-of select="//cei:text" />          
            </atom:content>
        </atom:entry>
    </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>