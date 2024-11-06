FILE="openapi-generator-cli.jar"
API_DIR="../frontend/src/app/backend"

if [ ! -f "$FILE" ]; then
    echo "$FILE not found. Downloading..."
    curl -o "$FILE" "https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.9.0/openapi-generator-cli-7.9.0.jar"
    echo "$FILE downloaded successfully."
else
    echo "$FILE already exists."
fi

if [ -d "$API_DIR" ]; then
    echo "Deleting contents of the 'api' directory..."
    rm -rf "$API_DIR"
    echo "Contents of 'api' directory deleted."
else
    echo "'api' directory does not exist. No need to delete contents."
fi

echo "Downloading API spec from http://localhost:8080/v3/api-docs..."
curl -o api-docs.json http://localhost:8080/v3/api-docs

echo "Generating Angular REST client..."
java -jar openapi-generator-cli.jar generate -i api-docs.json -g typescript-angular -o "$API_DIR" -c config.json --skip-validate-spec --enable-post-process-file

rm api-docs.json

echo "REST client generation complete! Client is available in $API_DIR"
