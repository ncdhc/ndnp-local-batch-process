<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="text" indent="no" name="text" omit-xml-declaration="yes" />
    <xsl:output method="xml" indent="yes" name="xml" omit-xml-declaration="no" />
    <xsl:variable name="currentdate" select="current-date()"/>
    <xsl:template match="/">
        <xsl:result-document href="files\mkdir.bat" format="text">
            <xsl:text>@echo off&#xD;&#xa;</xsl:text>
            <xsl:text>REM temporary batch file to create directories for a group of digitized newspaper files&#xD;&#xa;</xsl:text>
            <xsl:text>REM created by mkdirMove.xsl </xsl:text><xsl:value-of select="$currentdate"/><xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:for-each-group select="root/row" group-by="Issue_ID">
                <xsl:text>mkdir </xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>&#xD;&#xa;</xsl:text>
            </xsl:for-each-group>
        </xsl:result-document>
        <xsl:result-document href="files\move.bat" format="text">
            <xsl:text>@echo off&#xD;&#xa;</xsl:text>
            <xsl:text>REM temporary batch file to move newspaper files into associated directories&#xD;&#xa;</xsl:text>
            <xsl:text>REM created by mkdirMove.xsl </xsl:text><xsl:value-of select="$currentdate"/><xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:for-each select="root/row" >
                <xsl:text>move </xsl:text><xsl:value-of select="Frame_ID"/><xsl:text>.* </xsl:text><xsl:value-of select="Issue_ID"/><xsl:text>/</xsl:text><xsl:text>&#xD;&#xa;</xsl:text>
            </xsl:for-each> 
        </xsl:result-document>
        <xsl:result-document href="files\rename.bat" format="text">
            <xsl:text>@echo off&#xD;&#xa;</xsl:text>
            <xsl:text>REM temporary batch file to rename files according to page sequence number&#xD;&#xa;</xsl:text>
            <xsl:text>REM created by mkdirMove.xsl </xsl:text><xsl:value-of select="$currentdate"/><xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:text>&#xD;&#xa;</xsl:text>
            <xsl:for-each select="root/row" >
                <xsl:variable name="seqnum" select="format-number(Page_Sequence_Number,'0000')"/>
                <xsl:text>ren </xsl:text><xsl:value-of select="Issue_ID"/><xsl:text>\</xsl:text><xsl:value-of select="Frame_ID"/><xsl:text>.* </xsl:text><xsl:value-of select="$seqnum"/><xsl:text>.*</xsl:text><xsl:text>&#xD;&#xa;</xsl:text>
            </xsl:for-each> 
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
