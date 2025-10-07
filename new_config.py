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
