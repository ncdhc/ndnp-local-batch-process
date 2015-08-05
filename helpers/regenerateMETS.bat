@echo off

Set /p "XML=Enter the name of the spreadsheet XML file:  "

# if the batch spreadsheet file exists as entered, proceed
if exist "%~dp0data\%XML%.xml" (

# use the saxon transform executable to regenerate issue-level METS files
"%~dp0lib\saxon\Transform" -s:"%~dp0files\%XML%.xml" -xsl:"%~dp0lib\makeMETS.xsl"
echo METS files regenerated!

# use the saxon transform executable to regenerate batch-level catalog file
"%~dp0lib\saxon\Transform" -s:"%~dp0files\%XML%.xml" -xsl:"%~dp0lib\makeBatchXML.xsl"
echo Batch-level catalog file regenerated!

pause

) else (

echo %XML%.xml does not exist in the files directory!

pause

)
