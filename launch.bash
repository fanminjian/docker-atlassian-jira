#!/bin/bash
set -o errexit


sudo own-volume
rm -f /opt/atlassian-home/.jira-home.lock

/opt/atlassian/jira/bin/start-jira.sh -fg
