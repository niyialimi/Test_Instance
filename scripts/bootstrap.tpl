#!/bin/bash

yum update -y

#install datadog agent
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${DATA_DOG_API_KEY} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

#Start SSM Agent
sudo systemctl start amazon-ssm-agent
