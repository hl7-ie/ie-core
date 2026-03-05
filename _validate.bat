@echo off
setlocal

echo ================================================================
echo  IE Core FHIR IG - Quick Validation (SUSHI only)
echo ================================================================
echo.
echo This runs SUSHI to check FSH syntax and compile to FHIR JSON.
echo For full validation, use _genonce.bat or the GitHub Actions pipeline.
echo.

call sushi .
if %errorlevel% equ 0 (
    echo.
    echo ================================================================
    echo  VALIDATION PASSED - FSH compiles cleanly
    echo  Generated resources are in fsh-generated\resources\
    echo ================================================================
) else (
    echo.
    echo ================================================================
    echo  VALIDATION FAILED - Fix the errors above
    echo ================================================================
)
echo.
pause
