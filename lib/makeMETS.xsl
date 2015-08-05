<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:mix="http://www.loc.gov/mix/" xmlns:ndnp="http://www.loc.gov/ndnp"
    xmlns:premis="http://www.oclc.org/premis" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:alto="http://schema.ccs-gmbh.com/ALTO" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.loc.gov/METS/">
    <xsl:output method="xml" indent="yes" name="xml" omit-xml-declaration="no"/>
    <xsl:template match="/">
        <xsl:for-each-group select="root/row" group-by="Issue_ID">
            <xsl:variable name="issuetitle">
                <xsl:value-of select="Title"/>
            </xsl:variable>
            <xsl:variable name="issuedate">
                <xsl:value-of select="Date-Numeric"/>
            </xsl:variable>
            <xsl:variable name="issueid" select="Issue_ID"/>
            <xsl:result-document href="files\{$issueid}\{$issueid}_1.xml" format="xml">
                <mets TYPE="urn:library-of-congress:ndnp:mets:newspaper:issue"
                    PROFILE="urn:library-of-congress:mets:profiles:ndnp:issue:v1.5"
                    LABEL="{$issuetitle}" xmlns:mix="http://www.loc.gov/mix/"
                    xmlns:ndnp="http://www.loc.gov/ndnp" xmlns:premis="http://www.oclc.org/premis"
                    xmlns:mods="http://www.loc.gov/mods/v3"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/METS/"
                    xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version17/mets.v1-7.xsd http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-3.xsd">

                    <xsl:comment> METS HEADER </xsl:comment>
                    <xsl:text>&#xA;</xsl:text>
                    <xsl:variable name="currentdate" select="current-dateTime()"/>
                    <metsHdr CREATEDATE="{$currentdate}">
                        <agent ROLE="CREATOR" TYPE="ORGANIZATION">
                            <name>
                                <xsl:value-of select="Reproduction_Agency"/>
                            </name>
                        </agent>
                    </metsHdr>


                    <xsl:comment> DESCRIPTIVE METADATA </xsl:comment>
                    <xsl:text>&#xA;</xsl:text>

                    <dmdSec ID="issueModsBib">
                        <mdWrap MDTYPE="MODS" LABEL="Issue metadata">
                            <xmlData>
                                <mods:mods>
                                    <mods:relatedItem type="host">
                                        <mods:identifier type="lccn">
                                            <xsl:value-of select="LCCN"/>
                                        </mods:identifier>
                                        <mods:part>
                                            <mods:detail type="volume">
                                                <mods:number>
                                                  <xsl:value-of select="Volume_Number"/>
                                                </mods:number>
                                            </mods:detail>
                                            <mods:detail type="issue">
                                                <mods:number>
                                                  <xsl:value-of select="Issue_Number"/>
                                                </mods:number>
                                            </mods:detail>
                                            <mods:detail type="edition">
                                                <mods:number>
                                                  <xsl:value-of select="Edition_Order"/>
                                                </mods:number>
                                            </mods:detail>
                                        </mods:part>
                                    </mods:relatedItem>
                                    <mods:originInfo>
                                        <mods:dateIssued encoding="iso8601">
                                            <xsl:value-of select="$issuedate"/>
                                        </mods:dateIssued>
                                    </mods:originInfo>
                                    <mods:note type="noteAboutReproduction">
                                        <xsl:value-of select="Reproduction_Note"/>
                                    </mods:note>
                                </mods:mods>
                            </xmlData>
                        </mdWrap>
                    </dmdSec>

                    <xsl:for-each select="current-group()">
                        <xsl:variable name="pageModsNo" select="concat('pageModsBib',Page_Sequence_Number)"/>
                        <xsl:variable name="physloc" select="Physical_Location"/>
                        <xsl:variable name="physloccode" select="Physical_Location_Code"/>
                        <xsl:variable name="pagephysdesc" select="lower-case(Page_Physical_Description)"/>
                        <xsl:variable name="repagency">
                            <xsl:value-of select="Reproduction_Agency"/>
                        </xsl:variable>
                        <xsl:variable name="repagencycode">
                            <xsl:value-of select="Reproduction_Agency_Code"/>
                        </xsl:variable>
                        <xsl:variable name="reelseqnum" select="number(Reel_Sequence_Number)"/>
                        <dmdSec ID="{$pageModsNo}">
                            <mdWrap MDTYPE="MODS" LABEL="Page metadata">
                                <xmlData>
                                    <mods:mods>
                                        <mods:part>
                                            <mods:extent unit="pages">
                                                <mods:start>
                                                  <xsl:value-of select="Page_Sequence_Number"/>
                                                </mods:start>
                                            </mods:extent>
                                        </mods:part>
                                        <mods:relatedItem type="original">
                                            <mods:physicalDescription>
                                                <mods:form type="{$pagephysdesc}"/>
                                            </mods:physicalDescription>

                                            <mods:identifier type="reel number">
                                                <xsl:value-of select="Reel_Number"/>
                                            </mods:identifier>
                                            <mods:identifier type="reel sequence number">
                                                <xsl:value-of select="number($reelseqnum)"/>
                                            </mods:identifier>
                                            <mods:location>
                                                <mods:physicalLocation authority="marcorg"
                                                  displayLabel="{$physloc}">
                                                    <xsl:value-of select="$physloccode"/>
                                                </mods:physicalLocation>
                                            </mods:location>
                                        </mods:relatedItem>
                                        <mods:note type="agencyResponsibleForReproduction"
                                            displayLabel="{$repagency}">
                                            <xsl:value-of select="$repagencycode"/>
                                        </mods:note>
                                        <mods:note type="noteAboutReproduction">
                                            <xsl:value-of select="Reproduction_Note"/>
                                        </mods:note>
                                    </mods:mods>
                                </xmlData>
                            </mdWrap>
                        </dmdSec>
                    </xsl:for-each>
                    
                    <xsl:comment> TECHNICAL METADATA </xsl:comment>
                    <xsl:text>&#xA;</xsl:text>
                    <amdSec>
                    <xsl:for-each select="current-group()">
                        <xsl:variable name="pagenumber" select="Page_Sequence_Number"/>
                        <xsl:variable name="filename" select="format-number(Page_Sequence_Number,'0000')"/>
                        <xsl:variable name="altopath" select="concat('../files/',$issueid,'/',$filename,'.xml')"/>
                        <xsl:variable name="altofile" select="document($altopath)"/>
                        <xsl:variable name="tiffwidthalto" select="$altofile//alto:Layout/alto:Page/@WIDTH"/>
                        <xsl:variable name="tiffwidth" select="round($tiffwidthalto * .333333333)"/>
                        <xsl:variable name="tiffheightalto" select="$altofile//alto:Layout/alto:Page/@HEIGHT"/>
                        <xsl:variable name="tiffheight" select="round($tiffheightalto * .333333333)"/>
                        <techMD ID="mixserviceFile{$pagenumber}">
                            <mdWrap LABEL="NISO still image metadata" MDTYPE="NISOIMG">
                                <xmlData>
                                    <mix:mix>
                                        <mix:ImagingPerformanceAssessment>
                                            <mix:SpatialMetrics>
                                                <mix:ImageWidth><xsl:value-of select="$tiffwidth"/></mix:ImageWidth>
                                                <mix:ImageLength><xsl:value-of select="$tiffheight"/></mix:ImageLength>
                                            </mix:SpatialMetrics>
                                        </mix:ImagingPerformanceAssessment>
                                    </mix:mix>
                                </xmlData>
                            </mdWrap>
                        </techMD>    
                    </xsl:for-each>
                    </amdSec>

                    <xsl:comment> FILE SECTION </xsl:comment>
                    <xsl:text>&#xA;</xsl:text>
                    <fileSec>
                        <xsl:for-each select="current-group()">
                            <xsl:variable name="pagenumber" select="Page_Sequence_Number"/>
                            <xsl:variable name="filename" select="format-number(Page_Sequence_Number,'0000')"/>
                            <fileGrp ID="pageFileGrp{$pagenumber}">
                                <file ID="masterFile{$pagenumber}" USE="master">
                                    <FLocat LOCTYPE="OTHER" OTHERLOCTYPE="file"
                                        xlink:href="{$filename}.tif"/>
                                </file>
                                <file ADMID="mixserviceFile{$pagenumber}" ID="serviceFile{$pagenumber}" USE="service">
                                    <FLocat LOCTYPE="OTHER" OTHERLOCTYPE="file"
                                        xlink:href="{$filename}.jp2"/>
                                </file>
                                <file ID="otherDerivativeFile{$pagenumber}" USE="derivative">
                                    <FLocat LOCTYPE="OTHER" OTHERLOCTYPE="file"
                                        xlink:href="{$filename}.pdf"/>
                                </file>
                                <file ID="ocrFile{$pagenumber}" USE="ocr">
                                    <FLocat LOCTYPE="OTHER" OTHERLOCTYPE="file"
                                        xlink:href="{$filename}.xml"/>
                                </file>
                            </fileGrp>
                        </xsl:for-each>
                    </fileSec>
                    <xsl:comment> STRUCTURAL MAP </xsl:comment>
                    <xsl:text>&#xA;</xsl:text>
                    <structMap xmlns:np="urn:library-of-congress:ndnp:mets:newspaper">
                        <div TYPE="np:issue" DMDID="issueModsBib">

                            <xsl:for-each select="current-group()">
                                <xsl:variable name="pagenumber" select="Page_Sequence_Number"/>
                                <div TYPE="np:page" DMDID="pageModsBib{$pagenumber}">
                                    <fptr FILEID="masterFile{$pagenumber}"/>
                                    <fptr FILEID="serviceFile{$pagenumber}"/>
                                    <fptr FILEID="otherDerivativeFile{$pagenumber}"/>
                                    <fptr FILEID="ocrFile{$pagenumber}"/>
                                </div>
                            </xsl:for-each>

                        </div>
                    </structMap>
                </mets>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
