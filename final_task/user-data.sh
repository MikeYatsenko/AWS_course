#! /bin/bash
sudo su
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm
sudo yum install -y jdk-8u141-linux-x64.rpm
aws s3api get-object --bucket testbucketformikeyatsenko21 --key calc-2021-0.0.1-SNAPSHOT.jar calc-2021-0.0.1-SNAPSHOT.jar
java -jar calc-2021-0.0.1-SNAPSHOT.jar