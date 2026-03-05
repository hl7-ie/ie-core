@echo off
setlocal

echo ================================================================
echo  IE Core FHIR IG - Build Pipeline
echo ================================================================
echo.

echo [Step 1/3] Running SUSHI (FSH Compiler)...
call sushi .
if %errorlevel% neq 0 (
    echo.
    echo ERROR: SUSHI compilation failed!
    pause
    exit /b %errorlevel%
)
echo SUSHI: OK
echo.

set "publisher_jar=input-cache\publisher.jar"
if not exist "%publisher_jar%" (
    echo [Step 2/3] IG Publisher JAR not found. Downloading...
    call _updatePublisher.bat
)

echo [Step 2/3] Running HL7 IG Publisher (validation + generation)...
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -jar "%publisher_jar%" -ig ig.ini
set BUILD_RESULT=%errorlevel%

echo.
echo ================================================================
if %BUILD_RESULT% equ 0 (
    echo  BUILD SUCCEEDED
    echo  Open output\index.html to view the IG
) else (
    echo  BUILD COMPLETED WITH ISSUES (exit code: %BUILD_RESULT%)
    echo  If only Jekyll failed, FHIR validation still passed.
    echo  Check output\qa.json for QA summary.
    echo  Run the full build in GitHub Actions for complete output.
)
echo ================================================================
echo.
pause
