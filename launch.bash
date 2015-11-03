#!/bin/bash
set -o errexit

rm -f /opt/atlassian-home/.jira-home.lock
cd /opt/atlassian/jira

if [ "$CONTEXT_PATH" == "ROOT" -o -z "$CONTEXT_PATH" ]; then
  CONTEXT_PATH=
else
  CONTEXT_PATH="/$CONTEXT_PATH"
fi

xmlstarlet ed -u '//Context/@path' -v "$CONTEXT_PATH" conf/server-backup.xml > conf/server.xml

if [ -n "$CONNECTOR_PROXYNAME" ]; then
	xmlstarlet ed --inplace --delete "/Server/Service/Connector/@proxyName" conf/server.xml
	xmlstarlet ed --inplace --insert "/Server/Service/Connector" --type attr -n proxyName -v $CONNECTOR_PROXYNAME conf/server.xml
fi

if [ -n "$CONNECTOR_PROXYPORT" ]; then
	xmlstarlet ed --inplace --delete "/Server/Service/Connector/@proxyPort" conf/server.xml
	xmlstarlet ed --inplace --insert "/Server/Service/Connector" --type attr -n proxyPort -v $CONNECTOR_PROXYPORT conf/server.xml
fi

if [ -n "$CONNECTOR_SECURE" ]; then
	xmlstarlet ed --inplace --delete "/Server/Service/Connector/@secure" conf/server.xml
	xmlstarlet ed --inplace --insert "/Server/Service/Connector" --type attr -n secure -v $CONNECTOR_SECURE conf/server.xml
fi

if [ -n "$CONNECTOR_SCHEME" ]; then
	xmlstarlet ed --inplace --delete "/Server/Service/Connector/@scheme" conf/server.xml
	xmlstarlet ed --inplace --insert "/Server/Service/Connector" --type attr -n scheme -v $CONNECTOR_SCHEME conf/server.xml
fi

/opt/atlassian/jira/bin/start-jira.sh -fg
