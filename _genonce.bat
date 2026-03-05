@echo off
echo Running SUSHI (FHIR Shorthand Compiler)...
call sushi .
if %errorlevel% neq 0 (
    echo SUSHI compilation failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Running HL7 IG Publisher...
set "publisher_jar=input-cache\publisher.jar"
if not exist "%publisher_jar%" (
    echo Publisher JAR not found. Run _updatePublisher.bat first.
    pause
    exit /b 1
)

java -jar "%publisher_jar%" -ig ig.ini
pause
