@echo off

# make some directories for processing
mkdir reformattedXML
mkdir originalXML

# move all of the XML files in "data" to the "originalXML" folder as a backup
move "%~dp0data\*.xml" "%~dp0originalXML"

# use the saxon transform executable to transform each file in "originalXML" to a new output file in "reformattedXML"
"%~dp0lib\saxon\Transform" -s:"%~dp0originalXML" -o:"%~dp0reformattedXML" -xsl:"%~dp0lib\abbyyalto_to_ndnpalto.xsl"

echo ABBYY ALTO transformed to NDNP ALTO!

# descend into "reformattedXML" directory
cd "%~dp0reformattedXML"

# use Find and Replace Text utility to change namespaces
"%~dp0lib\fart" *.xml "http://www.loc.gov/standards/alto/ns-v2#" "http://schema.ccs-gmbh.com/ALTO"

echo Namespace declaration corrected!

# ascend to root directory again
cd "%~dp0"

# move all of the processed XML files back to the "data" directory
move "%~dp0reformattedXML\*.xml" "%~dp0data"

echo XML files returned to the correct folder!

# delete the empty "reformattedXML" directory
rmdir /s /q "%~dp0reformattedXML"

pause

