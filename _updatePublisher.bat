@echo off
if not exist "input-cache" mkdir input-cache

set "dlurl=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar"
echo Downloading latest IG Publisher to input-cache...
powershell -Command "Invoke-WebRequest -Uri '%dlurl%' -OutFile 'input-cache\publisher.jar' -UseBasicParsing"
echo.
echo Done. IG Publisher downloaded to input-cache\publisher.jar
pause
