#!/bin/bash

mkdir -p input-cache

dlurl="https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar"
echo "Downloading latest IG Publisher to input-cache..."
curl -L "$dlurl" -o input-cache/publisher.jar
echo "Done."
