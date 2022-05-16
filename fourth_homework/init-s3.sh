#! /usr/bin/env bash

aws s3 mb s3://yatsenko-3-bucket
aws s3api put-bucket-versioning --bucket yatsenko-3-bucket --versioning-configuration Status=Enabled
aws s3api put-object --bucket yatsenko-3-bucket --key rds-script.sql --body rds-script.sql
aws s3api put-object --bucket yatsenko-3-bucket --key dynamodb-script.sh --body dynamodb-script.sh