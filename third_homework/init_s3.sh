#! /usr/bin/env bash
touch sample.txt
echo "Some text" > sample.txt
aws s3 mb s3://testbucketformikeyatsenko21
aws s3api put-bucket-versioning --bucket testbucketformikeyatsenko21 --versioning-configuration Status=Enabled
aws s3 cp sample.txt s3://testbucketformikeyatsenko21/sample.txt