#!/bin/bash

# Stop on first error
set -e

# Function to display messages
echo_message() {
  echo "💪 GigaChatBot: $1"
}

echo_message "Starting the customization of your Open Web UI for AirlocAI!"

# 1. Replace Logo Files
echo_message "First, place your custom logo files in the 'static' directory:"
echo_message "  - AirlocAI/static/favicon.png"
echo_message "  - AirlocAI/static/favicon-dark.png"
echo_message "  - AirlocAI/static/splash.png"
echo_message "  - AirlocAI/static/logo.png"

# This part of the script will copy the files.
# Make sure you have an 'AirlocAI' directory with your images at the same level as your 'open-webui-airlocai' directory
cp ../AirlocAI/static/favicon.png static/
cp ../AirlocAI/static/favicon-dark.png static/
cp ../AirlocAI/static/splash.png static/
cp ../AirlocAI/static/logo.png static/

echo_message "Logo files have been updated."

# 2. Replace "Open Web UI" and "Open WebUI" with "AirlocAI"
echo_message "Replacing all instances of 'Open Web UI' and 'Open WebUI' with 'AirlocAI'..."
find . -type f \( -name "*.svelte" -o -name "*.ts" -o -name "*.html" -o -name "*.py" -o -name "*.md" -o -name "*.yaml" \) -print0 | xargs -0 sed -i 's/Open Web UI/AirlocAI/g'
find . -type f \( -name "*.svelte" -o -name "*.ts" -o -name "*.html" -o -name "*.py" -o -name "*.md" -o -name "*.yaml" \) -print0 | xargs -0 sed -i 's/Open WebUI/AirlocAI/g'

# 3. Fix the missing </div> tag in General.svelte
# echo_message "Fixing the missing </div> tag in src/lib/components/admin/Settings/General.svelte..."
# sed -i '/<div class="flex justify-end pt-3 text-sm font-medium">/i </div>' src/lib/components/admin/Settings/General.svelte


# 4. Remove sections from .svelte files

echo_message "Removing specified sections from .svelte files..."

# 4.1 General.svelte: Remove Version, Help, and License sections
sed -i '/<div class="mb-2.5">/{
    N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d
}' src/lib/components/chat/Settings/General.svelte


# 4.2 UserList.svelte: Remove "Hey there! 👋"
sed -i '/{#if !\$config?.license_metadata}/{
    N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d
}' src/lib/components/admin/Users/UserList.svelte


# 4.3 settingModal.svelte: Remove "About" tab
sed -i "/{:else if tabId === 'about'}/{
    N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d
}" src/lib/components/chat/SettingsModal.svelte

# 4.4 General.svelte: Remove commented-out themes
sed -i '/<option value="her">🌷 Her<\/option>/{
    N;N;d
}' src/lib/components/chat/Settings/General.svelte

# 4.5 UserMenu.svelte: Remove "Documentation" and change "Releases"
# sed -i '/<DropdownMenu.Item/{
#     N;N;N;N;N;N;N;N;N;N;N;N;d
# }' src/lib/components/layout/Sidebar/UserMenu.svelte

sed -i "s|href=\"https://github.com/open-webui/open-webui/releases\"|href=\"https://AirlocAI.com\"|g" src/lib/components/layout/Sidebar/UserMenu.svelte
sed -i "s|{\$i18n.t('Releases')}|{\$i18n.t('AirlocAI')}|g" src/lib/components/layout/Sidebar/UserMenu.svelte
sed -i "s|<Rocket className=\"size-5\" />|<Map className=\"size-5\" />|g" src/lib/components/layout/Sidebar/UserMenu.svelte

# 5. Update Default Configuration and Model Parameters

echo_message "Updating default configuration and advanced model parameters..."

