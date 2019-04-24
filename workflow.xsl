<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns="http://www.tei-c.org/ns/1.0" xmlns:cei="http://www.monasterium.net/NS/cei"
  xmlns:xalan="http://xml.apache.org/xslt" exclude-result-prefixes="xs" version="3.0">
  <xsl:output method="xml" indent="yes" xalan:indent-amount="4"/>
  <xsl:strip-space elements="*"/>
  <!--****************************
      Dieses Stylesheet regelt das Preprocessing und die Konversion von CEI docs zu TEI docs 
      1. Step-1: Unnötige leere Elemente aus dem CEI werden entfernt
      2. Step-2: Konversion von CEI zu TEI
      3. Step-3: TEI-Validität erzeugen (body befüllen)
      
      
      ****************************
  -->
  <xsl:variable name="oldid">
    <xsl:value-of
      select="substring-after(//atom:id, 'tag:www.monasterium.net,2011:/charter/')"
    />
  </xsl:variable>
  <!-- xpath-default-namespace entfernt auch aus body-filler
        var fond-imgs integrates urls from monasterium fonds -->
  <xsl:variable name="fond-imgs" select="document('Listeversionofimages.xml')//eintrag[id = $oldid]"/>
  <!-- Entries in subcollections of illurk extracted from List  -->
  <xsl:variable name="nebensammlungen" select="document('NebensammlungDatumgeordnet.xml')//neben[id= substring-after($oldid,'/')]"/>
    
  <xsl:variable name="step-1">
    <xsl:apply-templates mode="step-1"></xsl:apply-templates>
  </xsl:variable>
  <xsl:template match="*[descendant::text() or descendant-or-self::*/@*[string()]]" mode="step-1">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="step-1"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@*[string()]" mode="step-1">
    <xsl:copy/>
  </xsl:template>
  
  <xsl:variable name="step-2">
    <xsl:apply-templates select="$step-1" mode="step-2"/>
  </xsl:variable>

  <xsl:template match="$step-1" mode="step-2">    
        <!--<xsl:processing-instruction name="xml-model">href="file:/Z:/Documents/CEI_TEIP5/tei_cei/out/tei_cei.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>-->
        <!-- Various Variables -->
        <xsl:variable name="atom_published" select="/atom:entry/atom:published"/>
        <xsl:variable name="atom_updated" select="/atom:entry/atom:updated"/>
    
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title/>
                        <editor>
                            <xsl:value-of select="//atom:email"/>
                        </editor>
                        <principal>
                            <persName ref="https://orcid.org/0000-0002-1726-1712" xml:id="gv">
                                <forename>Georg</forename>
                                <surname>Vogeler</surname>
                            </persName>
                        </principal>
                        <respStmt>
                            <resp>Project Lead; Art historical description</resp>
                            <persName ref="https://orcid.org/0000-0002-9503-7097" xml:id="mr">
                                <forename>Martin</forename>
                                <surname>Roland</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Art historical description</resp>
                            <persName ref="https://orcid.org/0000-0002-8406-0785" xml:id="gb">
                                <forename>Gabriele</forename>
                                <surname>Bartz</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Diplomatic description</resp>
                            <persName ref="https://orcid.org/0000-0003-3269-453X" xml:id="mg">
                                <forename>Markus</forename>
                                <surname>Gneiß</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Project Lead; Diplomatic description</resp>
                            <persName ref="https://orcid.org/0000-0002-1967-6022" xml:id="az">
                                <forename>Andreas</forename>
                                <surname>Zajic</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Digital transformation; modelling</resp>
                            <persName ref="https://orcid.org/0000-0002-5114-0594" xml:id="sw">
                                <forename>Sean</forename>
                                <surname>Winslow</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Digital transformation</resp>
                            <persName ref="https://orcid.org/0000-0003-0594-1902" xml:id="mb">
                                <forename>Martina</forename>
                                <surname>Bürgermeister</surname>
                            </persName>
                        </respStmt>
                        <funder>
                            <orgName ref="https://www.fwf.ac.at/">
                                <choice>
                                    <expan>Fonds zur Förderung der wissenschaftlichen
                                        Forschung</expan>
                                    <abbr>FWF</abbr>
                                </choice>
                            </orgName> Projekt P 26706-G21 "Illuminierten Urkunden als
                            Gesamtkunstwerk" and Projekt FWF-ORD84 "Erhalt fachspezifischer
                            Funktionalitäten bei Langzeitarchivierung in einem allgemeinen
                            Datenarchiv für die Geisteswissenschaften."</funder>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>
                            <orgName ref="http://d-nb.info/gnd/1137284463"
                                corresp="https://informationsmodellierung.uni-graz.at">Zentrum für
                                Informationsmodellierung - Austrian Centre for Digital Humanities,
                                Karl-Franzens-Universität Graz</orgName>
                            <!-- old id is included in the new id -->
                            <idno type="PID" resp="https://illuminierte-urkunden.uni-graz.at/">
                                <xsl:value-of
                                    select="concat('o:cord.',replace(substring-after(atom:entry/atom:id, 'charter/'), '/', '.'))"
                                />
                            </idno>
                           
                            <xsl:variable name="contextname2">
                                <xsl:value-of select="substring-after(atom:entry/atom:id, 'charter/')"/>
                            </xsl:variable>
                            <xsl:variable name="contextname1">
                                <xsl:value-of select="concat('/', tokenize($contextname2, '/')[last()])"></xsl:value-of>
                            </xsl:variable>
                            <xsl:variable name="contextname">
                                <xsl:value-of select="concat('context:cord.', substring-before($contextname2, $contextname1) )"/>
                            </xsl:variable>
                            <ref target="{$contextname}" type="context"><xsl:value-of select="$contextname"/></ref>                        </publisher>
                        <distributor>
                            <orgName ref="https://gams.uni-graz.at">GAMS - Geisteswissenschaftliches
                                Asset Management System</orgName>
                          
                        </distributor>
                        <availability>
                            <p>All texts and pictures are protected according to national copyrights
                                and exploitation rights. Furthermore, all rights of publication and
                                duplication of the pictorial reproductions of the documents are held
                                by the respective archive’s proprietor. Any means of publication is
                                therefore bound to above mentioned authorization and infringement is
                                punishable.</p>
                            <p>We would like to make all users aware that addresses, time and
                                duration of access will be stored on our server. The place of
                                jurisdiction for all disputes arising from this agreement is the
                                court nearest to the respective archive.</p>
                            <p>Conditions of use of printed editions and depictions apply in the
                                same way to scientific utilization. Citation according to good
                                scientific practice is therefore expected. (URL, author,
                                archive)</p>
                            <p>When publishing or duplicating research results (including
                                unpublished theses and dissertations) obtained from data provided by
                                Monasterium.Net, we would like to ask every user to pass a free
                                sample copy to the respective holder of the originals (archive).</p>
                        </availability>
                        <pubPlace><placeName>Graz</placeName></pubPlace>
                      <date>
                            <xsl:value-of select="current-dateTime()"/>  <!-- hOW TO MAKE THIS STABLE ACROSS Multiple Imports? -->
                        </date>
                    </publicationStmt>
                    <sourceDesc>
                        <bibl>Originally converted to TEI based upon a CEI file from <ref
                                target="http://monasterium.net/">Monasterium</ref>, <idno
                                type="Monasterium">
                                <xsl:value-of
                                    select="substring-after(//atom:id, 'tag:www.monasterium.net,2011:/charter/')"
                                />
                            </idno>, created on <date when="{$atom_published}"><xsl:value-of
                                    select="format-dateTime($atom_published, '[Y]-[M]-[D]')"
                                /></date> and last updated on <date when="{$atom_updated}"
                                    ><xsl:value-of
                                    select="format-dateTime($atom_updated, '[Y]-[M]-[D]')"/></date>. </bibl>
                        <xsl:for-each
                            select="//cei:sourceDesc | //cei:sourceDescRegest | //cei:sourceDescVolltext | //cei:sourceDescErw">
                            
                            <!-- Nested bbibl elements in SourceDescRegest -->
                            <xsl:apply-templates select="cei:bibl[. != '']"/>
                        </xsl:for-each>
                        <!-- Hier wird der atom:link erhalten mit bibl type version: Gut Idee? -->
                        <xsl:if test="//atom:link">
                            <bibl type="version">
                                <ref><xsl:attribute name="target">
                                   <xsl:text>http://monasterium.net/mom/</xsl:text>
                                    <xsl:value-of select="substring-after(//atom:link/@ref, 'charter/')"/>
                                   <xsl:text>/charter</xsl:text>
                                </xsl:attribute></ref>
                            </bibl>
                 
                        </xsl:if>
                        <listWit>
                            <xsl:call-template name="original_witness"/>
                            <xsl:if test="//cei:chDesc/cei:witListPar//*[. != '']">
                                <xsl:apply-templates select="//cei:chDesc/cei:witListPar"/>
                            </xsl:if>
                        </listWit>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <projectDesc>
                        <p>The <ref target="https://illuminierte-urkunden.uni-graz.at">Illuminierte
                                Urkunden</ref> project is a cross-disciplinary historical,
                            art-historical, and digital humanities project which collects
                            illuminated medieval charters from all over Europe, publishes them, and
                            explores them in detailed studies.</p>
                    </projectDesc>
                    <listPrefixDef>
                        <prefixDef ident="zotero" matchPattern="([a-z]+[a-z0-9]*)"
                            replacementPattern="http://zotero.org/groups/257864/items/$1">
                            <p part="N"> Private URIs using the bibl prefix can be expanded to form
                                URIs which retrieve the relevant bibliographical reference from
                                Zotero. </p>
                        </prefixDef>
                    </listPrefixDef>
                </encodingDesc>
                <profileDesc>
                    <abstract>
                        <xsl:apply-templates select="//cei:abstract"/>
                    </abstract>
                    <xsl:apply-templates select="//cei:lang_MOM"/>
                    <textClass>
                       <!-- <ref target="info:fedora/context:fercan.dedication.votum_solvit_libens_merito" type="context">votum solvit libens merito</ref>-->
                        
                        <!-- have to define a rule for keywords, which don't have @ as well-->
                        <xsl:for-each-group select="//cei:index[. != '']" group-by="@indexName">                          
                            <xsl:call-template name="keywords"/>
                        </xsl:for-each-group>
                    </textClass>
                    <xsl:if
                        test="//cei:back//cei:persName[. != ''] | //cei:back//cei:orgName[. != '']">
                        <particDesc>
                            <xsl:if test="//cei:back//cei:persName[. != '']">
                                <listPerson>
                                    <xsl:for-each select="//cei:back//cei:persName">
                                        <xsl:sort order="ascending" select="."/>
                                        <xsl:choose>
                                            <xsl:when test="@key">                                               
                                                <xsl:for-each-group select="." group-by="@key">
                                                    <xsl:call-template name="list_people"/>
                                                </xsl:for-each-group>
                                            </xsl:when>
                                            <xsl:when test="@reg">                                               
                                                <xsl:for-each-group select="." group-by="@reg">
                                                    <xsl:call-template name="list_people"/>
                                                </xsl:for-each-group>
                                            </xsl:when>
                                            <xsl:otherwise>                                               
                                                <xsl:for-each-group select="." group-by=".">
                                                  <xsl:call-template name="list_people"/>
                                                </xsl:for-each-group>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </listPerson>
                            </xsl:if>
                            <xsl:if test="//cei:back//cei:orgName[. != '']">
                                <listOrg>
                                    <xsl:for-each select="//cei:back//cei:orgName[. != '']">
                                        <xsl:sort order="ascending" select="."/>
                                        <xsl:choose>
                                            <xsl:when test="@key">                                               
                                                <xsl:for-each-group select="." group-by="@key">
                                                    <xsl:call-template name="list_orgs"/>
                                                </xsl:for-each-group>
                                            </xsl:when>
                                            <xsl:when test="@reg">                                               
                                                <xsl:for-each-group select="." group-by="@reg">
                                                    <xsl:call-template name="list_orgs"/>
                                                </xsl:for-each-group>
                                            </xsl:when>
                                            <xsl:otherwise>                                               
                                                <xsl:for-each-group select="." group-by=".">
                                                    <xsl:call-template name="list_orgs"/>
                                                </xsl:for-each-group>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </listOrg>
                            </xsl:if>
                        </particDesc>
                    </xsl:if>
                    <xsl:if test="//cei:back//cei:placeName[. != '']">
                        <settingDesc>
                            <listPlace>
                            
                                <xsl:for-each select="//cei:back//cei:placeName[. != '']">
                                    <xsl:sort order="ascending" select="."/>
                                    
                          <!--          <xsl:choose>
                                        <xsl:when test="@key">                                               
                                            <xsl:for-each-group select="." group-by="@key">
                                                <xsl:value-of select="."/>
                                            </xsl:for-each-group>
                                        </xsl:when>
                                      <xsl:when test="@reg">                                               
                                            <xsl:for-each-group select="." group-by="@reg">
                                                <xsl:call-template name="list_places"/>
                                            </xsl:for-each-group>
                                        </xsl:when>
                                        <xsl:otherwise>    -->                                           
                                            <xsl:for-each-group select="." group-by=".">
                                                <xsl:apply-templates select="." />                                              
                                            </xsl:for-each-group>
                                <!--        </xsl:otherwise>
                                    </xsl:choose>-->
                                </xsl:for-each>
                            </listPlace>
                        </settingDesc>
                    </xsl:if>
                </profileDesc>
                <!-- <revisionDesc>
                Use revisionDesc only for changes to TEI file. atom:updated is referenced in sourceDesc. Need a way to track changes across imports to this space.
                </revisionDesc>-->
            </teiHeader>

            <xsl:if test="//cei:graphic[@url != ''] or $fond-imgs != ''">
                <facsimile>
                    <xsl:apply-templates select="//cei:graphic[@url != '']" mode="image"/>
                    <xsl:if test="$fond-imgs != ''">
                        <xsl:for-each select="$fond-imgs/image-url">
                            <graphic url="{.}"/>
                        </xsl:for-each>
                    </xsl:if>
                </facsimile>
            </xsl:if>          
            <text>
                <body>                    
                    <xsl:apply-templates select="//cei:tenor"/>
                </body>
            </text>
        </TEI>
  </xsl:template>
    <xsl:template name="original_witness">
        <witness>
            <msDesc>
                   <xsl:apply-templates select="//cei:witnessOrig/cei:archIdentifier"/>
                <xsl:apply-templates select="//cei:witnessOrig/cei:physicalDesc"/>
                <diploDesc>
                    <xsl:apply-templates select="//cei:witnessOrig/cei:traditioForm"/>
                    <xsl:apply-templates select="//cei:diplomaticAnalysis"/>
                    <issued>
                        <xsl:apply-templates select="//cei:issued"/>
                    </issued>
                </diploDesc>
                <xsl:apply-templates select="//cei:witnessOrig/cei:auth[. != '']"/>
                <!-- There are  cei:figure tags in witnessOrig that need to be moved to facsimile (no anchors neeeded?) -->
            </msDesc>
        </witness>
    </xsl:template>
    <xsl:template match="cei:abstract">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="cei:add">
        <add>
            <xsl:apply-templates/>
        </add>
    </xsl:template>
    <xsl:template match="cei:altIdentifier">
        <altIdentifier>
            <xsl:if test="@ana != ''">
                <xsl:attribute name="ana">
                    <xsl:value-of select="@ana"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@type != ''">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </altIdentifier>
    </xsl:template>
    <xsl:template match="cei:app">
        <app>
            <xsl:apply-templates/>
        </app>
    </xsl:template>
    <xsl:template match="cei:arch">
        <repository>
            <xsl:apply-templates/>
        </repository>
    </xsl:template>
    <xsl:template match="cei:archFond">
        <collection>
            <xsl:apply-templates/>
        </collection>
    </xsl:template>
    <xsl:template match="cei:arenga">
        <diploPart type="arenga">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:witness/cei:auth[. != '']">
        <authDesc>
            <xsl:apply-templates/>
            <xsl:apply-templates select="../cei:sealDesc[. != '']"/>
        </authDesc>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:auth[. != '']">
        <authDesc>
            <xsl:apply-templates/>
            <xsl:apply-templates select="../cei:sealDesc[. != '']"/>
        </authDesc>
    </xsl:template>
    <xsl:template match="cei:author">
        <author>
            <xsl:apply-templates/>
        </author>
    </xsl:template>
    <xsl:template match="cei:availability">
        <availability>
            <xsl:apply-templates/>
        </availability>
    </xsl:template>
