#!/bin/bash

echo "================================================================"
echo " IE Core FHIR IG — Full Build (R4 + R5)"
echo "================================================================"
echo ""

PUBLISHER_JAR="input-cache/publisher.jar"

download_publisher() {
    local target="$1"
    if [ ! -f "$target" ]; then
        echo "Downloading IG Publisher..."
        mkdir -p "$(dirname "$target")"
        curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar \
          -o "$target"
    fi
}

echo "================================================================"
echo " PHASE 1: R4 Edition"
echo "================================================================"
echo ""

echo "[R4 1/2] Running SUSHI (R4)..."
sushi .
R4_SUSHI=$?
if [ "$R4_SUSHI" -ne 0 ]; then
    echo "ERROR: SUSHI R4 compilation failed!"
    exit 1
fi
echo "SUSHI R4: OK"
echo ""

download_publisher "$PUBLISHER_JAR"

echo "[R4 2/2] Running IG Publisher (R4)..."
java -Dfile.encoding=UTF-8 -jar "$PUBLISHER_JAR" -ig ig.ini
R4_RESULT=$?
echo ""

echo "================================================================"
echo " PHASE 2: R5 Edition"
echo "================================================================"
echo ""

echo "[R5 1/2] Running SUSHI (R5)..."
cd r5
sushi .
R5_SUSHI=$?
if [ "$R5_SUSHI" -ne 0 ]; then
    echo "ERROR: SUSHI R5 compilation failed!"
    cd ..
    exit 1
fi
echo "SUSHI R5: OK"
echo ""

download_publisher "input-cache/publisher.jar"

echo "[R5 2/2] Running IG Publisher (R5)..."
java -Dfile.encoding=UTF-8 -jar "input-cache/publisher.jar" -ig ig.ini
R5_RESULT=$?
cd ..
echo ""

echo "================================================================"
echo " BUILD SUMMARY"
echo "================================================================"
if [ "$R4_RESULT" -eq 0 ]; then
    echo " R4: SUCCEEDED — output/index.html"
else
    echo " R4: COMPLETED WITH ISSUES (exit code: $R4_RESULT)"
fi
if [ "$R5_RESULT" -eq 0 ]; then
    echo " R5: SUCCEEDED — r5/output/index.html"
else
    echo " R5: COMPLETED WITH ISSUES (exit code: $R5_RESULT)"
fi
echo "================================================================"
