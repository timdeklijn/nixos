#!/usr/bin/env fish

# --- Aider + APIM Setup Script (setup_aider_apim.fish) ---

# --- Configuration ---
# ⚠️ REQUIRED: Replace with the App ID URI of the Entra ID Application Registration
# that your APIM policy is configured to validate.
set -l APIM_RESOURCE_SCOPE "https://management.azure.com/"
# set -l APIM_RESOURCE_SCOPE "api://YOUR_APIM_FRONTEND_APP_ID"

# ⚠️ REQUIRED: Replace with the actual name of your model deployment in Azure OpenAI.
set -l AZURE_DEPLOYMENT_NAME "gpt-5"

# --- Environment Variables ---
# Base URL for the APIM Gateway (matches base_url in your Aider config)
set -gx AZURE_API_BASE "https://apim.datalab-01.azure.grid.rws.nl"

# API Version (matches query_params in your Aider config)
set -gx AZURE_API_VERSION "2025-01-01-preview"

# Placeholder Key (Aider requires this variable to be set)
set -gx AZURE_API_KEY "DUMMY_KEY_FOR_APIM_AUTH"

# --- Token Generation ---
function fetch_apim_token
    echo "🔑 Checking Azure login status..."
    if not command -q az
        echo "Error: Azure CLI ('az') is not installed or not in PATH."
        return 1
    end

    # Check if a login session exists (avoids opening browser unnecessarily)
    if not az account show > /dev/null 2>&1
        echo "Authentication required. Launching Azure login..."
        az login
    end

    echo "Fetching Entra ID access token for resource: $APIM_RESOURCE_SCOPE"

    # Fetch the token scoped to the APIM application audience
    set -l token (az account get-access-token --resource $APIM_RESOURCE_SCOPE --query accessToken -o tsv 2>/dev/null)

    if test $status -ne 0 -o -z "$token"
        echo "Error: Could not fetch access token. Check your --resource scope or try 'az login' again."
        return 1
    end

    # Set the custom AUTHORIZATION environment variable used by the Aider config
    set -gx AUTHORIZATION "Bearer $token"
    echo "✅ Access token successfully set for AUTHORIZATION header."
end

# --- Aider Launch Function ---
function start_aider_apim
    # Call the token function first
    fetch_apim_token
    if test $status -ne 0
        echo "Aborting Aider launch due to token error."
        return 1
    end

    echo "🚀 Starting Aider with model: azure/$AZURE_DEPLOYMENT_NAME"
    # Aider needs to be installed in your environment
    aider --model azure/$AZURE_DEPLOYMENT_NAME $argv
end

# --- Execution ---
echo "--- Aider + APIM Setup Loaded ---"
echo "Use 'start_aider_apim' to launch Aider."

# Note: You typically load this script into your fish config,
# but calling the token fetch directly here is not needed since the function does it.
# The user will explicitly call 'start_aider_apim'.
