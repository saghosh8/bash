#!/bin/bash

# Replace with your actual values
GITHUB_REPO="https://github.com/your-org/your-repo.git"
ARTIFACTORY_URL="http://your-artifactory-server:port/artifactory"
ARTIFACTORY_USERNAME="your-username"
ARTIFACTORY_PASSWORD="your-password"
IMAGE_NAME="your-image-name"
IMAGE_TAG="latest"
OPENSHIFT_PROJECT="your-project"

# Clone the GitHub repository
git clone $GITHUB_REPO

# Authenticate to Artifactory
docker login $ARTIFACTORY_URL -u $ARTIFACTORY_USERNAME -p $ARTIFACTORY_PASSWORD

# Pull image from Artifactory
docker pull $ARTIFACTORY_URL/$IMAGE_NAME:$IMAGE_TAG

# Tag the image for OpenShift
docker tag $ARTIFACTORY_URL/$IMAGE_NAME:$IMAGE_TAG your-openshift-registry.com/$OPENSHIFT_PROJECT/$IMAGE_NAME:$IMAGE_TAG

# Push image to OpenShift registry
docker push your-openshift-registry.com/$OPENSHIFT_PROJECT/$IMAGE_NAME:$IMAGE_TAG

# Apply Kubernetes manifests
oc apply -f ./kubernetes_manifests