#!/bin/bash
set -e

echo "================================================================"
echo " IE Core FHIR IG (R5 Edition) — Build Pipeline"
echo "================================================================"
echo ""

echo "[Step 1/3] Running SUSHI (FSH Compiler — R5)..."
sushi .
echo "SUSHI R5: OK"
echo ""

publisher_jar="input-cache/publisher.jar"
if [ ! -f "$publisher_jar" ]; then
    echo "[Step 2/3] IG Publisher JAR not found. Downloading..."
    mkdir -p input-cache
    curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar \
      -o "$publisher_jar"
fi

echo "[Step 2/3] Running HL7 IG Publisher (R5 validation + generation)..."
java -Dfile.encoding=UTF-8 -jar "$publisher_jar" -ig ig.ini
BUILD_RESULT=$?

echo ""
echo "================================================================"
if [ "$BUILD_RESULT" -eq 0 ]; then
    echo " R5 BUILD SUCCEEDED"
    echo " Open output/index.html to view the R5 IG"
else
    echo " R5 BUILD COMPLETED WITH ISSUES (exit code: $BUILD_RESULT)"
    echo " Check output/qa.json for QA summary."
fi
echo "================================================================"