# 5.1 Create a temporary file for the new DEFAULT_CONFIG
cat << 'EOF' > new_config.py
DEFAULT_CONFIG = {
    "version": 0,
    "ui": {
        "enable_signup": False
    },
    "rag": {
        "embedding_engine": "",
        "embedding_model": "sentence-transformers/all-MiniLM-L6-v2",
        "template": "### Task:\nRespond to the user query using the provided context, incorporating inline citations in the format [id] **only when the <source> tag includes an explicit id attribute** (e.g., <source id=\"1\">).\n\n### Guidelines:\n- If you don't know the answer, clearly state that.\n- If uncertain, ask the user for clarification.\n- Respond in the same language as the user's query.\n- If the context is unreadable or of poor quality, inform the user and provide the best possible answer.\n- If the answer isn't present in the context but you possess the knowledge, explain this to the user and provide the answer using your own understanding.\n- **Only include inline citations using [id] (e.g., [1], [2]) when the <source> tag includes an id attribute.**\n- Do not cite if the <source> tag does not contain an id attribute.\n- Do not use XML tags in your response.\n- Ensure citations are concise and directly related to the information provided.\n\n### Example of Citation:\nIf the user asks about a specific topic and the information is found in a source with a provided id attribute, the response should include the citation like in the following example:\n* \"According to the study, the proposed method increases efficiency by 20% [1].\"\n\n### Output:\nProvide a clear and direct response to the user's query, including inline citations in the format [id] only when the <source> tag with id attribute is present in the context.\n\n<context>\n{{CONTEXT}}\n</context>\n\n<user_query>\n{{QUERY}}\n</user_query>\n",
        "top_k": 3,
        "bypass_embedding_and_retrieval": False,
        "full_context": False,
        "enable_hybrid_search": True,
        "top_k_reranker": 3,
        "relevance_threshold": 0,
        "hybrid_bm25_weight": 0.5,
        "CONTENT_EXTRACTION_ENGINE": "",
        "pdf_extract_images": True,
        "datalab_marker_api_key": "",
        "datalab_marker_api_base_url": "",
        "datalab_marker_additional_config": "",
        "datalab_marker_skip_cache": False,
        "datalab_marker_force_ocr": False,
        "datalab_marker_paginate": False,
        "datalab_marker_strip_existing_ocr": False,
        "datalab_marker_disable_image_extraction": False,
        "datalab_marker_format_lines": False,
        "datalab_marker_output_format": "markdown",
        "DATALAB_MARKER_USE_LLM": False,
        "external_document_loader_url": "",
        "external_document_loader_api_key": "",
        "tika_server_url": "http://tika:9998",
        "docling_server_url": "http://docling:5001",
        "docling_do_ocr": True,
        "docling_force_ocr": False,
        "docling_ocr_engine": "tesseract",
        "docling_ocr_lang": "eng,fra,deu,spa",
        "docling_pdf_backend": "dlparse_v4",
        "docling_table_mode": "accurate",
        "docling_pipeline": "standard",
        "docling_do_picture_description": False,
        "docling_picture_description_mode": "",
        "docling_picture_description_local": {},
        "docling_picture_description_api": {},
        "document_intelligence_endpoint": "",
        "document_intelligence_key": "",
        "mistral_ocr_api_key": "",
        "reranking_engine": "",
        "external_reranker_url": "",
        "external_reranker_api_key": "",
        "reranking_model": "",
        "text_splitter": "",
        "chunk_size": 1000,
        "chunk_overlap": 100,
        "file": {
            "max_size": None,
            "max_count": None,
            "allowed_extensions": []
        },
        "web": {
            "search": {
                "enable": True,
                "engine": "duckduckgo",
                "trust_env": False,
                "result_count": 3,
                "concurrent_requests": 10,
                "domain": {
                    "filter_list": []
                },
                "bypass_embedding_and_retrieval": False,
                "bypass_web_loader": False,
                "ollama_cloud_api_key": "",
                "searxng_query_url": "",
                "yacy_query_url": "",
                "yacy_username": "",
                "yacy_password": "",
                "google_pse_api_key": "",
                "google_pse_engine_id": "",
                "brave_search_api_key": "",
                "kagi_search_api_key": "",
                "mojeek_search_api_key": "",
                "bocha_search_api_key": "",
                "serpstack_api_key": "",
                "serpstack_https": True,
                "serper_api_key": "",
                "serply_api_key": "",
                "tavily_api_key": "",
                "searchapi_api_key": "",
                "searchapi_engine": "",
                "serpapi_api_key": "",
                "serpapi_engine": "",
                "jina_api_key": "",
                "bing_search_v7_endpoint": "https://api.bing.microsoft.com/v7.0/search",
                "bing_search_v7_subscription_key": "",
                "exa_api_key": "",
                "perplexity_api_key": "",
                "perplexity_model": "sonar",
                "perplexity_search_context_usage": "medium",
                "sougou_api_sid": "",
                "sougou_api_sk": "",
                "external_web_search_url": "",
                "external_web_search_api_key": "",
                "tavily_extract_depth": "basic"
            },
            "loader": {
                "concurrent_requests": 10,
                "engine": "",
                "ssl_verification": True,
                "playwright_ws_url": "",
                "playwright_timeout": 10000,
                "firecrawl_api_key": "",
                "firecrawl_api_url": "https://api.firecrawl.dev",
                "external_web_loader_url": "",
                "external_web_loader_api_key": ""
            }
        },
        "youtube_loader_language": [
            "en"
        ],
        "youtube_loader_proxy_url": ""
    },
    "file": {
        "image_compression_width": None,
        "image_compression_height": None
    },
    "google_drive": {
        "enable": False
    },
    "onedrive": {
        "enable": False
    },
    "image_generation": {
        "engine": "openai",
        "enable": False,
        "prompt": {
            "enable": True
        },
        "openai": {
            "api_base_url": "https://api.openai.com/v1",
            "api_version": "",
            "api_key": ""
        },
        "gemini": {
            "api_base_url": "",
            "api_key": ""
        },
        "automatic1111": {
            "base_url": "",
            "api_auth": "",
            "cfg_scale": None,
            "sampler": None,
            "scheduler": None
        },
        "comfyui": {
            "base_url": "",
            "api_key": "",
            "workflow": "{\n  \"3\": {\n    \"inputs\": {\n      \"seed\": 0,\n      \"steps\": 20,\n      \"cfg\": 8,\n      \"sampler_name\": \"euler\",\n      \"scheduler\": \"normal\",\n      \"denoise\": 1,\n      \"model\": [\n        \"4\",\n        0\n      ],\n      \"positive\": [\n        \"6\",\n        0\n      ],\n      \"negative\": [\n        \"7\",\n        0\n      ],\n      \"latent_image\": [\n        \"5\",\n        0\n      ]\n    },\n    \"class_type\": \"KSampler\",\n    \"_meta\": {\n      \"title\": \"KSampler\"\n    }\n  },\n  \"4\": {\n    \"inputs\": {\n      \"ckpt_name\": \"model.safetensors\"\n    },\n    \"class_type\": \"CheckpointLoaderSimple\",\n    \"_meta\": {\n      \"title\": \"Load Checkpoint\"\n    }\n  },\n  \"5\": {\n    \"inputs\": {\n      \"width\": 512,\n      \"height\": 512,\n      \"batch_size\": 1\n    },\n    \"class_type\": \"EmptyLatentImage\",\n    \"_meta\": {\n      \"title\": \"Empty Latent Image\"\n    }\n  },\n  \"6\": {\n    \"inputs\": {\n      \"text\": \"Prompt\",\n      \"clip\": [\n        \"4\",\n        1\n      ]\n    },\n    \"class_type\": \"CLIPTextEncode\",\n    \"_meta\": {\n      \"title\": \"CLIP Text Encode (Prompt)\"\n    }\n  },\n  \"7\": {\n    \"inputs\": {\n      \"text\": \"\",\n      \"clip\": [\n        \"4\",\n        1\n      ]\n    },\n    \"class_type\": \"CLIPTextEncode\",\n    \"_meta\": {\n      \"title\": \"CLIP Text Encode (Prompt)\"\n    }\n  },\n  \"8\": {\n    \"inputs\": {\n      \"samples\": [\n        \"3\",\n        0\n      ],\n      \"vae\": [\n        \"4\",\n        2\n      ]\n    },\n    \"class_type\": \"VAEDecode\",\n    \"_meta\": {\n      \"title\": \"VAE Decode\"\n    }\n  },\n  \"9\": {\n    \"inputs\": {\n      \"filename_prefix\": \"ComfyUI\",\n      \"images\": [\n        \"8\",\n        0\n      ]\n    },\n    \"class_type\": \"SaveImage\",\n    \"_meta\": {\n      \"title\": \"Save Image\"\n    }\n  }\n}",
            "nodes": []
        }
    }
}
EOF

