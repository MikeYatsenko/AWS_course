#! /usr/bin/env bash
touch sample.txt
echo "Some text" > sample.txt
aws s3 mb s3://testbucketformikeyatsenko
aws s3api put-bucket-versioning --bucket testbucketformikeyatsenko --versioning-configuration Status=Enabled
aws s3 cp sample.txt s3://testbucketformikeyatsenko/sample.txt