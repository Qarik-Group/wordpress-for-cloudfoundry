# Run Wordpress on Cloud Foundry

## Deployment

```plain
cf create-service p-mysql 10mb wp-mysql-db
cf push --vars-file tmp/config.yml
```

Where `tmp/config.yml` contains your AWS S3 bucket/path/credentials:

```yaml
s3_uploads_bucket: <bucket-name>/<path-to-files>
s3_uploads_region: us-east-1
s3_uploads_key: <access-key>
s3_uploads_secret: <secret-key>
wp_title: "Stark & Wayne"
wp_admin_user_email: drnic@starkandwayne.com
wp_admin_password: <some-secure-password>
```

The blog will be setup with the initial title, and administrator user/email. The S3 credentials will also be tested. You can see this setup via the logs:

```plain
$ cf logs wp --recent
[APP/PROC/WEB/0] OUT Success: WordPress installed successfully.
[APP/PROC/WEB/0] OUT Plugin 'aryo-activity-log' activated.
[APP/PROC/WEB/0] OUT Success: Activated 1 of 1 plugins.
[APP/PROC/WEB/0] OUT Plugin 's3-uploads' activated.
[APP/PROC/WEB/0] OUT Success: Activated 1 of 1 plugins.
[APP/PROC/WEB/0] OUT Attempting to upload file s3://testing-boshrelease/wp-dev-cfdev-sh/uploads/81533647.jpg
[APP/PROC/WEB/0] OUT File uploaded to S3 successfully.
[APP/PROC/WEB/0] OUT Attempting to delete file. s3://testing-boshrelease/wp-dev-cfdev-sh/uploads/81533647.jpg
[APP/PROC/WEB/0] OUT File deleted from S3 successfully.
```