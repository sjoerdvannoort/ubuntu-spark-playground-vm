#!/bin/bash

# Check if Ivy is installed
if ! command -v ivy &> /dev/null; then
    echo "Ivy is not installed. Please install Ivy first."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <groupId> <artifactId> <version>"
    echo "Example: $0 org.apache.commons commons-lang3 3.12.0"
    exit 1
fi

# Input parameters
GROUP_ID=$1
ARTIFACT_ID=$2
VERSION=$3

# Target directory for downloaded JARs
TARGET_DIR="/opt/sparkplayground/jars"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Temporary directory for Ivy configuration
TEMP_DIR="/opt/sparkplayground/temp_ivy_project"
mkdir -p "$TEMP_DIR"

# Generate an Ivy configuration file
cat > "$TEMP_DIR/ivy.xml" <<EOL
<ivy-module version="2.0">
    <info organisation="temp" module="temp-project"/>
    <dependencies>
        <dependency org="$GROUP_ID" name="$ARTIFACT_ID" rev="$VERSION"/>
    </dependencies>
</ivy-module>
EOL

# Generate an Ivy settings file
cat > "$TEMP_DIR/ivysettings.xml" <<EOL
<ivysettings>
    <settings defaultResolver="central"/>
    <resolvers>
        <ibiblio name="central" m2compatible="true"/>
    </resolvers>
</ivysettings>
EOL

# Run Ivy to download the dependencies
java -jar /path/to/ivy.jar -settings "$TEMP_DIR/ivysettings.xml" -ivy "$TEMP_DIR/ivy.xml" -retrieve "$TARGET_DIR/[artifact]-[revision].[ext]"

# Clean up the temporary Ivy configuration
rm -rf "$TEMP_DIR"

echo "Dependencies downloaded to $TARGET_DIR"
