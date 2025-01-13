<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" />

    <!-- Template di base: struttura della pagina HTML -->
    <xsl:template match="/">
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link rel="stylesheet" type="text/css" href="style.css" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script type="text/javascript" src="articoli.js"></script>
                <title>Progetto Codifica di Testi</title>
            </head>

            <body>
                
                <!-- Header -->
                <div class="header">
                    <a href="https://rassegnasettimanale.animi.it/"><img src="img/logo_rassegna_new.jpg" alt="logoLARASSET" href="https://rassegnasettimanale.animi.it/"/></a>
                    <span id="#sponsor">
                        <a href="https://www.unipi.it/"><img src="https://upload.wikimedia.org/wikipedia/it/e/e2/Stemma_unipi.svg" alt="logoUNIPI"/></a>
                        <h5>
                            <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:sponsor"/>
                        </h5>
                    </span>
                </div>

                <!-- Titolo -->
                <div class="heading">
                    <h2>
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                    </h2>
                    <h3>
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp"/> <xsl:text>&#160;</xsl:text>
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[1]"/> e
                        <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[2]"/>
                    </h3>
                </div>

                <!-- Descrizione bibliografica -->
                <div id="desc_bibl">
                    <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:fileDesc"/>
                </div>

                <!-- Legenda codifica -->
                <div id="legenda_cont">
                    <h2>Legenda</h2>
                    <div id="legenda">
                        <div class="btn_categorie">
                            <button class="categ" id="person">Persone</button>
                            <button class="categ" id="character">Personaggi</button>
                            <button class="categ" id="bibl">Opere</button>
                            <button class="categ" id="place">Luoghi</button>
                            <button class="categ" id="event">Eventi</button>
                            <button class="categ" id="org">Organizzazioni</button>
                            <button class="categ" id="date">Date</button>
                            <button class="categ" id="verbum">Verbum</button>
                            <button class="categ" id="foreign">Lingua straniera o dialetto</button>
                            <button class="categ" id="cit">Citazioni</button>
                            <button class="categ" id="num">Numeri</button>
                        </div>
                        <div class="btn_interventi">
                            <button class="int" id="expan">Espansioni</button>
                            <button class="int" id="reg">Regolarizzazioni</button>
                            <button class="int" id="ex">Aggiunte</button>
                            <button class="int" id="corr">Correzioni</button>
                        </div>
                        <button id="clean" title="Ripulisci tutto"><img width="20" height="20" src="https://img.icons8.com/ios-glyphs/30/broom.png" alt="Ripulisci tutto"/></button>
                    </div>
                </div>

                <!-- Testo e facsimili -->
                <div class="testo_cont">
                    <div class="porzione_cont">
                        <xsl:for-each select="tei:TEI/tei:text/tei:body/tei:div[@type='journal']/tei:div">
                            <div class="porzione">
                                <h2> <xsl:value-of select="tei:head"/> </h2>
                                <xsl:for-each select="tei:pb">
                                    <xsl:variable name="id_pag">
                                        <xsl:value-of select="@xml:id"/>
                                    </xsl:variable>
                                    <div class="pagina">
                                        <div class="facsimile">
                                            <xsl:apply-templates select="." />
                                        </div>
                                        <table class="colonne">
                                            <tbody>
                                                <tr>
                                                    <th>Colonna 1</th>
                                                    <th>Colonna 2</th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div class="col_sx">
                                                            <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#', $id_pag) and @n=1]" />
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="col_dx">
                                                            <xsl:apply-templates select="following-sibling::tei:cb[@corresp=concat('#', $id_pag) and @n=2]" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>

                <!-- Footer -->
                <footer>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[1]"/>,
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[2]"/> <br/>
                    CdL Informatica Umanistica, a.a. 2023/24 <br/>
                    <a href="https://github.com/matildecmp/CdT_2024">Repository GitHub</a> del progetto
                </footer>

            </body>
        </html>
    </xsl:template>

    <!-- Templates di nodi specifici -->

    <!-- fileDesc -->
    <xsl:template match="tei:fileDesc">
        <h2>Descrizione bibliografica</h2>
        <table>
            <tr>
                <td> <h3>Pubblicazione</h3> </td>
                <td> <xsl:apply-templates select="tei:publicationStmt"/> </td>
            </tr>
            <tr>
                <td> <h3>Serie</h3> </td>
                <td> <xsl:apply-templates select="tei:seriesStmt"/> </td>
            </tr>
            <tr>
                <td> <h3>Fonte</h3> </td>
                <td> <xsl:apply-templates select="tei:sourceDesc"/> </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:publicationStmt">
        <table>
            <tr>
                <td>
                    <strong>Editore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:publisher"/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Luogo e data</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:pubPlace"/>, <xsl:value-of select="tei:date"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:seriesStmt">
        <table>
            <tr>
                <td>
                    <strong>Serie</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:title"/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Coordinatore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:respStmt/tei:name"/>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
        <table>
            <tr>
                <td>
                    <strong>Titolo</strong>
                </td>
                <td>
                    <em><xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:title"/></em>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>
                        <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:respStmt/tei:resp"/>
                    </strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:respStmt/tei:name[1]"/>,
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:respStmt/tei:name[2]"/>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Editore</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:imprint/tei:publisher" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Lingua</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:textLang" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Luogo e data</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:imprint/tei:pubPlace" />,
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:imprint/tei:date" />
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Sezioni codificate</strong>
                </td>
                <td>
                    <xsl:for-each select="tei:biblStruct/tei:analytic">
                        <xsl:choose>
                            <xsl:when test="position() &lt;= 3">
                                <em><xsl:value-of select="tei:title"/></em> <br/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="tei:title"/> <br/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Volume</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:biblScope[1]"/> 
                    <xsl:for-each select="tei:biblStruct/tei:monogr[position() &gt; last() - 2]"> 
                        <xsl:variable name="volume" select="tei:biblScope[@unit='volume']"/> 
                        <xsl:if test="$volume">
                            | <xsl:value-of select="$volume"/> 
                        </xsl:if>
                    </xsl:for-each> 
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Fascicolo</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:biblScope[2]"/>
                    <xsl:for-each select="tei:biblStruct/tei:monogr[position() &gt; last() - 2]">
                        <xsl:variable name="issue" select="tei:biblScope[@unit='issue']"/>
                        <xsl:if test="$issue">
                            | <xsl:value-of select="$issue"/>
                        </xsl:if>
                    </xsl:for-each>
                </td>
            </tr>
            <tr>
                <td>
                    <strong>Pagine</strong>
                </td>
                <td>
                    <xsl:value-of select="tei:biblStruct/tei:monogr[1]/tei:biblScope[3]" />
                    <xsl:for-each select="tei:biblStruct/tei:monogr[position() &gt; last() - 2]"> 
                        <xsl:variable name="page" select="tei:biblScope[@unit='page']"/>
                        <xsl:if test="$page">
                            | <xsl:value-of select="$page"/>
                        </xsl:if>
                    </xsl:for-each>
                    <br/>
                </td>
            </tr>
        </table>
    </xsl:template>

   
    
    <!-- pb -->
    <xsl:template match="tei:pb">
        <xsl:variable name="pb_id" select="substring-after(@facs, '#')" />
        <xsl:apply-templates select="//tei:facsimile/tei:surface[@xml:id = $pb_id]" />
    </xsl:template>
    
    <!-- cb -->
    <xsl:template match="tei:cb">
        <xsl:variable name="col_id" select="@xml:id"/>
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="$col_id"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:apply-templates select="following-sibling::tei:*[@corresp=concat('#', $col_id)]"/>
        <xsl:apply-templates select="following-sibling::tei:div/tei:*[@corresp=concat('#', $col_id)]"/>
    </xsl:template>
         <!-- surface -->
    <xsl:template match="tei:surface">
        <xsl:element name="img">
            <xsl:attribute name="src"><xsl:value-of select="tei:graphic/@url"/></xsl:attribute>
            <xsl:attribute name="usemap">#<xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:attribute name="alt">Immagine <xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:attribute name="class">facsimile</xsl:attribute>
        </xsl:element>
        <xsl:element name="map">
            <xsl:attribute name="name"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:for-each select="tei:zone">
                <xsl:element name="area">
                    <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
                    <xsl:attribute name="coords"><xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/></xsl:attribute>
                    <xsl:attribute name="data-corresp"><xsl:value-of select="@corresp"/></xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <!-- head -->
    <xsl:template match="tei:head">
        <div class="paragr">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <strong><xsl:value-of select="@xml:id"/></strong>
            </xsl:element>
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>

    <!-- p -->
    <xsl:template match="tei:p">
        <div class="paragr">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <strong><xsl:value-of select="@xml:id"/></strong>
            </xsl:element>
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>
        
    <!-- ab -->
    <xsl:template match="tei:ab">
        <div class="paragr_gener">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <strong><xsl:value-of select="@xml:id"/></strong>
            </xsl:element>
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>
    
    <!-- lb -->
 <xsl:template match="tei:lb">
  <div class="riga">
  </div>
     <span class="numero-riga">
      <xsl:value-of select="@n"/>
    </span>
