#!/bin/bash

# Variables
GIT_REPO="https://github.com/your-username/your-repo.git"
BRANCH="main"
BUILD_DIR="/path/to/build"
ARTIFACTORY_URL="https://your-artifactory-url/artifactory"
ARTIFACTORY_REPO="your-repo"
ARTIFACTORY_USER="your-username"
ARTIFACTORY_PASSWORD="your-password"
ARTIFACT_NAME="your-artifact"
VERSION="1.0.0"
JAR_FILE="$BUILD_DIR/target/$ARTIFACT_NAME-$VERSION.jar"
DOCKER_IMAGE="your-docker-repo/your-image-name"
DOCKER_TAG="$VERSION"
DOCKER_REGISTRY="your-docker-registry"
SONAR_PROJECT_KEY="your-project-key"
SONAR_HOST_URL="https://your-sonarqube-server"
SONAR_LOGIN="your-sonar-token"

# Clean up previous build
rm -rf $BUILD_DIR

# Clone the Git repository
git clone -b $BRANCH $GIT_REPO $BUILD_DIR

# Change to build directory
cd $BUILD_DIR

# Run tests with Maven and generate coverage reports
mvn clean verify

# Verify the tests passed
if [ $? -ne 0 ]; then
  echo "Maven tests failed."
  exit 1
fi

# Run SonarQube analysis
mvn sonar:sonar \
  -Dsonar.projectKey=$SONAR_PROJECT_KEY \
  -Dsonar.host.url=$SONAR_HOST_URL \
  -Dsonar.login=$SONAR_LOGIN

# Verify SonarQube analysis success
if [ $? -ne 0 ]; then
  echo "SonarQube analysis failed."
  exit 1
fi

# Check the quality gate status
QUALITY_GATE_STATUS=$(curl -s -u $SONAR_LOGIN: "$SONAR_HOST_URL/api/qualitygates/project_status?projectKey=$SONAR_PROJECT_KEY" | jq -r '.projectStatus.status')

if [ "$QUALITY_GATE_STATUS" != "OK" ]; then
  echo "Quality gate failed."
  exit 1
fi

# Build the project with Maven
mvn package

# Verify the JAR file exists
if [ ! -f $JAR_FILE ]; then
  echo "JAR file not found: $JAR_FILE"
  exit 1
fi

# Upload the JAR file to Artifactory
curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD -T $JAR_FILE "$ARTIFACTORY_URL/$ARTIFACTORY_REPO/$ARTIFACT_NAME/$VERSION/$ARTIFACT_NAME-$VERSION.jar"

# Verify upload success
if [ $? -eq 0 ]; then
  echo "JAR file successfully uploaded to Artifactory."
else
  echo "Failed to upload JAR file to Artifactory."
  exit 1
fi

# Build Docker image
docker build -t $DOCKER_IMAGE:$DOCKER_TAG .

# Log in to Docker registry
echo $ARTIFACTORY_PASSWORD | docker login $DOCKER_REGISTRY -u $ARTIFACTORY_USER --password-stdin

# Push Docker image to registry
docker push $DOCKER_IMAGE:$DOCKER_TAG

# Verify push success
if [ $? -eq 0 ]; then
  echo "Docker image successfully pushed to registry."
else
  echo "Failed to push Docker image to registry."
  exit 1
fi

echo "CI build and deployment completed successfully."
