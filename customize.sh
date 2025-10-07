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
    N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d
}' src/lib/components/admin/Users/UserList.svelte


# 4.3 settingModal.svelte: Remove "About" tab
sed -i '/{:else if tabId === '"'about'"'}/{
    N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d
}' src/lib/components/chat/SettingsModal.svelte

# 4.4 General.svelte: Remove commented-out themes
sed -i '/<option value="her">🌷 Her<\/option>/{
    N;N;d
}' src/lib/components/chat/Settings/General.svelte

# 4.5 UserMenu.svelte: Remove "Documentation" and change "Releases"
# sed -i '/<DropdownMenu.Item/{
#     N;N;N;N;N;N;N;N;N;N;N;N;d
# }' src/lib/components/layout/Sidebar/UserMenu.svelte

sed -i "s|href=\"https://github.com/open-webui/open-webui/releases\"|href=\"https://AirlocAI.com\"|g" src/lib/components/layout/Sidebar/UserMenu.svelte
sed -i "s|{$i18n.t('Releases')}|{$i18n.t('AirlocAI')}|g" src/lib/components/layout/Sidebar/UserMenu.svelte
sed -i "s|<Rocket className=\"size-5\" />|<Map className=\"size-5\" />|g" src/lib/components/layout/Sidebar/UserMenu.svelte


echo_message "Customization complete! Now, build and conquer."