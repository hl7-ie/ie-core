@echo off
if not exist "input-cache" mkdir input-cache

set "dlurl=https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar"
echo Downloading latest IG Publisher to input-cache...
powershell -Command "Invoke-WebRequest -Uri '%dlurl%' -OutFile 'input-cache\publisher.jar'"
echo Done.
pause
