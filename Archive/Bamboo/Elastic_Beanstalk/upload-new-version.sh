#!/bin/sh
application=bamboo
bucket=cakedisk-api
tag=$(date +%F+%s)-$(git rev-parse --short HEAD)
bundle=deployment.zip

zip -r /tmp/${bundle} .

aws s3 cp /tmp/${bundle} s3://${bucket}

aws elasticbeanstalk create-application-version \
    --application-name ${application} \
    --version-label ${tag}  \
    --source-bundle S3Bucket="${bucket}",S3Key="${bundle}" \
    --no-auto-create-application
