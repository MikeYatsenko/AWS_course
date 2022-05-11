#! /bin/bash
aws dynamodb list-tables --region us-east-1
aws dynamodb put-item --table-name "aws-employees" --item '{ "id": { "S": "1" }, "Job_Title": { "S": "Developer" } }' --region us-east-1
aws dynamodb put-item --table-name "aws-employees" --item '{ "id": { "S": "2" }, "Job_Title": { "S": "Developer" } }' --region us-east-1
aws dynamodb get-item --table-name "aws-employees" --key '{ "id": { "S": "1" }}' --region us-east-1
aws dynamodb get-item --table-name "aws-employees" --key '{ "id": { "S": "2" }' --region us-east-1