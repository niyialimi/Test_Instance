#!/bin/bash

yum update -y

#install datadog agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${Datadog_API_Key} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

#Install SSM
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

sudo systemctl status amazon-ssm-agent

