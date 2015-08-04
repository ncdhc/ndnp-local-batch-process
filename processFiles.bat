@echo off

# prompt for the name of the batch spreadsheet XML file
Set /p "XML=Enter the name of the spreadsheet XML file:  "

# if the batch spreadsheet file exists below this script in the 
# “data”  directory, proceed
if exist "%~dp0data\%XML%.xml" (

# use the saxon transform executable to generate three temporary batch files
# that will handle directory creation (mkdir.bat), file moving (move.bat), 
# and file renaming (rename.bat) from batch spreadsheet XML.
"%~dp0lib\saxon\Transform" -s:"%~dp0data\%XML%.xml" -xsl:"%~dp0lib\mkdirMove.xsl"

# descend into the data directory
cd "%~dp0data"

# run each of the temporary batch files. die immediately if there’s a problem.
for %%b in ("mkdir.bat" "move.bat" "rename.bat") do call %%b|| exit /b 1

echo Issue directories created!
echo Files moved into issue directories!
echo Files inside directories renamed!

# remove each of the temporary batch files
del mkdir.bat
del move.bat
del rename.bat

# use PDFTK to combine page PDFs into an issue-level PDF inside each issue folder
echo Creating issue-level all.pdf files...
for /d /r %%G in (*) do "%~dp0lib\pdftk\pdftk" "%%G\*.pdf" cat output "%%G\all.pdf"
echo PDF files created!

# ascend out of the data directory again
cd "%~dp0"

# use the saxon transform executable to generate each issue’s METS, automatically 
# saved to each issue’s folder, from the batch spreadsheet XML
"%~dp0lib\saxon\Transform" -s:"%~dp0data\%XML%.xml" -xsl:"%~dp0lib\makeMETS.xsl"
echo METS files created!

# use the saxon transform executable to generate the batch manifest file
"%~dp0lib\saxon\Transform" -s:"%~dp0data\%XML%.xml" -xsl:"%~dp0lib\makeBatchXML.xsl"
echo Batch-level catalog file created!

pause

) else (

echo %XML%.xml does not exist in the files directory!

pause

)
