# Run Wordpress on Cloud Foundry

## Deployment

```plain
cf create-service p-mysql 10mb wp-mysql-db
cf push --vars-file tmp/s3.yml
```

Where `tmp/s3.yml` contains your AWS S3 bucket/path/credentials:

```yaml
s3_uploads_bucket: <bucket-name>/<path-to-files>
s3_uploads_region: us-east-1
s3_uploads_key: <access-key>
s3_uploads_secret: <secret-key>
```

You can now visit your site, as the administrator you can now set it up - blog title, username and password, etc.

Now, restart the application and the S3 Uploads plugin will be activated:

```plain
cf restart wp
```