# 5.2 Replace DEFAULT_CONFIG in config.py
# Use awk for a more reliable replacement of the multi-line block
awk '
  BEGIN {
    # Read the new config into a variable
    while ((getline line < "new_config.py") > 0) {
      new_config = new_config line "\n"
    }
    close("new_config.py")
    sub(/\n$/, "", new_config) # Remove trailing newline
  }
  
  # Find the start of the DEFAULT_CONFIG block
  /^DEFAULT_CONFIG = \{/ {
    print new_config
    in_block=1
    brace_count=1
    next
  }

  # If inside the block, count braces to find the end
  in_block {
    # Process the line to count braces
    for (i=1; i<=length($0); i++) {
      char = substr($0, i, 1)
      if (char == "{") brace_count++
      if (char == "}") brace_count--
    }
    
    # If brace_count is zero, we found the end of the block
    if (brace_count == 0) {
      in_block=0
    }
    next
  }
  
  # Print lines outside the block
  !in_block {
    print
  }
' backend/open_webui/config.py > tmp_config.py && mv tmp_config.py backend/open_webui/config.py

rm new_config.py

# 5.3 Set default advanced model parameters
# Using a temp file and sed to insert the text after the class definition
MODEL_PARAMS_FILE="model_params.txt"
cat << 'EOF' > ${MODEL_PARAMS_FILE}
    params: dict = {
        "stream_response": True,
        "stream_delta_chunk_size": 5,
        "max_tokens": 45000,
        "num_thread": 8,
        "num_gpu": 10,
        "num_batch": 1024,
        "num_ctx": 60000,
        "reasoning_effort": "high"
    }
EOF

# Use awk to insert the model parameters after the class definition
awk '
  /class ModelForm\(ModelModel\):/ {
    print
    while ((getline line < "model_params.txt") > 0) print line
    close("model_params.txt")
    next
  }
  { print }
' backend/open_webui/models/models.py > tmp_models.py && mv tmp_models.py backend/open_webui/models/models.py
rm ${MODEL_PARAMS_FILE}


# 6. Authentication Setup
echo_message "Configuring authentication method..."

# Create or clear the .env file
ENV_FILE=".env"
> "${ENV_FILE}"
echo_message "Created a fresh .env file."

echo "Select your authentication method:"
echo "  1) Standard email and password"
echo "  2) Google (OAuth)"
echo "  3) Microsoft Azure AD (OAuth)"
echo "  4) Okta / Generic OIDC (OAuth)"
echo "  5) Active Directory (LDAP)"

read -p "Enter your choice [1-5]: " auth_choice

case ${auth_choice} in
  1)
    echo_message "Setting up standard password authentication."
    echo "ENABLE_OAUTH_SIGNUP=False" >> "${ENV_FILE}"
    echo "ENABLE_LDAP=False" >> "${ENV_FILE}"
    ;;
  2)
    echo_message "Setting up Google OAuth."
    echo "ENABLE_OAUTH_SIGNUP=True" >> "${ENV_FILE}"
    read -p "Enter your Google Client ID: " GOOGLE_CLIENT_ID
    read -p "Enter your Google Client Secret: " GOOGLE_CLIENT_SECRET
    read -p "Enter your Google Redirect URI (e.g., http://localhost:3000/api/v1/auths/sso/callback/google): " GOOGLE_REDIRECT_URI
    read -p "Enter allowed domains for signup (comma-separated, e.g., company.com,another.com): " OAUTH_ALLOWED_DOMAINS

    echo "GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}" >> "${ENV_FILE}"
    echo "GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}" >> "${ENV_FILE}"
    echo "GOOGLE_REDIRECT_URI=${GOOGLE_REDIRECT_URI}" >> "${ENV_FILE}"
    echo "OAUTH_ALLOWED_DOMAINS=${OAUTH_ALLOWED_DOMAINS}" >> "${ENV_FILE}"
    ;;
  3)
    echo_message "Setting up Microsoft Azure AD OAuth."
    echo "ENABLE_OAUTH_SIGNUP=True" >> "${ENV_FILE}"
    read -p "Enter your Microsoft Client ID: " MICROSOFT_CLIENT_ID
    read -p "Enter your Microsoft Client Secret: " MICROSOFT_CLIENT_SECRET
    read -p "Enter your Microsoft Tenant ID: " MICROSOFT_CLIENT_TENANT_ID
    read -p "Enter your Microsoft Redirect URI (e.g., http://localhost:3000/api/v1/auths/sso/callback/microsoft): " MICROSOFT_REDIRECT_URI
    read -p "Enter allowed domains for signup (comma-separated): " OAUTH_ALLOWED_DOMAINS

    echo "MICROSOFT_CLIENT_ID=${MICROSOFT_CLIENT_ID}" >> "${ENV_FILE}"
    echo "MICROSOFT_CLIENT_SECRET=${MICROSOFT_CLIENT_SECRET}" >> "${ENV_FILE}"
    echo "MICROSOFT_CLIENT_TENANT_ID=${MICROSOFT_CLIENT_TENANT_ID}" >> "${ENV_FILE}"
    echo "MICROSOFT_REDIRECT_URI=${MICROSOFT_REDIRECT_URI}" >> "${ENV_FILE}"
    echo "OAUTH_ALLOWED_DOMAINS=${OAUTH_ALLOWED_DOMAINS}" >> "${ENV_FILE}"
    ;;
  4)
    echo_message "Setting up Generic OIDC (e.g., Okta)."
    echo "ENABLE_OAUTH_SIGNUP=True" >> "${ENV_FILE}"
    read -p "Enter the provider name for the login button (e.g., Okta): " OAUTH_PROVIDER_NAME
    read -p "Enter your OIDC Provider URL (discovery URL): " OPENID_PROVIDER_URL
    read -p "Enter your OIDC Client ID: " OAUTH_CLIENT_ID
    read -p "Enter your OIDC Client Secret: " OAUTH_CLIENT_SECRET
    read -p "Enter your OIDC Redirect URI (e.g., http://localhost:3000/api/v1/auths/sso/callback/oidc): " OPENID_REDIRECT_URI
    read -p "Enter allowed domains for signup (comma-separated): " OAUTH_ALLOWED_DOMAINS

    echo "OAUTH_PROVIDER_NAME=${OAUTH_PROVIDER_NAME}" >> "${ENV_FILE}"
    echo "OPENID_PROVIDER_URL=${OPENID_PROVIDER_URL}" >> "${ENV_FILE}"
    echo "OAUTH_CLIENT_ID=${OAUTH_CLIENT_ID}" >> "${ENV_FILE}"
    echo "OAUTH_CLIENT_SECRET=${OAUTH_CLIENT_SECRET}" >> "${ENV_FILE}"
    echo "OPENID_REDIRECT_URI=${OPENID_REDIRECT_URI}" >> "${ENV_FILE}"
    echo "OAUTH_ALLOWED_DOMAINS=${OAUTH_ALLOWED_DOMAINS}" >> "${ENV_FILE}"
    ;;
  5)
    echo_message "Setting up LDAP for Active Directory."
    echo "ENABLE_LDAP=True" >> "${ENV_FILE}"
    read -p "Enter LDAP Server Host: " LDAP_SERVER_HOST
    read -p "Enter LDAP Server Port [389]: " LDAP_SERVER_PORT
    LDAP_SERVER_PORT=${LDAP_SERVER_PORT:-389}
    read -p "Use TLS? (True/False) [True]: " LDAP_USE_TLS
    LDAP_USE_TLS=${LDAP_USE_TLS:-True}
    read -p "Enter LDAP App DN (service account): " LDAP_APP_DN
    read -s -p "Enter LDAP App Password: " LDAP_APP_PASSWORD
    echo
    read -p "Enter LDAP Search Base (e.g., ou=users,dc=company,dc=com): " LDAP_SEARCH_BASE
    
    echo "LDAP_SERVER_HOST=${LDAP_SERVER_HOST}" >> "${ENV_FILE}"
    echo "LDAP_SERVER_PORT=${LDAP_SERVER_PORT}" >> "${ENV_FILE}"
    echo "LDAP_USE_TLS=${LDAP_USE_TLS}" >> "${ENV_FILE}"
    echo "LDAP_APP_DN=${LDAP_APP_DN}" >> "${ENV_FILE}"
    echo "LDAP_APP_PASSWORD=${LDAP_APP_PASSWORD}" >> "${ENV_FILE}"
    echo "LDAP_SEARCH_BASE=${LDAP_SEARCH_BASE}" >> "${ENV_FILE}"
    ;;
  *)
    echo_message "Invalid choice. Skipping authentication setup."
    ;;
esac

echo_message "Authentication setup complete."
echo_message "Customization complete! Now, build and conquer."