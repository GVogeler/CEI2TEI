<?xml version="1.0" encoding="UTF-8"?>
<!-- BIG FIX NEEDED IN ORDER TO PULL IN versionOf DATA AND CREATE LINKED DOCUMENTS -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:cei="http://www.monasterium.net/NS/cei"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <xsl:processing-instruction name="xml-model">href="file:/Z:/Documents/CEI_TEIP5/tei_cei/out/tei_cei.rnc" type="application/relax-ng-compact-syntax"</xsl:processing-instruction>
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
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
                        </publisher>
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
                        <p>The <ref target="https://illuminierte-urkunden.uni-graz.at">Illuminierte
                                Urkunden</ref> project is a cross-disciplinary historical,
                            art-historical, and digital humanities project which collects illuminated
                            medieval charters from all over Europe, publishes them, and explores
                            them in detailed studies.</p>
                    </projectDesc>
                </encodingDesc>
                <profileDesc>
                    <abstract>
                        <xsl:apply-templates select="//cei:abstract"/>
                    </abstract>
                    <xsl:apply-templates select="//cei:lang_MOM"/>
                    <textClass>
                        <!-- have to define a rule for keywords, which don#t have @ as well-->
                        <xsl:for-each-group select="//cei:index[. != '']" group-by="@indexName">
                            <xsl:call-template name="keywords"/>
                        </xsl:for-each-group>
                    </textClass>
                    <xsl:if
                        test="//cei:back//cei:persName[. != ''] | //cei:back//cei:orgName[. != '']">
                        <particDesc>
                            <xsl:if test="//cei:back//cei:persName[. != '']">
                                <listPerson>
                                    <xsl:for-each select="//back//cei:persName">
                                        <xsl:sort order="ascending" select="."/>
                                        <xsl:choose>
                                            <xsl:when test="@key">
                                                <xsl:for-each-group select="." group-by="@key">
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
                                        <xsl:call-template name="list_orgs"/>
                                    </xsl:for-each>
                                </listOrg>
                            </xsl:if>
                        </particDesc>
                    </xsl:if>
                    <xsl:if test="//cei:back//cei:placeName[. != '']">
                        <settingDesc>
                            <listPlace>
                                <xsl:for-each select="//cei:back//cei:placeName[. != '']">
                                    <xsl:call-template name="list_places"/>
                                </xsl:for-each>
                            </listPlace>
                        </settingDesc>
                    </xsl:if>
                </profileDesc>
                <revisionDesc>
                    <xsl:if test="//atom:updated">
                        <list>
                            <xsl:for-each select="//atom:updated">
                                <xsl:variable name="date" select="substring-before(., 'T')"/>
                                <item>
                                    <date when="{$date}"><xsl:value-of select="."/></date> Last
                                    checked by CAC</item>
                            </xsl:for-each>
                        </list>
                    </xsl:if>
                </revisionDesc>
            </teiHeader>
            <xsl:if test="//cei:graphic[@url != '']">
                <facsimile>
                    <xsl:apply-templates select="//cei:graphic" mode="image"/>
                </facsimile>
            </xsl:if>
            <text>
                <body>
                    <xsl:apply-templates select="//cei:body"/>
                </body>
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
            <p>
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
            </p>
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
    <xsl:template match="cei:back/cei:persName">
        <person>
            <xsl:apply-templates/>
        </person>
    </xsl:template>
    <xsl:template match="cei:back/cei:placeName">
        <place>
            <xsl:apply-templates/>
        </place>
    </xsl:template>
    <xsl:template match="cei:back/cei:orgName">
        <org>
            <xsl:apply-templates/>
        </org>
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
        <dimensions>
            <xsl:apply-templates/>
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
        <xsl:apply-templates select="cei:altIdentifier"/>
    </xsl:template>
    <xsl:template match="cei:witness/cei:archIdentifier">
        <xsl:apply-templates select="cei:country"/>
        <xsl:apply-templates select="cei:region"/>
        <xsl:apply-templates select="cei:settlement"/>
        <xsl:apply-templates select="cei:arch | cei:repository"/>
        <xsl:apply-templates select="cei:archFond"/>
        <xsl:apply-templates select="cei:archIdentifier/cei:idno"/>
        <xsl:apply-templates select="cei:altIdentifier"/>
    </xsl:template>
    <xsl:template match="cei:body/cei:idno"> 
        <!-- NO CONTENT -->
    </xsl:template>
    <xsl:template match="cei:archIdentifier/cei:idno | cei:altIdentifier/cei:idno">
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
        <term>
            <xsl:call-template name="vocab_uri"/>
        </term>
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
    <xsl:template match="cei:witness/cei:nota | cei:witnessOrig/cei:nota">
        <additions>
            <xsl:apply-templates/>
        </additions>
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
                <ref target="{$target}">
                    <xsl:apply-templates/>
                </ref>
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
    <xsl:template name="keywords">
        <keywords>
            <!--<xsl:if test="@indexName">-->
            <xsl:attribute name="scheme">
                <xsl:value-of select="@indexName"/>
            </xsl:attribute>
            <!--</xsl:if>-->
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
        </keywords>
    </xsl:template>
    <xsl:template name="list_people">
        <person>
            <xsl:if test="@key">
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="@key"/>
                </xsl:attribute>
            </xsl:if>
            <persName>
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
    <xsl:template name="list_places">
        <place>
            <placeName>
                <xsl:choose>
                    <xsl:when test="@type">
                        <region>
                            <xsl:value-of select="."/>
                        </region>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </placeName>
        </place>
    </xsl:template>
    <xsl:template name="vocab_uri">
        <xsl:variable name="indexName">
            <xsl:choose>
                <xsl:when test="@indexName = 'IllUrkGlossar'">2379</xsl:when>
                <xsl:when test="@indexName = 'Illurk-Urkundenart'">2386</xsl:when>
                <xsl:when test="@indexName = 'illurk-vocabulary'">2383</xsl:when>
                <xsl:otherwise> </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="lemma" select="@lemma"/>
        <xsl:attribute name="ref">
            <xsl:value-of
                select="concat('http://gams.uni-graz.at/skos/scheme/o:epis.', $indexName, '#', $lemma)"
            />
        </xsl:attribute>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
