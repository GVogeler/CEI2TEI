<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:cei="http://www.monasterium.net/NS/cei"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">href="../out/tei_cei.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
                        <editor>
                            <xsl:value-of select="//atom:email"/>
                        </editor>
                        <respStmt>
                            <resp>Principal Investigator</resp>
                            <persName>
                                <forename>Georg</forename>abstr <surname>Vogeler</surname>
                            </persName>
                        </respStmt>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>
                            <orgName ref="http://d-nb.info/gnd/1137284463"
                                corresp="https://informationsmodellierung.uni-graz.at">Zentrum für
                                Informationsmodellierung - Austrian Centre for Digital Humanities,
                                Karl-Franzens-Universität Graz</orgName>
                        </publisher>
                        <authority>
                            <orgName>FWF Projekt P 26706-G21 "Illuminierte Urkunden"</orgName>
                        </authority>
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
                        <pubPlace>Graz</pubPlace>
                        <date>
                            <xsl:value-of select="//atom:published"/>
                        </date>
                    </publicationStmt>
                    <sourceDesc>
                        <xsl:for-each
                            select="//cei:sourceDesc | cei:sourceDescRegest | cei:sourceDescVolltext | cei:sourceDescErw">
                            <xsl:apply-templates select="cei:bibl"/>
                        </xsl:for-each>
