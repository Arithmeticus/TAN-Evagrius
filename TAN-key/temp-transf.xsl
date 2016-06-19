<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tan="tag:textalign.net,2015:ns"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="tag:textalign.net,2015:ns"
    exclude-result-prefixes="xs tan"
    version="3.0">
    <xsl:output indent="yes"/>
    
    <xsl:variable name="corpus" select="doc('corpus.xml')"/>
    <xsl:variable name="language-key" as="element()*">
        <lang full="Greek" bcp="grc"/>
        <lang full="Syriac" bcp="syr"/>
        <lang full="Armenian" bcp="hye"/>
        <lang full="Georgian" bcp="kat"/>
        <lang full="Latin" bcp="lat"/>
        <lang full="Ethiopic" bcp="gez"/>
        <lang full="Old Russian" bcp="rus"/>
        <lang full="Arabic" bcp="ara"/>
        <lang full="Coptic" bcp="cop"/>
        <lang full="Sogdian" bcp="sog"/>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
        <!--<group>
            <!-\-<xsl:for-each-group select="//tan:version" group-by="replace(@xml:id,'-\w+','')">
                <claim subject="{current-group()/@xml:id}" verb="is-translation-of"
                    object="{current-grouping-key()}"></claim>
        </xsl:for-each-group>-\->
        <xsl:for-each select="//incipit">
            <claim subject="{replace(../URN,'.+2015:','')}" verb="has-incipit">
                <object xml:lang="grc"><xsl:value-of select="."/></object>
            </claim>
        </xsl:for-each>
        </group>-->
    </xsl:template>
    
    <!--<version xml:id="{replace(tan:IRI,'.+2015:([^:]+):version:(\w+)','$1-$2')}"
        which="{tan:name}"></version>-->
    
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tan:item[not(@affects-element)]">
        <xsl:variable name="this-iri" select="tan:IRI"/>
        <xsl:variable name="this-first-name" select="tan:name[1]"/>
        <xsl:variable name="corpus-record" select="$corpus//element[URN = $this-iri]"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="*"/>
            <xsl:apply-templates select="$corpus-record/textual-notes"/>
        </xsl:copy>
        
        <!--<xsl:for-each select="$corpus-record/translations-ancient/element">
            <xsl:variable name="this-lang" select="."/>
            <xsl:variable name="this-bcp-lang" select="$language-key[@full = replace($this-lang,' \(not extant\)','')]/@bcp"/>
            <xsl:text>&#xA;</xsl:text>
            <item affects-element="version">
                <IRI><xsl:value-of select="$this-iri || ':version:' || $this-bcp-lang"/></IRI>
                <name><xsl:value-of select="$this-lang"/> translation of <xsl:value-of select="$this-first-name"/></name>
            </item>
        </xsl:for-each>-->
    </xsl:template>
    
    <!--<xsl:template match="URN">
        <IRI><xsl:value-of select="."/></IRI>
    </xsl:template>-->
    <!--<xsl:template match="*[matches(name(.),'^title')]">
        <xsl:variable name="lang" select="replace(name(.),'\w+-','')"/>
        <name>
            <xsl:if test="not(matches($lang,'abbreviation'))">
                <xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="."/>
        </name>
    </xsl:template>-->
    <xsl:template match="description|textual-notes">
        <desc><xsl:value-of select="."/></desc>
    </xsl:template>
    
</xsl:stylesheet>