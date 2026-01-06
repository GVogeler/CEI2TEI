<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:cei="http://www.monasterium.net/NS/cei"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:app="http://www.w3.org/2007/app"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output indent="yes"/><!-- TODO: to remove after testing -->
    <!-- Baseline conversion of CEI MOM to TEI via:
        - mapping existing elements to each other
        - converting dating scheme of CEI MOM to simple TEI
        - adding @ana attributes to more generic elements
        
        Auf den Schemata aufbauend?
        
        - [ ] atom:update, atom:author etc. => tei:revisionDesc?
        - [x] chDesc, issued, diplomaticAnalysis
        - [x] sourceDescVolltext, sourceDescVollRegest, auth,  
        - [ ] sealCondition, legend, sigillant, notariusDesc, chirograph, rubrum, incipit(?), sealDimensions, sealMaterial, nota, archIdentifier, arch, archFond, quoteOriginaldatierung, tenor, invocation, intitulation, arenga, narratio, rogatio, intercessio, dispositio, sanctio, subscriptio, datatio, apprecation, setPhrase, notariusSub, notariusSign, pict, sup, scriptDesc, index, dateRange/date, recipient, issuer, testis, class, scope, h1, h2, a,
        
        - running it over all CEIs in fsdb
        - testing the result against current TEI default schema
        
        - include into MOM-CA as TEI-Export => Niklas
        - include into DiDip fsdb as CH.tei.xml (or CH.tei_4_10_2.xml ...
    -->
    <xsl:template match="cei:cei|/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*"/>
            <xsl:if test="not(cei:teiHeader)">
                <xsl:apply-templates select="/atom:entry" mode="header"/>
            </xsl:if>
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </TEI>
    </xsl:template>
    
    <xsl:template match="cei:lang_MOM" mode="#default chDesc"/>
    <xsl:template match="cei:lang_MOM" mode="header">
        <langUsage><ab><xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></ab></langUsage>
    </xsl:template>


    <!--  ##########################
        Handling teiHeader
     ########################## -->
    <xsl:template match="/atom:entry" mode="header">
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title><xsl:value-of select="atom:id"/></title>
                </titleStmt>
                <publicationStmt>
                    <publisher>ICARus (htts://icar-us.eu)</publisher>
                </publicationStmt>
                <xsl:apply-templates select="//cei:sourceDescRegest|cei:sourceDescVolltext|cei:sourceDesc" mode="header"/>
            </fileDesc>
            <profileDesc>
                <xsl:apply-templates select="//cei:body/cei:chDesc/cei:abstract" mode="header"/>
                <xsl:apply-templates select="//cei:body/cei:chDesc/cei:issued" mode="header"/>
                <xsl:apply-templates select="//cei:body/cei:chDesc/cei:lang_MOM" mode="header"/>
            </profileDesc>
        </teiHeader>
    </xsl:template>
    
    <!--  ##########################
        Handling sourceDesc
        
        TODO: 
        - [ ] add sourceDesc if there none in the CEI
     ########################## -->
    <xsl:template match="cei:front/cei:sourceDesc"/>
    <xsl:template match="cei:sourceDescVolltext|cei:sourceDescRegest|cei:sourceDesc[not(matches(name(*),'^cei:sourceDesc'))]" mode="header">
        <sourceDesc ana="{substring-after(name(),'sourceDesc')}">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>            
        </sourceDesc>
    </xsl:template>

    <!--  ##########################
        Handling abstract
     ########################## -->
    <xsl:template match="cei:body/cei:chDesc/cei:abstract" mode="header">
        <abstract><xsl:apply-templates select="@*"/>
        <xsl:choose>
            <xsl:when test="cei:p">
                <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
            </xsl:when>
            <xsl:otherwise>
                <p><xsl:apply-templates select="node()|comment()|processing-instruction()"/></p>
            </xsl:otherwise>
        </xsl:choose></abstract>
    </xsl:template>
    <xsl:template match="cei:body/cei:chDesc/cei:abstract" mode="chDesc">
        <ab ana="cei:abstract">
            <xsl:apply-templates select="node()|comment()|processing-instruction()"/>          
        </ab>
    </xsl:template>
    <xsl:template match="cei:body/cei:chDesc/cei:abstract"/>

    <!--  ##########################
        Handling issued
     ########################## -->
    <xsl:template match="cei:body/cei:chDesc/cei:issued" mode="header">
        <settingDesc><setting ana="cei:issued">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </setting></settingDesc>
    </xsl:template>
    <xsl:template match="cei:body/cei:chDesc/cei:issued" mode="chDesc">
            <ab ana="cei:issued">
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>                
            </ab>
    </xsl:template>
    <xsl:template match="cei:body/cei:chDesc/cei:issued"/>
    
    <!--  ##########################
        Handling chDesc
     ########################## -->
    <xsl:template match="cei:front">
        <front>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
            <xsl:apply-templates select="//cei:text/cei:body/cei:chDesc" mode="chDesc"/>
        </front>
    </xsl:template>
    
    <xsl:template match="cei:text/cei:body/cei:chDesc" mode="chDesc">
        <!-- This is a kind of work around -->
        <div ana="cei:chDesc">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()" mode="chDesc"/>
        </div>
    </xsl:template>
    <xsl:template match="cei:text/cei:body/cei:chDesc"/>
    
    <xsl:template match="cei:chDesc/cei:diplomaticAnalysis" mode="chDesc">
        <xsl:call-template name="div-creation"/>
    </xsl:template>
    
    <!--  ##########################
        Handling authentication
     ########################## -->
    <xsl:template match="cei:auth" mode="chDesc">
        <div ana="cei:auth">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()" mode="#current"/>            
        </div>
    </xsl:template>
    <xsl:template match="cei:auth"/>
    
    <xsl:template match="cei:auth/cei:sealDesc" mode="msDesc">
        <sealDesc>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="*">
                    <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                </xsl:when>
                <xsl:otherwise>
                    <ab>
                        <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                    </ab>
                </xsl:otherwise>
            </xsl:choose>            
        </sealDesc>
    </xsl:template>
    <xsl:template match="cei:auth/(cei:sealDesc|cei:notariusDesc)" mode="chDesc">
        <xsl:call-template name="div-creation"/>
    </xsl:template>
    <xsl:template match="cei:auth/cei:sealDesc"/>
        

    <!--  ##########################
        Handling witnesses
        
     TODO: 
     - [x] don't create listWit if there is nothing in the CEI
     ########################## -->
    
    <xsl:template match="cei:witListPar" mode="chDesc #default">
        <xsl:if test="*|../cei:witnessOrig"><listWit>
            <xsl:apply-templates select="../cei:witnessOrig" mode="witlist"/>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </listWit></xsl:if>
    </xsl:template>
    <xsl:template match="cei:witnessOrig" mode="witlist">
        <witness ana="original">
            <xsl:apply-templates select="cei:traditioForm"></xsl:apply-templates>
            <msDesc>
                <xsl:apply-templates select="@*|cei:archIdentifier|cei:msIdentifier|comment()|processing-instruction()"/>
                <xsl:apply-templates select="node()[name()!='cei:archIdentifier'][name()!='cei:msIdentifier'][name()!='cei:traditioForm']|comment()|processing-instruction()"/>
            </msDesc>
        </witness>
    </xsl:template>
    <xsl:template match="cei:witnessOrig" mode="#default chDesc"/>
    <xsl:template match="cei:witness">
        <witness>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="cei:traditioForm"></xsl:apply-templates>
            <msDesc>
                <xsl:apply-templates select="@*|cei:archIdentifier|cei:msIdentifier|comment()|processing-instruction()"/>
                <xsl:apply-templates select="node()[name()!='cei:archIdentifier'][name()!='cei:msIdentifier'][name()!='cei:traditioForm']|comment()|processing-instruction()"/>
            </msDesc>
        </witness>
    </xsl:template>
    <xsl:template match="cei:traditioForm">
        <term ana="cei:traditioForm"><!-- VID:24 -->
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </term>
    </xsl:template>
    <xsl:template match="cei:archIdentifier">
        <msIdentifier>
            <xsl:choose>
                <xsl:when test="*">
                    <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></xsl:when>
                <xsl:otherwise>
                    <repository><xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/></repository>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not(cei:idno)">
                <idno><xsl:apply-templates select="//cei:text/cei:body/cei:idno" mode="header"/></idno>
            </xsl:if>
        </msIdentifier>
    </xsl:template>
    <xsl:template match="cei:arch">
        <repository>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </repository>
    </xsl:template>
    
    <xsl:template match="cei:text/cei:body/cei:idno" mode="header">
        <xsl:if test="//cei:archIdentifier/*">
            <idno>
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
            </idno>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cei:body/cei:idno"/>
    
    <xsl:template match="cei:physicalDesc">
        <physDesc>
            <objectDesc>
                <supportDesc>
                    <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
                </supportDesc>
            </objectDesc>
            <xsl:apply-templates select="//cei:auth/cei:sealDesc" mode="msDesc"/>
        </physDesc>
    </xsl:template>
    
    <xsl:template match="(cei:witness|cei:witnessOrig)/cei:figure">
        <additional>
            <surrogates>
                <figure>
                    <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
                    <xsl:apply-templates select="cei:graphic/text()" mode="chDesc"/>
                </figure>
            </surrogates>
        </additional>
    </xsl:template>
    <xsl:template match="cei:graphic/text()" mode="chDesc">
        <desc>
            <xsl:value-of select="."/>
        </desc>
    </xsl:template>
    <xsl:template match="cei:graphic/text()"/>
    
    <!-- FIXME:
        - making the witnesses nest according to TEI conventions
    -->
    <xsl:template match="cei:physicalDesc/cei:material">
        <support>
            <material>
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
            </material>
        </support>
    </xsl:template>
    
    <!-- ##########################
        handling lists in back
     ########################## -->
    <xsl:template match="cei:back">
        <back>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="not(cei:p|cei:div)">
                    <div>
                        <ab>
                            <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                        </ab>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                </xsl:otherwise>
            </xsl:choose>
        </back>
    </xsl:template>

    <!-- ##########################
        Handling persName and placeName
     ########################## -->
    <xsl:template match="cei:persName|cei:placeName">
        <xsl:variable name="elname" select="substring-after(name(.),'cei:')"/>
        <xsl:element name="{$elname}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*[not(name()='reg')]"/>
            <xsl:apply-templates select="@*[name()='reg']|node()|comment()|processing-instruction()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="(cei:persName|cei:placeName)/@reg">
        <reg><xsl:value-of select="."/></reg>
    </xsl:template>
    
    <!-- ##########################
        Handling @type attributes
     ########################## -->
    <xsl:template match="@type">
    </xsl:template>
    
    <!-- ##########################
        Handling the rather strange MOM style date
     ########################## -->
    <xsl:template match="cei:date|cei:dateRange">
        <!-- Text, ob das andere die besseren Daten hat, entfernen der 999999999, umwandeln der Element in date -->
        <!-- ToDo: cei:quoteOriginaldatierung hier integrieren? -->
        <xsl:choose>
            <xsl:when test="../cei:dateRage/@from!=99999999 and ../cei:dateRage/@to!=99999999">
                <xsl:variable name="iso-from" select="replace(@from,'(\d\d\d\d)(\d\d)(\d\d)','$1-$2-$3')"/>
                <xsl:variable name="iso-to" select="replace(@to,'(\d\d\d\d)(\d\d)(\d\d)','$1-$2-$3')"/>
                <date not-before="{replace($iso-from,'^0+','')}" not-after="{replace($iso-to,'^0+','')}">
                    <xsl:call-template name="dateContent"/>
                </date>
            </xsl:when>
            <xsl:when test="../cei:dateRage/@from!=99999999 and ../cei:dateRage/@to=99999999">
                <xsl:variable name="iso-from" select="replace(@from,'(\d\d\d\d)(\d\d)(\d\d)','$1-$2-$3')"/>
                <date not-before="{replace($iso-from,'^0+','')}">
                    <xsl:apply-templates select="@*[name()!='from' and name()!='to']|node()|comment()|processing-instruction()"/>
                </date>
            </xsl:when>
            <xsl:when test="../cei:dateRage/@from=99999999 and ../cei:dateRage/@to!=99999999">
                <xsl:variable name="iso-to" select="replace(@to,'(\d\d\d\d)(\d\d)(\d\d)','$1-$2-$3')"/>
                <date not-after="{replace($iso-to,'^0+','')}">
                    <xsl:apply-templates select="@*[name()!='from' and name()!='to']|node()|comment()|processing-instruction()"/>
                </date>
            </xsl:when>
            <xsl:when test="../cei:date/@value!=99999999">
                <xsl:variable name="iso-date" select="replace(@value,'(\d\d\d\d)(\d\d)(\d\d)','$1-$2-$3')"/>
                <date when="{replace($iso-date,'^0+','')}">
                    <xsl:apply-templates select="@*[name()!='value']|node()|comment()|processing-instruction()"/>
                </date>
            </xsl:when>
            <xsl:otherwise>
                <!-- Achtung, das darf nur einmal vorkommen! -->
                <date>
                    <xsl:apply-templates select="@*[name()!='value' and name()!='from' and name()!='to']|node()|comment()|processing-instruction()"/>
                </date>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="dateContent">
        <xsl:apply-templates select="@*[name()!='from' and name()!='to']|node()|comment()|processing-instruction()"/>
        <xsl:if test="../cei:quoteOriginaldatierung">
            <xsl:apply-templates select="../cei:quoteOriginaldatierung" mode="date"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cei:quoteOriginaldatierung" mode="date">
        <quote>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </quote>
    </xsl:template>
    <xsl:template match="cei:quoteOriginaldatierung"/>
    
    <xsl:template match="cei:tenor">
        <xsl:call-template name="div-creation"/>
    </xsl:template>
    
    <xsl:template match="cei:pTenor">
        <p>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </p>
    </xsl:template>
    <xsl:template match="cei:divNotes">
        <xsl:if test="node()">
            <div type="notes">
                <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!--  ##########################
        html relics 
     ########################## -->
    <xsl:template match="cei:h1">
        <head type="{name()}">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </head>
    </xsl:template>
    
    
    <!--  ##########################
        Fallback for simple matches 
     ########################## -->
    <xsl:template match="cei:*" priority="-2" mode="#default">
        <xsl:variable name="elname" select="substring-after(name(.),'cei:')"/>
        <xsl:element name="{$elname}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="@*|node()|comment()|processing-instruction()" priority="-3">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()|comment()|processing-instruction()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@id" priority="-2">
        <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace/">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
    
    <!--  ##########################
        fall backs
     ########################## -->
    <xsl:template match="cei:body[not(cei:tenor)][not(text())]">
        <body>
            <xsl:apply-templates select="@*|comment()|processing-instruction()"/>
            <ab><xsl:comment>No texte available</xsl:comment></ab>
        </body>
    </xsl:template>
    
    <!--  ##########################
        atom header
     ########################## -->
    <xsl:template match="atom:*|app:*">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    
    <!-- ############################
     generic div creation
    ########################## -->
    <xsl:template name="div-creation">
        <div ana="{name()}">
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="*">
                    <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                </xsl:when>
                <xsl:otherwise>
                    <ab>
                        <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
                    </ab>
                </xsl:otherwise>
            </xsl:choose>            
        </div>
    </xsl:template>
    <!--  ##########################
        Throw-away information
     ########################## -->
    <xsl:template match="cei:text/@id|cei:text/@b_name|cei:idno/@id|cei:idno/@old" mode="#all"/>
</xsl:stylesheet>