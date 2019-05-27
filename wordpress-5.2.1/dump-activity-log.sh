#!/bin/bash

set -eu

: ${VCAP_APPLICATION:?required}
application_uri=$(echo "$VCAP_APPLICATION" | jq -r ".application_uris[0]")

: ${WP_ADMIN_USER:?required for $application_uri}
: ${WP_ADMIN_PASSWORD:?required for $application_uri}

echo "Login to https://${application_uri} as ${WP_ADMIN_USER}..."
curl -d "log=${WP_ADMIN_USER}&pwd=${WP_ADMIN_PASSWORD}&rememberme=forever" -c cookie.txt -k "https://wp.dev.cfdev.sh/wp-login.php"
echo "Start fetch of activity log..."
aal_actions_nonce=$(curl -sS --cookie cookie.txt -k "https://${application_uri}/wp-admin/admin.php?page=activity_log_page" | grep 'name="aal_actions_nonce" value="' | sed 's/.*name="aal_actions_nonce" value=[^"]*"\([^"]*\).*/\1/')

echo "Fetch log..."
curl --cookie cookie.txt -k "https://${application_uri}/wp-admin/admin.php?page=activity_log_page&s=&dateshow=&capshow=&usershow=&typeshow=&showaction=&paged=1&aal-record-action=csv&aal-record-actions-submit=1&aal_actions_nonce=${aal_actions_nonce}&_wp_http_referer=%2Fwp-admin%2Fadmin.php%3Fpage%3Dactivity_log_page" \
  -L -o activity-log.csv
