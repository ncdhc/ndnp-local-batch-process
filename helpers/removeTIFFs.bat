@echo off

REM descend into "data" directory
cd "%~dp0data"

REM use the Find and Replace Text utility to change .tif to .jp2 in METS files
fart -r *_1.xml ".tif" ".jp2"

echo METS files have been updated!

REM delete tiff files
del /s *.tif

echo TIFF files have been removed!

pause