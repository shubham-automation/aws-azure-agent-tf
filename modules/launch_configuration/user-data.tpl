#!/bin/bash

yum install docker -y
systemctl start docker
AGENT_1=azure-agent-1
AGENT_2=azure-agent-2
echo "==== Starting Agent 1 ===="
docker run -d --name=$AGENT_1 --restart always -e WHERE=${cloud} -e ${cloud}=TRUE -e ENV=${environment} -e ROLE=${role} -e AZP_AGENT_NAME=${cloud}-${environment}-$RANDOM -e AZP_TOKEN=${pat} -e AZP_URL=${ado_url} -e AZP_POOL=${pool_name} -v /var/run/docker.sock:/var/run/docker.sock emberstack/azure-pipelines-agent
echo "==== Starting Agent 2 ===="
docker run -d --name=$AGENT_2 --restart always -e WHERE=${cloud} -e ${cloud}=TRUE -e ENV=${environment} -e ROLE=${role} -e AZP_AGENT_NAME=${cloud}-${environment}-$RANDOM -e AZP_TOKEN=${pat} -e AZP_URL=${ado_url} -e AZP_POOL=${pool_name} -v /var/run/docker.sock:/var/run/docker.sock emberstack/azure-pipelines-agent
echo "==== Report: Containers Running ===="
docker ps -a --format "{{.Names}} - OK"