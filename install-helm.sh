#!/bin/bash

# Define variables
HELM_RELEASE_NAME="my-ingress"
NAMESPACE="ingress-nginx"
CHART_NAME="ingress-nginx/ingress-nginx"
TARGET_DIR="./k8s/nginx"
MANIFEST_FILE="ingress-nginx.yaml"

# Function to print error and exit
function handle_error {
    echo "[ERROR] $1"
    exit 1
}

# Step 1: Check if Helm is installed
command -v helm >/dev/null 2>&1 || handle_error "Helm is not installed. Please install Helm first."

# Step 2: Check if kubectl is installed
command -v kubectl >/dev/null 2>&1 || handle_error "kubectl is not installed. Please install kubectl first."

# Step 3: Create the target directory if it does not exist
echo "Checking if the target directory exists..."
if [ ! -d "$TARGET_DIR" ]; then
    echo "Directory does not exist. Creating ${TARGET_DIR}..."
    mkdir -p ${TARGET_DIR} || handle_error "Failed to create the target directory ${TARGET_DIR}."
else
    echo "Directory ${TARGET_DIR} already exists."
fi

# Step 4: Download the Helm chart manifest to the specified directory
echo "Downloading the Helm chart manifest for ${HELM_RELEASE_NAME} from ${CHART_NAME}..."
if ! helm template ${HELM_RELEASE_NAME} ${CHART_NAME} --namespace ${NAMESPACE} > ${TARGET_DIR}/${MANIFEST_FILE}; then
    handle_error "Failed to generate Helm manifest. Please check the Helm chart name and parameters."
fi

echo "Manifest successfully downloaded to ${TARGET_DIR}/${MANIFEST_FILE}"

# Step 5: Check if the manifest file was created successfully
if [ ! -f "${TARGET_DIR}/${MANIFEST_FILE}" ]; then
    handle_error "Manifest file ${TARGET_DIR}/${MANIFEST_FILE} not found after download."
fi

echo "Manifest file exists: ${TARGET_DIR}/${MANIFEST_FILE}"
echo "Script execution completed successfully."
