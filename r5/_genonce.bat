@echo off
setlocal

echo ================================================================
echo  IE Core FHIR IG (R5 Edition) - Build Pipeline
echo ================================================================
echo.

echo [Step 1/3] Running SUSHI (FSH Compiler — R5)...
call sushi .
if %errorlevel% neq 0 (
    echo.
    echo ERROR: SUSHI R5 compilation failed!
    pause
    exit /b %errorlevel%
)
echo SUSHI R5: OK
echo.

set "publisher_jar=input-cache\publisher.jar"
if not exist "%publisher_jar%" (
    echo [Step 2/3] IG Publisher JAR not found. Downloading...
    if not exist "input-cache" mkdir input-cache
    curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o "%publisher_jar%"
    if %errorlevel% neq 0 (
        echo ERROR: Failed to download IG Publisher.
        pause
        exit /b 1
    )
)

echo [Step 2/3] Running HL7 IG Publisher (R5 validation + generation)...
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -jar "%publisher_jar%" -ig ig.ini
set BUILD_RESULT=%errorlevel%

echo.
echo ================================================================
if %BUILD_RESULT% equ 0 (
    echo  R5 BUILD SUCCEEDED
    echo  Open output\index.html to view the R5 IG
) else (
    echo  R5 BUILD COMPLETED WITH ISSUES (exit code: %BUILD_RESULT%)
    echo  If only Jekyll failed, FHIR validation still passed.
    echo  Check output\qa.json for QA summary.
)
echo ================================================================
echo.
pause