<!--                        <idno type="Monasterium" xml:id="monasterium">
                            <xsl:value-of select="//atom:id"/>
                        </idno>-->
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
                        <p>Something about IllUrk here.</p>
                    </projectDesc>
                    <editorialDecl>
                        <correction>
                            <p> </p>
                        </correction>
                        <normalization>
                            <p> </p>
                        </normalization>
                    </editorialDecl>
                </encodingDesc>
                <profileDesc>
                    <xsl:apply-templates select="//cei:lang_MOM"/>
                </profileDesc>
                <revisionDesc>
                    <list>
                        <xsl:for-each select="//atom:updated">
                            <xsl:variable name="date" select="substring-before(., 'T')"/>
                            <item>
                                <date when="{$date}"><xsl:value-of select="."/></date> Last checked
                                by CAC</item>
                        </xsl:for-each>
                    </list>
                </revisionDesc>
            </teiHeader>
            <text>
                <xsl:apply-templates select="//cei:front"/>
                <body>
                    <xsl:apply-templates select="//cei:body"/>
                </body>
                <xsl:apply-templates select="//cei:back"/>
            </text>
        </TEI>
    </xsl:template>
    <xsl:template name="original_witness">
        <witness>
            <msDesc>
                <msIdentifier>
                    <xsl:apply-templates select="//cei:witnessOrig/cei:archIdentifier"/>
                    <altIdentifier resp="https://illuminierte-urkunden.uni-graz.at/">
                        <idno>
                            <xsl:value-of select="//cei:body/cei:idno"/>
                        </idno>
                    </altIdentifier>
                </msIdentifier>
                <msContents> <!-- change to profileDesc/abstract (need to change content model of abstract to accomodate all of the tags used in regest) -->
                            <xsl:apply-templates select="//cei:abstract"/>
                </msContents>
                <xsl:apply-templates select="//cei:witnessOrig/cei:physicalDesc"/>
                <diploDesc>
                    <xsl:apply-templates select="//cei:witnessOrig/cei:traditioForm"/>
                    <xsl:apply-templates select="//cei:diplomaticAnalysis"/>
                    <issued>
                        <xsl:value-of select="//cei:body/cei:chDesc/cei:issued"/>
                    </issued>
                </diploDesc>
                <xsl:apply-templates select="//cei:witnessOrig/cei:auth"/>
                <!-- There are  cei:figure tags in witnessOrig that need to be moved to facsimile (no anchors neeeded?) -->
            </msDesc>
        </witness>
    </xsl:template>
    <xsl:template match="cei:front">
        <front>
            <div>
                <xsl:apply-templates select="cei:p"/>
                <xsl:call-template name="p_in_div"/>
            </div>
        </front>
    </xsl:template>
    <xsl:template match="cei:abstract">
        <summary>
            <p>
                <xsl:apply-templates/>
            </p>
        </summary></xsl:template>
    <xsl:template match="cei:add">
        <add>
            <xsl:apply-templates/>
        </add>
    </xsl:template>
    <xsl:template match="cei:altIdentifier">
        <altIdentifier>
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
    <xsl:template match="cei:witness/cei:auth">
        <authDesc>
            <xsl:apply-templates/>
        </authDesc>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:auth">
        <authDesc>
            <xsl:apply-templates/>
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
    <xsl:template match="cei:back">
        <back>
            <div>
                <xsl:apply-templates select="cei:p"/>
                <xsl:call-template name="p_in_div"/>
            </div>
        </back>
    </xsl:template>
    <xsl:template match="cei:bibl">
        <bibl>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
    <xsl:template match="cei:body">
        <xsl:apply-templates/>
    </xsl:template>
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
    <xsl:template match="cei:decoDesc">
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
        <dimensions>
            <xsl:apply-templates/>
        </dimensions>
    </xsl:template>
    <xsl:template match="cei:diplomaticAnalysis">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cei:div | cei:divNotes">
        <div>
            <xsl:apply-templates select="cei:p"/>
            <xsl:call-template name="p_in_div"/>
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
    <xsl:template match="cei:graphic">
        <graphic>
            <xsl:apply-templates/>
        </graphic>
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
        <height>
            <xsl:apply-templates/>
        </height>
    </xsl:template>
    <xsl:template match="cei:hi">
        <hi>
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    <xsl:template match="cei:witnessOrig/cei:archIdentifier">
        <xsl:apply-templates select="cei:country"/>
        <xsl:apply-templates select="cei:region"/>
        <xsl:apply-templates select="cei:settlement"/>
        <xsl:apply-templates select="cei:arch | cei:repository"/>
        <xsl:apply-templates select="cei:archFond"/>
        <xsl:apply-templates select="cei:archIdentifier/cei:idno"/>
    </xsl:template>
    <xsl:template match="cei:witness/cei:archIdentifier">
        <xsl:apply-templates select="cei:country"/>
        <xsl:apply-templates select="cei:region"/>
        <xsl:apply-templates select="cei:settlement"/>
        <xsl:apply-templates select="cei:arch | cei:repository"/>
        <xsl:apply-templates select="cei:archFond"/>
        <xsl:apply-templates select="cei:archIdentifier/cei:idno"/>
    </xsl:template>
    <xsl:template match="cei:body/cei:idno"> </xsl:template>
    <xsl:template match="cei:archIdentifier/cei:idno">
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
    <xsl:template match="cei:index">
        <index>
            <xsl:if test="@indexName">
                <xsl:attribute name="indexName">
                    <xsl:value-of select="@indexName"/>
                </xsl:attribute>
            </xsl:if>
            <term>
                <xsl:if test="@lemma">
                    <xsl:attribute name="key">
                        <xsl:value-of select="@lemma"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates/>
            </term>
        </index>
    </xsl:template>
    <xsl:template match="//cei:body/cei:chDesc/cei:issued"> </xsl:template>
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
                        <language ident="{$token}"/>
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
    <xsl:template match="cei:witness/cei:nota | cei:witnessOrig/cei:nota">
        <additions>
            <xsl:apply-templates/>
        </additions>
    </xsl:template>
    <xsl:template match="cei:note">
        <note>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    <!-- <xsl:template match="cei:notariusDesc">
        <authen><xsl:apply-templates/></authen>
    </xsl:template>
    <xsl:template match="cei:notariusSign">
        <authen><xsl:apply-templates/></authen>
    </xsl:template>-->
    <xsl:template match="cei:notariusDesc">
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
    <xsl:template match="cei:p | cei:pTenor">
        <p>
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
            <xsl:apply-templates select="cei:witness/cei:nota"/>
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
            <xsl:apply-templates select="cei:witnessOrig/cei:nota"/>
        </physDesc>
    </xsl:template>
    <!--    <xsl:template match="cei:pict">
        <pict><xsl:apply-templates/></pict>
    </xsl:template>-->
    <xsl:template match="cei:placeName">
        <placeName>
            <xsl:apply-templates/>
        </placeName>
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
            <xsl:apply-templates/>
        </quote>
    </xsl:template>
    <!--  <xsl:template match="cei:quoteOriginaldatierung">
        <><xsl:apply-templates/></>
    </xsl:template>-->
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
        <xsl:variable name="target" select="@target"/>
        <ref target="{$target}">
            <xsl:apply-templates/>
        </ref>
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
    </xsl:template><!--
    <xsl:template match="cei:sealDesc">
        <seal>
            <xsl:apply-templates/>
        </seal>-->
    <!--</xsl:template>-->
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
        <width>
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
                <msIdentifier>
                    <xsl:apply-templates select="cei:witness/cei:archIdentifier"/>
                </msIdentifier>
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
    <!-- add back in when applying to actual files
    <xsl:template
        match="
            *[not(node())]
            |
            *[not(node()[2])
            and
            node()/self::text()
            and
            not(normalize-space())
            and
            not(@*)
            ]
            "/>
 -->
    <xsl:template name="p_in_div">
        <p>
            <xsl:for-each select="*[not(cei:pTenor | cei:p)]">
                <xsl:apply-templates/>
            </xsl:for-each>
        </p>
    </xsl:template>
</xsl:stylesheet>
