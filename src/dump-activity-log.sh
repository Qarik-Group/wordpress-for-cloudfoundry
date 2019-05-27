#!/bin/bash

echo "Login to https://wp.dev.cfdev.sh as drnicwilliams@gmail.com..."
curl -d "log=drnicwilliams@gmail.com&pwd=ncWXUWvziw3Binq8&rememberme=forever" -c cookie.txt -k "https://wp.dev.cfdev.sh/wp-login.php"
echo "Start fetch of activity log..."
aal_actions_nonce=$(curl -sS --cookie cookie.txt -k "https://wp.dev.cfdev.sh/wp-admin/admin.php?page=activity_log_page" | grep 'name="aal_actions_nonce" value="' | sed 's/.*name="aal_actions_nonce" value=[^"]*"\([^"]*\).*/\1/')

echo "Fetch log..."
curl --cookie cookie.txt -k "https://wp.dev.cfdev.sh/wp-admin/admin.php?page=activity_log_page&s=&dateshow=&capshow=&usershow=&typeshow=&showaction=&paged=1&aal-record-action=csv&aal-record-actions-submit=1&aal_actions_nonce=${aal_actions_nonce}&_wp_http_referer=%2Fwp-admin%2Fadmin.php%3Fpage%3Dactivity_log_page" \
  -v -L -o output.csv