<!--    <xsl:template match="cei:back/cei:persName">
        <person>
            <xsl:apply-templates/>
        </person>
    </xsl:template>
    <xsl:template match="cei:back/cei:placeName">
        <place>
            <xsl:apply-templates/>
        </place>
    </xsl:template>-->
    <xsl:template match="cei:back/cei:orgName">
        <org>
            <xsl:apply-templates/>
        </org>
    </xsl:template>
    <xsl:template match="cei:bibl">
        <bibl>
            <xsl:if test="@key != ''">
                <xsl:variable name="key" select="@key"/>
                <ref target="{$key}"/>
            </xsl:if>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
   <!-- <xsl:template match="cei:body[. != '']">
            <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="cei:c">
        <g>
            <xsl:apply-templates/>
        </g>
    </xsl:template>
    <xsl:template match="cei:chDesc">
        <!--    <xsl:apply-templates/> -->
    </xsl:template>
    <xsl:template match="cei:cit">
        <cit>
            <xsl:apply-templates/>
        </cit>
    </xsl:template>
    <xsl:template match="cei:condition">
        <condition>
            <xsl:apply-templates/>
        </condition>
    </xsl:template>
    <xsl:template match="cei:corr">
        <corr>
            <xsl:apply-templates/>
        </corr>
    </xsl:template>
    <xsl:template match="cei:corrobatio">
        <diploPart type="corrobation">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:datatio">
        <diploPart type="datatio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:dispositio">
        <diploPart type="dispositio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:inscriptio">
        <diploPart type="inscriptio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:intitulatio">
        <diploPart type="intitulatio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:invocatio">
        <diploPart type="invocatio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:narratio">
        <diploPart type="narratio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:publicatio">
        <diploPart type="publicatio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:sanctio">
        <diploPart type="sanctio">
            <xsl:apply-templates/>
        </diploPart>
    </xsl:template>
    <xsl:template match="cei:country">
        <country>
            <xsl:apply-templates/>
        </country>
    </xsl:template>
    <xsl:template match="cei:damage">
        <damage>
            <xsl:apply-templates/>
        </damage>
    </xsl:template>
    <xsl:template match="cei:date">
        <date>
            <xsl:apply-templates/>
        </date>
    </xsl:template>
    <xsl:template match="cei:dateRange">
        <xsl:variable name="from" select="@from"/>
        <xsl:variable name="to" select="@to"/>
        <xsl:choose>
            <xsl:when test="$from = $to">
                <date when="{$from}">
                    <xsl:apply-templates/>
                </date>
            </xsl:when>
            <xsl:otherwise>
                <date from="{$from}" to="{$to}">
                    <xsl:apply-templates/>
                </date>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cei:decoDesc[. != '']">
        <decoDesc>
            <xsl:apply-templates/>
        </decoDesc>
    </xsl:template>
    <xsl:template match="cei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    <xsl:template match="cei:desc">
        <desc>
            <xsl:apply-templates/>
        </desc>
    </xsl:template>
    <xsl:template match="cei:dimensions">
        <!-- no text allowed within dimensions -->
        <dimensions>
            <xsl:apply-templates select="node()[text()]"/>
        </dimensions>
    </xsl:template>
    <xsl:template match="cei:diplomaticAnalysis">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:div">
        <!--| cei:divNotes -->
        <div>
            <xsl:apply-templates select="cei:p"/>
            <xsl:call-template name="p_in_div"/>
        </div>
    </xsl:template>
    <xsl:template match="cei:divNotes">
        <div>
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>
    <xsl:template match="cei:expan">
        <expan>
            <xsl:apply-templates/>
        </expan>
    </xsl:template>
    <xsl:template match="cei:figDesc">
        <figDesc>
            <xsl:apply-templates/>
        </figDesc>
    </xsl:template>
    <!-- <xsl:template match="cei:figure">
        <figure><xsl:apply-templates/></figure>
    </xsl:template> -->
    <xsl:template match="cei:foreign">
        <foreign>
            <xsl:apply-templates/>
        </foreign>
    </xsl:template>
    <xsl:template match="cei:forename">
        <forename>
            <xsl:apply-templates/>
        </forename>
    </xsl:template>
    <xsl:template match="cei:geogName">
        <geogName>
            <xsl:apply-templates/>
        </geogName>
    </xsl:template>
    <xsl:template match="cei:graphic" mode="image">
        <graphic url="{@url}"/>      
    </xsl:template>
    <xsl:template match="cei:group">
        <group>
            <xsl:apply-templates/>
        </group>
    </xsl:template>
    <xsl:template match="cei:handShift">
        <handShift>
            <xsl:apply-templates/>
        </handShift>
    </xsl:template>
    <xsl:template match="cei:height">
        <xsl:variable name="unit">
            <xsl:choose>
                <xsl:when test="contains(parent::cei:dimensions, 'mm')">
                    <xsl:text>mm</xsl:text>
                </xsl:when>
                <xsl:when test="contains(parent::cei:dimensions, 'cm')">
                    <xsl:text>cm</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <height>
            <xsl:if test="$unit[. != '']">
                <xsl:attribute name="unit" select="$unit"/>
            </xsl:if>
            <xsl:apply-templates/>
        </height>
    </xsl:template>
    <xsl:template match="cei:hi">
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="cei:plica">
        <xsl:variable name="unit">
            <xsl:choose>
                <xsl:when test="contains(parent::cei:dimensions, 'mm')">
                    <xsl:text>mm</xsl:text>
                </xsl:when>
                <xsl:when test="contains(parent::cei:dimensions, 'cm')">
                    <xsl:text>cm</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <plica>
            <xsl:if test="$unit[. != '']">
                <xsl:attribute name="unit" select="$unit"/>
            </xsl:if>
            <xsl:apply-templates/>
        </plica>
    </xsl:template>
    <xsl:template match="cei:hi">
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:archIdentifier">
        <msIdentifier>
            <xsl:apply-templates select="cei:country"/>
            <xsl:apply-templates select="cei:region"/>
            <xsl:apply-templates select="cei:settlement"/>
            <xsl:apply-templates select="cei:institution"/>
            <xsl:apply-templates select="cei:arch | cei:repository"/>
            <xsl:apply-templates select="cei:archFond"/>
            <xsl:apply-templates select="cei:idno"/>
            <xsl:apply-templates select="cei:altIdentifier"/>
            <xsl:apply-templates select="cei:note"/>
        </msIdentifier>
    </xsl:template>
    <xsl:template match="cei:witness/cei:archIdentifier">
        <msIdentifier>
            <xsl:apply-templates select="cei:country"/>
            <xsl:apply-templates select="cei:region"/>
            <xsl:apply-templates select="cei:settlement"/>
            <xsl:apply-templates select="cei:institution"/>
            <xsl:apply-templates select="cei:arch | cei:repository"/>
            <xsl:apply-templates select="cei:archFond"/>
            <xsl:apply-templates select="cei:idno"/>
            <xsl:apply-templates select="cei:altIdentifier"/>
            <xsl:apply-templates select="cei:note"/>
        </msIdentifier>
    </xsl:template>
    <!--  NOT IN USE  
    <xsl:template match="cei:body/cei:idno">        
    </xsl:template>-->
    <xsl:template match="cei:idno[not(parent::cei:body)]">
        <idno>
            <xsl:apply-templates/>
        </idno>
    </xsl:template>
    <!--   <xsl:template match="cei:image_server_address">
        <image_server_address><xsl:apply-templates/></image_server_address>
    </xsl:template>
    <xsl:template match="cei:image_server_folder">
        <image_server_folder><xsl:apply-templates/></image_server_folder>
    </xsl:template>-->
    <xsl:template match="cei:imprint">
        <imprint>
            <xsl:apply-templates/>
        </imprint>
    </xsl:template>
    <xsl:template match="cei:body//cei:index[. != '']">
      <!--  <term>-->
            <xsl:call-template name="vocab_uri"/>
        <!--</term>-->
    </xsl:template>
    <xsl:template match="cei:institution">
        <institution>
            <xsl:apply-templates/>
        </institution>
    </xsl:template>
    <xsl:template match="//cei:issued">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:issuer">
        <legalActor type="issuer">
            <xsl:apply-templates/>
        </legalActor>
    </xsl:template>
    <xsl:template match="cei:lang_MOM">
        <xsl:variable name="langmom" select="."/>
        <xsl:for-each select="document('lang_MOM.xml')//lang_MOM_entry">
            <xsl:if test="lang_mom[text() = $langmom]">
                <langUsage>
                    <xsl:for-each select="tokenize(lang_iso, ',')">
                        <xsl:variable name="token" select="normalize-space(.)"/>
                        <language ident="{$token}">
                            <xsl:value-of select="$langmom"/>
                        </language>
                    </xsl:for-each>
                </langUsage>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="cei:lb">
        <lb>
            <xsl:apply-templates/>
        </lb>
    </xsl:template>
    <xsl:template match="cei:legend">
        <legend>
            <xsl:apply-templates/>
        </legend>
    </xsl:template>
    <!--<xsl:template match="cei:lem">
        <lem><xsl:apply-templates/></lem>
    </xsl:template>-->
    <xsl:template match="cei:listBibl">
        <listBibl type="other">
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="cei:listBiblEdition">
        <listBibl type="edition">
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="cei:listBiblErw">
        <listBibl type="unknown">
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="cei:listBiblFacsimile">
        <listBibl type="facsimile">
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="cei:listBiblRegest">
        <listBibl type="regest">
            <xsl:apply-templates/>
        </listBibl>
    </xsl:template>
    <xsl:template match="cei:material">
        <material>
            <xsl:apply-templates/>
        </material>
    </xsl:template>
    <xsl:template match="cei:measure">
        <measure>
            <xsl:apply-templates/>
        </measure>
    </xsl:template>
    <xsl:template match="cei:nota">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:note[. != '']">
        <note>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    <!-- <xsl:template match="cei:notariusDesc"> 
        <authen><xsl:apply-templates/></authen>
    </xsl:template> SIX APPEARANCES IN DATA ; NEEDS TO BE FIXED
    <xsl:template match="cei:notariusSign"> DOES NOT APPEAR IN DATA
        <authen><xsl:apply-templates/></authen>
    </xsl:template>-->
    <xsl:template match="cei:notariusDesc[. != '']">
        <authen type="signed">
            <legalActor type="notary">
                <xsl:apply-templates/>
            </legalActor>
        </authen>
    </xsl:template>
    <xsl:template match="cei:num">
        <num>
            <xsl:apply-templates/>
        </num>
    </xsl:template>
    <xsl:template match="cei:orgName">
        <orgName>
            <xsl:apply-templates/>
        </orgName>
    </xsl:template>
    <xsl:template match="cei:p[. != ''] | cei:pTenor[. != '']">
        <p>
            <xsl:if test="@n != ''">
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <!--  <xsl:template match="cei:password">
        <password><xsl:apply-templates/></password>
    </xsl:template>-->
    <xsl:template match="cei:pb">
        <pb>
            <xsl:apply-templates/>
        </pb>
    </xsl:template>
    <xsl:template match="cei:persName">
        <persName>
            <xsl:apply-templates/>
        </persName>
    </xsl:template>
    <xsl:template match="cei:witness/cei:physicalDesc">
        <physDesc>
            <objectDesc>
                <supportDesc>
                    <support>
                        <xsl:apply-templates select="cei:material"/>
                        <xsl:apply-templates select="cei:dimensions"/>
                    </support>
                    <xsl:apply-templates select="cei:condition"/>
                </supportDesc>
            </objectDesc>
            <xsl:apply-templates select="cei:decoDesc"/>
            <xsl:if test="./../cei:nota[. != '']">
                <additions>
                    <xsl:apply-templates select="parent::*//cei:nota"/>
                </additions>
            </xsl:if>
        </physDesc>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:physicalDesc">
        <physDesc>
            <objectDesc>
                <supportDesc>
                    <support>
                        <xsl:apply-templates select="cei:material"/>
                        <xsl:apply-templates select="cei:dimensions"/>
                    </support>
                    <xsl:apply-templates select="cei:condition"/>
                </supportDesc>
            </objectDesc>
            <xsl:apply-templates select="cei:decoDesc"/>
            <xsl:if test="parent::*//cei:nota[. != '']">
                <additions>
                    <xsl:apply-templates select="parent::*//cei:nota"/>
                </additions>
            </xsl:if>
        </physDesc>
    </xsl:template>
    <!--    <xsl:template match="cei:pict">
        <pict><xsl:apply-templates/></pict>
    </xsl:template>-->
    <xsl:template match="cei:placeName">
       <place>        
           <placeName>
               <xsl:choose>
               <xsl:when test="(@type='Region')">
                        <region>
                            <xsl:value-of select="."/>
                        </region>
                    </xsl:when>
                    <xsl:when test="(@n='Region')">
                        <region>
                            <xsl:value-of select="."/>
                        </region>
                    </xsl:when>
               <xsl:otherwise>
                   <xsl:for-each select="@*">
                       <xsl:attribute name="{name()}">
                           <xsl:value-of select="."/>
                       </xsl:attribute>
                   </xsl:for-each>
                   <xsl:apply-templates/>
               </xsl:otherwise>
               </xsl:choose>
        </placeName>
       </place>
    </xsl:template>
    <xsl:template match="@reg">
       <xsl:copy></xsl:copy>
    </xsl:template>
    <xsl:template match="cei:provenance">
        <provenance>
            <xsl:apply-templates/>
        </provenance>
    </xsl:template>
    <xsl:template match="cei:pubPlace">
        <pubPlace>
            <xsl:apply-templates/>
        </pubPlace>
    </xsl:template>
    <xsl:template match="cei:quote">
        <quote>
            <xsl:if test="@type[. = 'italic']">
                <xsl:attribute name="rend">italic</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    <xsl:template match="cei:quoteOriginaldatierung[. != '']">
        <p>
            <quote>
                <date>
                    <xsl:apply-templates/>
                </date>
            </quote>
        </p>
    </xsl:template>
    <xsl:template match="cei:rdg">
        <rdg>
            <xsl:apply-templates/>
        </rdg>
    </xsl:template>
    <xsl:template match="cei:recipient">
        <legalActor type="recipient">
            <xsl:apply-templates/>
        </legalActor>
    </xsl:template>
    <xsl:template match="cei:ref">
        <xsl:choose>
            <xsl:when test="@target[. != '']">
                <xsl:variable name="target" select="@target"/>
                <xsl:choose>
                    <!-- The ID to another Illurk charter has to be hashed as well! -->
                    <xsl:when test="contains($target, 'IlluminierteUrkunden')">
                        <ref>
                            <xsl:attribute name="target">
                                <xsl:value-of
                                    select="concat('o:cord.IU.', substring-before(substring-after($target, 'IlluminierteUrkunden/'), '/charter'))"
                                />
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </ref>
                    </xsl:when>
                    <xsl:otherwise>
                        <ref target="{$target}">
                            <xsl:apply-templates/>
                        </ref>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cei:region">
        <region>
            <xsl:apply-templates/>
        </region>
    </xsl:template>
    <xsl:template match="cei:repository">
        <repository>
            <xsl:apply-templates/>
        </repository>
    </xsl:template>
    <xsl:template match="cei:rolename">
        <roleName>
            <xsl:apply-templates/>
        </roleName>
    </xsl:template>
    <xsl:template match="cei:rubrum">
        <note type="ownership">
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    <xsl:template match="cei:scope">
        <biblScope>
            <xsl:apply-templates/>
        </biblScope>
    </xsl:template>
    <xsl:template match="cei:seal">
        <seal>
            <xsl:apply-templates/>
        </seal>
    </xsl:template>
    <xsl:template match="cei:sealDesc[. != '']">
        <xsl:apply-templates/>
    </xsl:template>
    <!--<xsl:template match="cei:setPhrase">
        <setPhrase><xsl:apply-templates/></setPhrase>
    </xsl:template>-->
    <xsl:template match="cei:settlement">
        <settlement>
            <xsl:apply-templates/>
        </settlement>
    </xsl:template>
    <xsl:template match="cei:sic">
        <sic>
            <xsl:apply-templates/>
        </sic>
    </xsl:template>
    <xsl:template match="cei:sigillant">
        <legalActor type="sigillant">
            <xsl:apply-templates/>
        </legalActor>
    </xsl:template>
    <xsl:template match="cei:space">
        <space>
            <xsl:apply-templates/>
        </space>
    </xsl:template>
    <xsl:template match="cei:sub">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    <xsl:template match="cei:sup">
        <hi rend="sup">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="cei:supplied">
        <supplied>
            <xsl:apply-templates/>
        </supplied>
    </xsl:template>
    <xsl:template match="cei:surname">
        <surname>
            <xsl:apply-templates/>
        </surname>
    </xsl:template>
    <xsl:template match="cei:tenor">
        <div type="tenor">
            <xsl:apply-templates select="cei:pTenor"/>
            <xsl:apply-templates select="cei:p"/>
            <xsl:call-template name="p_in_div"/>
        </div>
    </xsl:template>
    <xsl:template match="cei:testis">
        <legalActor type="witness">
            <xsl:apply-templates/>
        </legalActor>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:traditioForm">
        <copyStatus type="original">
            <xsl:apply-templates/>
        </copyStatus>
    </xsl:template>
    <xsl:template match="cei:witness/cei:traditioForm">
        <copyStatus>
            <xsl:apply-templates/>
        </copyStatus>
    </xsl:template>
    <xsl:template match="cei:unclear">
        <unclear>
            <xsl:apply-templates/>
        </unclear>
    </xsl:template>
    <!--  <xsl:template match="cei:user_name">
        <user_name><xsl:apply-templates/></user_name>
    </xsl:template>-->
    <xsl:template match="cei:width">
        <xsl:variable name="unit">
            <xsl:choose>
                <xsl:when test="contains(parent::cei:dimensions, 'mm')">
                    <xsl:text>mm</xsl:text>
                </xsl:when>
                <xsl:when test="contains(parent::cei:dimensions, 'cm')">
                    <xsl:text>cm</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <width>
            <xsl:if test="$unit[. != '']">
                <xsl:attribute name="unit" select="$unit"/>
            </xsl:if>
            <xsl:apply-templates/>
        </width>
    </xsl:template>
    <xsl:template match="cei:chDesc/cei:witListPar">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:witListPar">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:witness">
        <witness>
            <msDesc>
                <xsl:apply-templates select="cei:witness/cei:archIdentifier"/>
                <xsl:apply-templates select="cei:physicalDesc"/>
                <diploDesc>
                    <xsl:apply-templates select="cei:traditioForm"/>
                </diploDesc>
                <xsl:apply-templates select="cei:witness/cei:auth"/>
                <xsl:apply-templates select="cei:witness/cei:rubrum"/>
                <xsl:apply-templates select="cei:witness/cei:figure"/>
            </msDesc>
        </witness>
    </xsl:template>
    <xsl:template match="cei:witnessOrig">
        <!--<witness>
            <msDesc>
                <xsl:apply-templates/>
            </msDesc>
        </witness>-->
    </xsl:template>
    <xsl:template match="cei:zone">
        <zone>
            <xsl:apply-templates/>
        </zone>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template name="p_in_div">
        <p>
            <xsl:for-each select=".[not(cei:pTenor | cei:p)]">
                <xsl:apply-templates/>
            </xsl:for-each>
        </p>
    </xsl:template>
    <xsl:template name="keywords">
        <keywords>
            <xsl:choose>                
                <xsl:when test="@indexName = 'Illurk-Urkundenart'">
                    <xsl:variable name="urkart">
                        <xsl:choose>
                            <xsl:when test="starts-with(normalize-space(.), 'Bischofsammel')">
                                <xsl:text>bischofsammelindulgenz</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Schmäh')">
                                <xsl:text>schmaehbrief</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Notarsinstrument')">
                                <xsl:text>notarsinstrument</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Sammelindulgenz')">
                                <xsl:text>sammelindulgenz</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Prunksupplik')">
                                <xsl:text>prunksupplik</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Notariatsakt')">
                                <xsl:text>notariatsakt</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Wappenbrief')">
                                <xsl:text>wappenbrief</xsl:text>
                            </xsl:when>
                            <xsl:when test="starts-with(normalize-space(.), 'Kardinalsammel')">
                                <xsl:text>kardinalsammelindulgenz</xsl:text>
                            </xsl:when>                                 
                        </xsl:choose>
                    </xsl:variable>               
                        <xsl:if test="$urkart != ''">
                            <term>
                                <ref target="context:cord.{$urkart}" type="context"><xsl:value-of select="."/></ref>
                            </term>                            
                        </xsl:if>                
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="indexName">
                        <xsl:choose>
                            <xsl:when test="@indexName = 'IllUrkGlossar'">http://gams.uni-graz.at/skos/scheme/o:cord.2483</xsl:when>             
                            <xsl:when test="@indexName = 'illurk-vocabulary'">http://gams.uni-graz.at/skos/scheme/o:cord.2484</xsl:when>
                            <xsl:otherwise> </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:if test="$indexName != ''">
                        <xsl:attribute name="scheme">
                            <xsl:value-of select="$indexName"/>
                        </xsl:attribute>
                    </xsl:if>              
                    <xsl:for-each select="current-group()">
                        <term>
                            <xsl:if test="@lemma">
                                <xsl:attribute name="key">
                                    <xsl:value-of select="@lemma"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:call-template name="vocab_uri"/>
                        </term>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
            <!-- Nebensammlungen become contexts -->
            <xsl:if test="$nebensammlungen != ''">
                <xsl:for-each select="$nebensammlungen">
                    <xsl:variable name="nebensammlung" select="substring-after(sammlung, 'IlluminierteUrkunden')"></xsl:variable>
                    <term><ref target="context:cord.{$nebensammlung}" type="context"><xsl:value-of select="$nebensammlung"/></ref></term>
                </xsl:for-each>                
            </xsl:if>
        </keywords>
    </xsl:template>
    <xsl:template name="list_people">
        <person>
            <persName>
            <xsl:choose>
            <xsl:when test="@key">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                    <xsl:for-each select="@*">
                        <xsl:attribute name="{name()}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
                <xsl:apply-templates/>
            </persName>
        </person>
    </xsl:template>
    <xsl:template name="list_orgs">
        <org>
            <xsl:if test="@key">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
            </xsl:if>
            <orgName>
                <xsl:apply-templates/>
            </orgName>
        </org>
    </xsl:template>
   <!-- <xsl:template name="list_places">
            <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template name="vocab_uri">
        <xsl:variable name="indexName">
            <xsl:choose>
                <xsl:when test="@indexName = 'IllUrkGlossar'">2483</xsl:when>             
                <xsl:when test="@indexName = 'illurk-vocabulary'">2484</xsl:when>
                <xsl:otherwise> </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="lemma" select="@lemma"/>
        <xsl:choose>
            <xsl:when test="$lemma">
              <!--  <term>-->
                <xsl:attribute name="ref">
                    <xsl:value-of
                        select="concat('http://gams.uni-graz.at/skos/scheme/o:cord.', $indexName, '#', $lemma)"
                    />
                </xsl:attribute>
                <!--</term>-->
            </xsl:when>
            
        </xsl:choose>
       
        <xsl:apply-templates/>

  </xsl:template>
  
  <xsl:variable name="step-3">
    <xsl:apply-templates select="$step-2" mode="step-3"/>
  </xsl:variable>
  <xsl:template match="node() | @*" mode="step-3">    
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="step-3"/>
    </xsl:copy>    
  </xsl:template>
  
  <xsl:template match="*:TEI/*:text/*:body[empty(node())]" mode="step-3">      
    <body>
      <div type="tenor">
      <p/>
    </div> 
    </body>
  </xsl:template>
  
  <xsl:template match="/" priority="-2">
    <xsl:variable name="idno" select="replace(substring-after(//atom:id, 'charter/'),'/', '-')"/>   
    <xsl:result-document href="happy-tei/{$idno}.xml">     
   <xsl:copy-of select="$step-3"></xsl:copy-of>
    </xsl:result-document>
  </xsl:template>
  

</xsl:stylesheet>
