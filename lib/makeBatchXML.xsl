<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:ndnp="http://www.loc.gov/ndnp" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns="http://www.loc.gov/ndnp">
    <xsl:output method="xml" indent="yes" name="xml" omit-xml-declaration="no"/>
    <xsl:template match="/">
        <xsl:result-document href="files\batch_1.xml" format="xml" indent="yes">
        <xsl:variable name="batchid" select="replace(//row[1]/Reel_Number, '_','')"/>
        <xsl:text>&#xA;</xsl:text>
        <ndnp:batch xmlns:ndnp="http://www.loc.gov/ndnp"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.loc.gov/ndnp"
            name="batch_ncu_{$batchid}_ver01">
            <xsl:for-each-group select="root/row" group-by="Issue_ID">
                <xsl:variable name="issueid" select="Issue_ID"/>
                <xsl:variable name="issuedate" select="Date-Numeric"/>
                <xsl:variable name="editionorder" select="Edition_Order"/>
                <xsl:variable name="lccn" select="LCCN"/>
                <xsl:text>&#xA;</xsl:text>
                <ndnp:issue lccn="{$lccn}" issueDate="{$issuedate}" editionOrder="{$editionorder}">
                    <xsl:value-of select="$issueid"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$issueid"/>
                    <xsl:text>_1.xml</xsl:text>
                </ndnp:issue>
            </xsl:for-each-group>
            <xsl:text>&#xA;</xsl:text>
        </ndnp:batch>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
