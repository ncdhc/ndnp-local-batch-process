<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <!--set variable multiplier value based on resolution.
        
        value is based on the following equation:
        
        [ pixel = value * ( resolution / 1200 )] 
        
        ... and is dependent on the resolution of scanned images.
        e.g., 3 for 400dpi, 4 for 300dpi
    -->
    <xsl:variable name="multiplier" select="3"/>
    
    

    <!-- copy all nodes and their attributes to output after applying additional templates (below) --> 
    <xsl:template match="@*|node()">

        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>

    </xsl:template>
   

    
     <!--add HEIGHT and WIDTH attribute of PrintSpace element to Page element -->
     <!--add PROCESSING attribute (with value of OCRProcessing ID) to Page element -->
    <xsl:template match="node()[name()='Page']">
        <xsl:copy>
            <xsl:attribute name="HEIGHT">
                <xsl:value-of select="(child::node()/@HEIGHT) * $multiplier"/>
            </xsl:attribute>
            <xsl:attribute name="WIDTH">
                <xsl:value-of select="(child::node()/@WIDTH) * $multiplier"/>
            </xsl:attribute>
            <xsl:attribute name="PROCESSING">
                <xsl:value-of select="//node()[name()='OCRProcessing']/@ID"/>
            </xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <!--change PHYSICAL_IMG_NR value on Page element to match filename number --> 
    <xsl:template match="@PHYSICAL_IMG_NR">
        <xsl:attribute name="PHYSICAL_IMG_NR">
            <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>
            <xsl:variable name="filenamepart" select="tokenize($filename, '_')[last()]"/>
            <xsl:value-of select="number(replace($filenamepart,'.xml',''))"/>               
        </xsl:attribute>
    </xsl:template>    
        
    <!--remove Shape elements and their contents -->
    <xsl:template match="node()[name()='Shape']"/> 
    
    <!--remove GraphicalElement elements and their contents -->
    <xsl:template match="node()[name()='GraphicalElement']"/>
    
    <!--perform math on all coordinate values to convert pixels to inch1200:
        @VPOS, @HPOS, @LEFT, @RIGHT, @FIRSTLINE, @LINESPACE, @HEIGHT, @WIDTH  
        conversion is based on the following equation:
        
        pixel = value * ( resolution / 1200 ) 
        
        ... and is dependent on the resolution of scanned images.
        [. * 3] for 400dpi, [. * 4] for 300dpi, etc.
    -->
    <xsl:template match="@VPOS">
        <xsl:attribute name="VPOS">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@HPOS">
        <xsl:attribute name="HPOS">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@LEFT">
        <xsl:attribute name="LEFT">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@RIGHT">
        <xsl:attribute name="RIGHT">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@FIRSTLINE">
        <xsl:attribute name="FIRSTLINE">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@LINESPACE">
        <xsl:attribute name="LINESPACE">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@HEIGHT">
        <xsl:attribute name="HEIGHT">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="@WIDTH">
        <xsl:attribute name="WIDTH">
            <xsl:value-of select=". * $multiplier"/>
        </xsl:attribute>
    </xsl:template>
    
    <!--change measurement unit text to inch1200-->
    <xsl:template match="node()[name()='MeasurementUnit']">
        <xsl:copy>
            <xsl:text>inch1200</xsl:text>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>