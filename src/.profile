#!/bin/bash

if [[ "$CF_INSTANCE_INDEX" == "0" ]]; then
  # Sets up WP database; does nothing if already done.
  application_uri=$(echo "$VCAP_APPLICATION" | jq -r ".application_uris[0]")
  wp core install \
    --url="$application_uri" \
    --title="$WP_TITLE" \
    --admin_name="$WP_ADMIN_USER_EMAIL" \
    --admin_email="$WP_ADMIN_USER_EMAIL" \
    --admin_password="$WP_ADMIN_PASSWORD"

  wp plugin activate aryo-activity-log
  wp plugin activate s3-uploads
  wp s3-uploads verify
fi