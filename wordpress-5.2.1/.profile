#!/bin/bash

if [[ ! -f wp-cli.phar ]]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
fi
function wp() {
  php wp-cli.phar --path=$HOME/htdocs "$@"
}

wp plugin activate aryo-activity-log
wp plugin activate s3-uploads
wp s3-uploads verify