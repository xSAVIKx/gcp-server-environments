#!/usr/bin/env bash

set -x

curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh

sudo bash install-monitoring-agent.sh

rm install-monitoring-agent.sh
