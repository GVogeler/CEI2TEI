<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:atom="http://www.w3.org/2005/Atom"
    xmlns:cei="http://www.monasterium.net/NS/cei"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" >
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title>Title</title>
                    <editor><xsl:value-of select="//atom:email"/></editor>
                </titleStmt>
                <publicationStmt>
                    <p>Publication Information</p>
                    <idno><xsl:value-of select="//atom:id"/></idno>
                    <date><xsl:value-of select="//atom:published"/></date>
                </publicationStmt>
                <sourceDesc>
                    <xsl:for-each select="//cei:sourcDesc | //cei:sourceDescRegest | //cei:sourceDescVolltext" >
                        <p><xsl:value-of select="cei:bibl"/></p>
                    </xsl:for-each>
                    
                </sourceDesc>
            </fileDesc>
            <encodingDesc>
                <projectDesc>
                    <p>Something about Monasterium/IllUrk here.</p>
                </projectDesc>
                <editorialDecl>
                    <correction>
                        <p>Turned letters are silently corrected.</p>
                    </correction>
                    <normalization>
                        <p>Original spelling and typography is retained, except that long s and ligatured
                            forms are not encoded.</p>
                    </normalization>
                </editorialDecl>
            </encodingDesc>
            <revisionDesc>
                <list>
                    <xsl:for-each select="//atom:updated">
                        <xsl:variable name="date" select="substring-before(., 'T')" />                  
                        
                        <item>
                            <date when="{$date}"><xsl:value-of select="."/></date> Last checked by CAC</item>                         
                    </xsl:for-each>                                      
                </list>
            </revisionDesc> 
        </teiHeader>
           
        <text>
            <body>
                <xsl:apply-templates/>                
            </body>
        </text>
    </TEI>
    </xsl:template>  
    <xsl:template match="cei:abstract">
        <div type="abstract"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="cei:add">
        <add><xsl:apply-templates/></add>
    </xsl:template>
    <xsl:template match="cei:altIdentifier">
        <altIdentifier><xsl:apply-templates/></altIdentifier>
    </xsl:template>
    <xsl:template match="cei:app">
        <app><xsl:apply-templates/></app>
    </xsl:template>
    <xsl:template match="cei:arch">
        <repository><xsl:apply-templates/></repository>
    </xsl:template>
    <xsl:template match="cei:archFond">
        <collection><xsl:apply-templates/></collection>
    </xsl:template>
    <xsl:template match="cei:archIdenfier">
        <msIdentifier><xsl:apply-templates/></msIdentifier>
    </xsl:template>
    <xsl:template match="cei:arenga">
        <diploPart type="arenga"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:auth">
        <authen><xsl:apply-templates/></authen>
    </xsl:template>
    <xsl:template match="cei:author">
        <author><xsl:apply-templates/></author>
    </xsl:template>
    <xsl:template match="cei:availability">
        <availability><xsl:apply-templates/></availability>
    </xsl:template>
    <xsl:template match="cei:back">
        <back><xsl:apply-templates/></back>
    </xsl:template>
    <xsl:template match="cei:bibl">
        <bibl><xsl:apply-templates/></bibl>
    </xsl:template>
    <xsl:template match="cei:c">
        <g><xsl:apply-templates/></g>
    </xsl:template>
    <xsl:template match="cei:chDesc">
        <msDesc><xsl:apply-templates/></msDesc>
    </xsl:template>
    <xsl:template match="cei:cit">
        <cit><xsl:apply-templates/></cit>
    </xsl:template>
    <xsl:template match="cei:condition">
        <condition><xsl:apply-templates/></condition>
    </xsl:template>
    <xsl:template match="cei:corr">
        <corr><xsl:apply-templates/></corr>
    </xsl:template>
    <xsl:template match="cei:corrobatio">
        <diploPart type="corrobation"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:datatio">
        <diploPart type="datatio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:dispositio">
        <diploPart type="dispositio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:inscriptio">
        <diploPart type="inscriptio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:intitulatio">
        <diploPart type="intitulatio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:invocatio">
        <diploPart type="invocatio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:narratio">
        <diploPart type="narratio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:publicatio">
        <diploPart type="publicatio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:sanctio">
        <diploPart type="sanctio"><xsl:apply-templates/></diploPart>
    </xsl:template>
    <xsl:template match="cei:country">
        <country><xsl:apply-templates/></country>
    </xsl:template>
    <xsl:template match="cei:damage">
        <damage><xsl:apply-templates/></damage>
    </xsl:template>
    <xsl:template match="cei:date">
        <date><xsl:apply-templates/></date>
    </xsl:template>
    <xsl:template match="cei:dateRange">
        <xsl:variable name="from" select="@from"/>
        <xsl:variable name="to" select="@to"/>
        <dateRange from="{$from}" to="{$to}"><xsl:apply-templates/></dateRange>
    </xsl:template>
    <xsl:template match="cei:decoDesc">
        <dedcoDesc><xsl:apply-templates/></dedcoDesc>
    </xsl:template>
    <xsl:template match="cei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="cei:desc">
        <desc><xsl:apply-templates/></desc>
    </xsl:template>
    <xsl:template match="cei:dimensions">
        <dimensions><xsl:apply-templates/></dimensions>
    </xsl:template>
    <xsl:template match="cei:diplomaticAnalysis">
        <diploDesc><xsl:apply-templates/></diploDesc>
    </xsl:template>    
    <xsl:template match="cei:div | cei:divNotes">
        <div><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="cei:expan">
        <expan><xsl:apply-templates/></expan>
    </xsl:template>
    <xsl:template match="cei:figDesc">
        <figDesc><xsl:apply-templates/></figDesc>
    </xsl:template>
   <!-- <xsl:template match="cei:figure">
        <figure><xsl:apply-templates/></figure>
    </xsl:template>-->
    <xsl:template match="cei:foreign">
        <foreign><xsl:apply-templates/></foreign>
    </xsl:template>
    <xsl:template match="cei:forename">
        <forename><xsl:apply-templates/></forename>
    </xsl:template>
    <xsl:template match="cei:front">
        <front><xsl:apply-templates/></front>
    </xsl:template>
    <xsl:template match="cei:geogName">
        <geogName><xsl:apply-templates/></geogName>
    </xsl:template>
    <xsl:template match="cei:graphic">
        <graphic><xsl:apply-templates/></graphic>
    </xsl:template>
    <xsl:template match="cei:group">
        <group><xsl:apply-templates/></group>
    </xsl:template>
    <xsl:template match="cei:handShift">
        <handShift><xsl:apply-templates/></handShift>
    </xsl:template>
    <xsl:template match="cei:height">
        <height><xsl:apply-templates/></height>
    </xsl:template>
    <xsl:template match="cei:hi">
        <hi><xsl:apply-templates/></hi>
    </xsl:template>
    <xsl:template match="cei:idno">
        <idno><xsl:apply-templates/></idno>
    </xsl:template>
 <!--   <xsl:template match="cei:image_server_address">
        <image_server_address><xsl:apply-templates/></image_server_address>
    </xsl:template>
    <xsl:template match="cei:image_server_folder">
        <image_server_folder><xsl:apply-templates/></image_server_folder>
    </xsl:template>-->
    <xsl:template match="cei:imprint">
        <imprint><xsl:apply-templates/></imprint>
    </xsl:template>
    <xsl:template match="cei:index">        
        <index><xsl:if test="@indexName"><xsl:attribute name="indexName"><xsl:value-of select="@indexName"/></xsl:attribute></xsl:if>
            <xsl:if test="@lemma"><xs:attribute name="lemma"><xsl:value-of select="@lemma"/></xs:attribute></xsl:if>            
            <xsl:apply-templates/></index>
    </xsl:template>
    <xsl:template match="cei:issued">
        <issued><xsl:apply-templates/></issued>
    </xsl:template>
    <xsl:template match="cei:issuer">
        <legalActor type="issuer"><xsl:apply-templates/></legalActor>
    </xsl:template>
    <xsl:template match="cei:lang_MOM">
        <language><xsl:apply-templates/></language>
    </xsl:template>
    <xsl:template match="cei:lb">
        <lb><xsl:apply-templates/></lb>
    </xsl:template>
    <xsl:template match="cei:legend">
        <legend><xsl:apply-templates/></legend>
    </xsl:template>
    <!--<xsl:template match="cei:lem">
        <lem><xsl:apply-templates/></lem>
    </xsl:template>-->
    <xsl:template match="cei:listBibl">
        <listBibl><xsl:apply-templates/></listBibl>
    </xsl:template>
    <xsl:template match="cei:listBiblEdition">
        <listBiblEdition type="other"><xsl:apply-templates/></listBiblEdition>
    </xsl:template>
    <xsl:template match="cei:listBiblErw">
        <listBiblErw type="unknown"><xsl:apply-templates/></listBiblErw>
    </xsl:template>
    <xsl:template match="cei:listBiblFacsimile">
        <listBiblFacsimile type="facsimile"><xsl:apply-templates/></listBiblFacsimile>
    </xsl:template>
    <xsl:template match="cei:listBiblRegest">
        <listBiblRegest type="regest"><xsl:apply-templates/></listBiblRegest>
    </xsl:template>
    <xsl:template match="cei:material">
        <material><xsl:apply-templates/></material>
    </xsl:template>
    <xsl:template match="cei:measure">
        <measure><xsl:apply-templates/></measure>
    </xsl:template>
    <xsl:template match="cei:nota | cei:note">
        <note><xsl:apply-templates/></note>
    </xsl:template>
   <!-- <xsl:template match="cei:notariusDesc">
        <authen><xsl:apply-templates/></authen>
    </xsl:template>
    <xsl:template match="cei:notariusSign">
        <authen><xsl:apply-templates/></authen>
    </xsl:template>-->
    <xsl:template match="cei:notariusDesc">
        <authen type="signed"><legalActor type="notary"><xsl:apply-templates/></legalActor></authen>
    </xsl:template>
    <xsl:template match="cei:num">
        <num><xsl:apply-templates/></num>
    </xsl:template>
    <xsl:template match="cei:orgName">
        <orgName><xsl:apply-templates/></orgName>
    </xsl:template>
    <xsl:template match="cei:p | cei:pTenor">
        <p><xsl:apply-templates/></p>
    </xsl:template>
  <!--  <xsl:template match="cei:password">
        <password><xsl:apply-templates/></password>
    </xsl:template>-->
    <xsl:template match="cei:pb">
        <pb><xsl:apply-templates/></pb>
    </xsl:template>
    <xsl:template match="cei:persName">
        <persName><xsl:apply-templates/></persName>
    </xsl:template>
    <xsl:template match="cei:physicalDesc">
        <physicalDesc><xsl:apply-templates/></physicalDesc>
    </xsl:template>
