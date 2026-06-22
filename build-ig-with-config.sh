#!/bin/bash
# build-ig-with-config.sh
# Builds the IE Core IG with configurable base URL
# Usage: ./build-ig-with-config.sh [base_url]
# Example: ./build-ig-with-config.sh https://hl7-ie.org

set -e

# Load build configuration
if [ -f "build-config.env" ]; then
    source build-config.env
fi

# Override with command-line argument if provided
if [ -n "$1" ]; then
    IE_CORE_BASE_URL="$1"
fi

echo "=========================================="
echo "IE Core IG Build Configuration"
echo "=========================================="
echo "Base URL: $IE_CORE_BASE_URL"
echo ""

# Validate URL format
if ! [[ "$IE_CORE_BASE_URL" =~ ^https?:// ]]; then
    echo "ERROR: Base URL must start with http:// or https://"
    exit 1
fi

echo "Step 1: Applying configuration substitutions..."

# Temporary directory for substitutions
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Create a sed script to replace the base URL
# Replace all occurrences in aliases.fsh
sed "s|https://hl7-ie\.github\.io|$IE_CORE_BASE_URL|g" input/fsh/aliases.fsh > "$TEMP_DIR/aliases.fsh"
cp "$TEMP_DIR/aliases.fsh" input/fsh/aliases.fsh

# Also for R5 aliases if it exists
if [ -f "r5/input/fsh/aliases.fsh" ]; then
    sed "s|https://hl7-ie\.github\.io|$IE_CORE_BASE_URL|g" r5/input/fsh/aliases.fsh > "$TEMP_DIR/aliases-r5.fsh"
    cp "$TEMP_DIR/aliases-r5.fsh" r5/input/fsh/aliases.fsh
fi

echo "✓ Applied base URL substitutions"
echo ""

echo "Step 2: Running SUSHI compilation..."
sushi .

echo ""
echo "Step 3: Downloading IG Publisher..."
if [ -f "_updatePublisher.sh" ]; then
    chmod +x _updatePublisher.sh
    ./_updatePublisher.sh
fi

echo ""
echo "Step 4: Building IG..."
if [ -f "_genonce.sh" ]; then
    chmod +x _genonce.sh
    ./_genonce.sh
fi

echo ""
echo "=========================================="
echo "Build completed successfully!"
echo "IG output available in ./output/"
echo "Canonical URL: $IE_CORE_BASE_URL/fhir/ie/core"
echo "=========================================="
