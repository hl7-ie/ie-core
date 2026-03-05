#!/bin/bash

echo "Running SUSHI (FHIR Shorthand Compiler)..."
sushi .
if [ $? -ne 0 ]; then
    echo "SUSHI compilation failed!"
    exit 1
fi

echo ""
echo "Running HL7 IG Publisher..."
publisher_jar="input-cache/publisher.jar"
if [ ! -f "$publisher_jar" ]; then
    echo "Publisher JAR not found. Run _updatePublisher.sh first."
    exit 1
fi

java -jar "$publisher_jar" -ig ig.ini
