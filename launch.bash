#!/bin/bash
set -o errexit

rm -f /opt/atlassian-home/.jira-home.lock

/opt/atlassian/jira/bin/start-jira.sh -fg
