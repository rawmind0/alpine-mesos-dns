#!/usr/bin/env bash

function log {
        echo `date` $ME - $@
}

function serviceLog {
    log "[ Redirecting ${SERVICE_NAME} log... ]"
    if [ -e ${SERVICE_HOME}/nohup.out ]; then
        rm ${SERVICE_HOME}/nohup.out
    fi
    ln -sf /proc/1/fd/1 ${SERVICE_HOME}/nohup.out
}

function serviceLinkLocal {
    if [ -n ${LINK_LOCAL_IP} ]; then
        log "[ Configuring link local ip ${LINK_LOCAL_IP}... ]"
        rc=$(ip addr s eth0| grep -w 'inet' | awk '{print $2}' | cut -f1  -d'/' | grep ${LINK_LOCAL_IP} > /dev/null; echo $?)
        if [ "$rc" -ne "0" ]: then
            ip addr add ${LINK_LOCAL_IP}/32 dev eth0
        fi
    fi
}

function serviceCheck {
    log "[ Generating ${SERVICE_NAME} configuration... ]"
    ${SERVICE_HOME}/bin/config.json.sh
}

function serviceStart {
    serviceLinkLocal
    serviceCheck
    serviceLog
    log "[ Starting ${SERVICE_NAME}... ]"
    nohup ${SERVICE_HOME}/bin/mesos-dns -config ${SERVICE_HOME}/etc/config.json &
    echo $! > ${SERVICE_HOME}/mesos-dns.pid
}

function serviceStop {
    log "[ Stoping ${SERVICE_NAME}... ]"
    kill `cat ${SERVICE_HOME}/mesos-dns.pid`
}

function serviceRestart {
    log "[ Restarting ${SERVICE_NAME}... ]"
    serviceStop
    serviceStart
    /opt/monit/bin/monit reload
}

LINK_LOCAL_IP=${LINK_LOCAL_IP:-""}

case "$1" in
        "start")
            serviceStart &>> /proc/1/fd/1
        ;;
        "stop")
            serviceStop &>> /proc/1/fd/1
        ;;
        "restart")
            serviceRestart &>> /proc/1/fd/1
        ;;
        *) echo "Usage: $0 restart|start|stop"
        ;;

esac