</xsl:template>




    <!-- list (Notizie) -->
    <xsl:template match="tei:list">
        <div class="paragr">
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:item">
        <div class="paragr">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <strong><xsl:value-of select="@xml:id"/></strong>
            </xsl:element>
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>
    
    <!-- closer -->
    <xsl:template match="tei:closer">
        <div class="paragr">
            <xsl:element name="span">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <strong><xsl:value-of select="@xml:id"/></strong>
            </xsl:element>
            <div class="blocco_testo">
                <xsl:apply-templates />
            </div>
        </div>
    </xsl:template>

    <!-- Testo in corsivo -->
    <xsl:template match="text()[ancestor::*[@rend='italic']]">
        <i><xsl:value-of select="."/></i>
    </xsl:template>

    <!-- Persone reali -->
    <xsl:template match="tei:name[@type='person']">
        <xsl:variable name="person_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">person</xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$person_ref]/tei:persName/tei:ref/@target"/></xsl:attribute>
                <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person">
            <xsl:if test="@xml:id = $person_ref">
                <span class="info">
                    <strong>Nome: </strong><xsl:value-of select="./tei:persName"/><br/>
                    <strong>Nascita: </strong><xsl:value-of select="./tei:birth"/><br/>
                    <strong>Morte: </strong><xsl:value-of select="./tei:death"/><br/>
                    <strong>Professione: </strong><xsl:value-of select="./tei:occupation"/><br/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Personaggi fittizi -->
    <xsl:template match="tei:name[@type='character']">
        <xsl:variable name="char_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">character</xsl:attribute>
            <xsl:element name="a">
                        <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person[@xml:id=$char_ref]/tei:persName/tei:ref/@target"/></xsl:attribute>
                        <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPerson/tei:person">
            <xsl:if test="@xml:id=$char_ref">
                <span class="info">
                    <strong>Nome: </strong><xsl:value-of select="./tei:persName"/><br/>
                    <strong>Ruolo: </strong><xsl:value-of select="./tei:occupation"/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Opere-->
    <xsl:template match="tei:name[@type='bibl']">
        <xsl:variable name="bibl_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">bibl</xsl:attribute>
            <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$bibl_ref]/tei:ref/@target"/></xsl:attribute>
                    <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl">
            <xsl:if test="@xml:id=$bibl_ref">
                <span class="info">
                    <strong>Titolo: </strong><xsl:value-of select="./tei:title"/><br/>
                    <strong>Autore: </strong>
                    <xsl:choose>
                        <xsl:when test="./tei:author">
                            <xsl:value-of select="./tei:author"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(./tei:respStmt/tei:name[1], ', ', ./tei:respStmt/tei:name[2])"/>
                        </xsl:otherwise>
                    </xsl:choose> <br/>
                    <strong>Anno: </strong><xsl:value-of select="./tei:date"/><br/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Organizzazioni -->
    <xsl:template match="tei:name[@type='org']">
        <xsl:variable name="org_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">org</xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org[@xml:id=$org_ref]/tei:orgName/tei:ref/@target"/></xsl:attribute>
                <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listOrg/tei:org">
            <xsl:if test="@xml:id = $org_ref">
                <span class="info">
                    <strong>Nome: </strong><xsl:value-of select="./tei:orgName"/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Luoghi -->
    <xsl:template match="tei:name[@type='place']">
        <xsl:variable name="place_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">place</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listPlace/tei:place">
                <xsl:if test="@xml:id=$place_ref">
                    <span class="info">
                        <strong>Nome: </strong><xsl:value-of select="./tei:placeName"/><br/>
                        <strong>Località: </strong><xsl:value-of select="./tei:location"/>
                    </span>
                </xsl:if>
            </xsl:for-each>
    </xsl:template>
    <!-- Eventi -->
    <xsl:template match="tei:name[@type='event']">
        <xsl:variable name="event_ref" select="substring-after(@ref, '#')" />
        <xsl:element name="span">
            <xsl:attribute name="class">event</xsl:attribute>
            <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event[@xml:id=$event_ref]/@ref"/></xsl:attribute>
                    <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listEvent/tei:event">
            <xsl:if test="@xml:id = $event_ref">
                <span class="info">
                    <strong><xsl:value-of select="./tei:label"/></strong>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Date -->
    <xsl:template match="tei:date">
        <xsl:element name="span">
            <xsl:attribute name="class">date</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- Numeri -->
    <xsl:template match="tei:num">
        <xsl:element name="span">
            <xsl:attribute name="class">num</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- Verbum -->
    <xsl:template match="tei:term[@type='verbum']">
        <xsl:element name="span">
            <xsl:attribute name="class">verbum</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- Testo in lingua straniera o dialetto -->
    <xsl:template match="*[@xml:lang and not(self::tei:term[@type='verbum']) and not(self::tei:quote) and not(self::tei:name)] | *[@type='dialect']">
        <xsl:element name="span">
            <xsl:attribute name="class">foreign</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- said -->
    <xsl:template match="tei:said">
        <xsl:element name="span">
            <xsl:attribute name="class">cit said</xsl:attribute>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <!-- Citazioni -->
    <xsl:template match="tei:quote | tei:quote[@xml:lang]">
        <xsl:variable name="cit_ref" select="substring-after(@source, '#')" />
        <span class="cit">
            <xsl:choose>
                <xsl:when test="$cit_ref">
                    <xsl:variable name="target" select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl[@xml:id=$cit_ref]/tei:ref/@target" />
                    <xsl:if test="string($target)">
                        <a href="{$target}" style="text-decoration:underline;">
                            <xsl:apply-templates/>
                        </a>
                    </xsl:if>
                    <xsl:if test="not(string($target))">
                        <xsl:apply-templates/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
        <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:div/tei:listBibl/tei:bibl">
            <xsl:if test="@xml:id = $cit_ref">
                <span class="info">
                    <strong>Titolo: </strong><xsl:value-of select="./tei:title"/><br/>
                    <strong>Autore: </strong><xsl:value-of select="./tei:author"/><br/>
                    <strong>Data: </strong><xsl:value-of select="./tei:date"/><br/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Glossario -->
    <xsl:template match="tei:term[@ref and not(@type='verbum')]">
        <xsl:variable name="gloss_ref" select="@ref" />
        <xsl:element name="span">
            <xsl:attribute name="class">glossario</xsl:attribute>
            <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select="/tei:TEI/tei:text/tei:back/tei:div/tei:list[@type='terminologia']/tei:item[@corresp=$gloss_ref]/tei:gloss/@source"/></xsl:attribute>
                <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
        <xsl:for-each select="//tei:item/tei:gloss">
            <xsl:if test="@target = $gloss_ref">
                <span class="info">
                    <xsl:value-of select="."/>
                </span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <!-- Interventi editoriali -->
    <xsl:template match="tei:expan">
        <xsl:choose>
            <xsl:when test="preceding-sibling::tei:abbr">
                <xsl:element name="span">
                    <xsl:attribute name="class">expan</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="class">expan</xsl:attribute>
                    <xsl:attribute name="class">show</xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:ex">
        <xsl:element name="span">
            <xsl:attribute name="class">ex</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:reg">
        <xsl:element name="span">
            <xsl:attribute name="class">reg</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:corr">
        <xsl:element name="span">
            <xsl:attribute name="class">corr</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