<!--    <xsl:template match="cei:pict">
        <pict><xsl:apply-templates/></pict>
    </xsl:template>-->
    <xsl:template match="cei:placeName">
        <placeName><xsl:apply-templates/></placeName>
    </xsl:template>
    <xsl:template match="cei:provenance">
        <provenance><xsl:apply-templates/></provenance>
    </xsl:template>
    <xsl:template match="cei:pubPlace">
        <pubPlace><xsl:apply-templates/></pubPlace>
    </xsl:template>
    <xsl:template match="cei:quote">
        <quote><xsl:apply-templates/></quote>
    </xsl:template>
  <!--  <xsl:template match="cei:quoteOriginaldatierung">
        <><xsl:apply-templates/></>
    </xsl:template>-->
    <xsl:template match="cei:rdg">
        <rdg><xsl:apply-templates/></rdg>
    </xsl:template>
    <xsl:template match="cei:recipient">
        <legalActor type="recipient"><xsl:apply-templates/></legalActor>
    </xsl:template>
    <xsl:template match="cei:ref">
        <xsl:variable name="target" select="@target"/>
        <ref target="{$target}"><xsl:apply-templates/></ref>
    </xsl:template>
    <xsl:template match="cei:region">
        <rgion><xsl:apply-templates/></rgion>
    </xsl:template>
    <xsl:template match="cei:repository">
        <repository><xsl:apply-templates/></repository>
    </xsl:template>
    <xsl:template match="cei:rolename">
        <roleName><xsl:apply-templates/></roleName>
    </xsl:template>
    <xsl:template match="cei:rubrum">
        <note type="ownership"><xsl:apply-templates/></note>
    </xsl:template>
    <xsl:template match="cei:scope">
        <biblScope><xsl:apply-templates/></biblScope>
    </xsl:template>
    <xsl:template match="cei:seal">
        <seal><xsl:apply-templates/></seal>
    </xsl:template>
    <xsl:template match="cei:sealDesc">
        <authDesc><xsl:apply-templates/></authDesc>
    </xsl:template>
    <!--<xsl:template match="cei:setPhrase">
        <setPhrase><xsl:apply-templates/></setPhrase>
    </xsl:template>-->
    <xsl:template match="cei:settlement">
        <settlement><xsl:apply-templates/></settlement>
    </xsl:template>
    <xsl:template match="cei:sic">
        <sic><xsl:apply-templates/></sic>
    </xsl:template>
    <xsl:template match="cei:sigillant">
        <legalActor type="sigillant"><xsl:apply-templates/></legalActor>
    </xsl:template>
    <xsl:template match="cei:space">
        <space><xsl:apply-templates/></space>
    </xsl:template>
    <xsl:template match="cei:sub">
        <sub><xsl:apply-templates/></sub>
    </xsl:template>
    <xsl:template match="cei:supplied">
        <supplied><xsl:apply-templates/></supplied>
    </xsl:template>
    <xsl:template match="cei:surname">
        <surname><xsl:apply-templates/></surname>
    </xsl:template>
    <xsl:template match="cei:tenor">
        <div type="tenor"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="cei:testis">
        <legalActor type="witness"><xsl:apply-templates/></legalActor>
    </xsl:template>
    <xsl:template match="cei:traditioForm">
        <copyStatus><xsl:apply-templates/></copyStatus>
    </xsl:template>
    <xsl:template match="cei:unclear">
        <unclear><xsl:apply-templates/></unclear>
    </xsl:template>
  <!--  <xsl:template match="cei:user_name">
        <user_name><xsl:apply-templates/></user_name>
    </xsl:template>-->
    <xsl:template match="cei:width">
        <width><xsl:apply-templates/></width>
    </xsl:template>
    <xsl:template match="cei:witListPar">
        <witListPar><xsl:apply-templates/></witListPar>
    </xsl:template>
    <xsl:template match="cei:witness">
        <witness><xsl:apply-templates/></witness>
    </xsl:template>
    <!--<xsl:template match="cei:witnessOrig">
        <witnessOrig><xsl:apply-templates/></witnessOrig>
    </xsl:template>-->
    <xsl:template match="cei:zone">
        <zone><xsl:apply-templates/></zone>
    </xsl:template>
 <xsl:template match="text()">
     <xsl:value-of select="."/>
 </xsl:template>

   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</xsl:stylesheet>