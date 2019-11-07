#!/usr/bin/env bash

set -x

curl -sSO "https://dl.google.com/cloudagents/install-logging-agent.sh"

sudo bash install-logging-agent.sh

rm install-logging-agent.sh
