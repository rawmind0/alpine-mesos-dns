#!/usr/bin/env sh

MESOS_ZK=${MESOS_ZK:-zk://127.0.0.1:2181/mesos}
MESOS_MASTER=${MESOS_MASTER:-"\"127.0.0.1:5050\""}
MESOS_DNS_DOMAIN=${MESOS_DNS_DOMAIN:-"mesos"}
MESOS_DNS_NS=${MESOS_DNS_NS:-"ns1"}
MESOS_DNS_PORT=${MESOS_DNS_PORT:-"53"}
MESOS_DNS_HTTPPORT=${MESOS_DNS_HTTPPORT:-"8123"}
MESOS_DNS_RESOLVERS=${MESOS_DNS_RESOLVERS:-"\"8.8.8.8\""}
MESOS_DNS_DNSON=${MESOS_DNS_DNSON:-true}
MESOS_DNS_HTTPON=${MESOS_DNS_HTTPON:-true}
MESOS_DNS_EXTERNALON=${MESOS_DNS_EXTERNALON:-true}
MESOS_DNS_RECURSEON=${MESOS_DNS_RECURSEON:-true}
MESOS_DNS_LISTENER=${MESOS_DNS_LISTENER:-"0.0.0.0"}

cat << EOF > ${SERVICE_HOME}/etc/config.json
{
  "zk": "${MESOS_ZK}",
  "masters": [${MESOS_MASTER}],
  "stateTimeoutSeconds": 300,
  "refreshSeconds": 60,
  "ttl": 60,
  "domain": "${MESOS_DNS_DOMAIN}",
  "ns": "${MESOS_DNS_NS}",
  "port": ${MESOS_DNS_PORT},
  "resolvers": [${MESOS_DNS_RESOLVERS}],
  "timeout": 5,
  "listener": "${MESOS_DNS_LISTENER}",
  "SOAMname": "${MESOS_DNS_NS}.${MESOS_DNS_DOMAIN}",
  "SOARname": "root.${MESOS_DNS_NS}.${MESOS_DNS_DOMAIN}",
  "SOARefresh": 60,
  "SOARetry": 600,
  "SOAExpire": 86400,
  "SOAMinttl": 60,
  "dnson": ${MESOS_DNS_DNSON},
  "httpon": ${MESOS_DNS_HTTPON},
  "httpport": ${MESOS_DNS_HTTPPORT},
  "externalon": ${MESOS_DNS_EXTERNALON},
  "recurseon": ${MESOS_DNS_RECURSEON},
  "EnforceRFC952": false,
  "EnumerationOn": true
}
EOF
