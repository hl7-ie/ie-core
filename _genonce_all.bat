@echo off
setlocal

echo ================================================================
echo  IE Core FHIR IG - Full Build (R4 + R5)
echo ================================================================
echo.

echo ================================================================
echo  PHASE 1: R4 Edition
echo ================================================================
echo.

echo [R4 1/2] Running SUSHI (R4)...
call sushi .
if %errorlevel% neq 0 (
    echo ERROR: SUSHI R4 compilation failed!
    pause
    exit /b %errorlevel%
)
echo SUSHI R4: OK
echo.

set "publisher_jar=input-cache\publisher.jar"
if not exist "%publisher_jar%" (
    echo [R4 2/2] Downloading IG Publisher...
    if not exist "input-cache" mkdir input-cache
    curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o "%publisher_jar%"
)

echo [R4 2/2] Running IG Publisher (R4)...
set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -jar "%publisher_jar%" -ig ig.ini
set R4_RESULT=%errorlevel%
echo.

echo ================================================================
echo  PHASE 2: R5 Edition
echo ================================================================
echo.

echo [R5 1/2] Running SUSHI (R5)...
pushd r5
call sushi .
if %errorlevel% neq 0 (
    echo ERROR: SUSHI R5 compilation failed!
    popd
    pause
    exit /b %errorlevel%
)
echo SUSHI R5: OK
echo.

set "r5_publisher_jar=input-cache\publisher.jar"
if not exist "%r5_publisher_jar%" (
    echo [R5 2/2] Downloading IG Publisher for R5...
    if not exist "input-cache" mkdir input-cache
    curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o "%r5_publisher_jar%"
)

echo [R5 2/2] Running IG Publisher (R5)...
java -jar "%r5_publisher_jar%" -ig ig.ini
set R5_RESULT=%errorlevel%
popd
echo.

echo ================================================================
echo  BUILD SUMMARY
echo ================================================================
if %R4_RESULT% equ 0 (
    echo  R4: SUCCEEDED — output\index.html
) else (
    echo  R4: COMPLETED WITH ISSUES (exit code: %R4_RESULT%)
)
if %R5_RESULT% equ 0 (
    echo  R5: SUCCEEDED — r5\output\index.html
) else (
    echo  R5: COMPLETED WITH ISSUES (exit code: %R5_RESULT%)
)
echo ================================================================
echo.
pause
