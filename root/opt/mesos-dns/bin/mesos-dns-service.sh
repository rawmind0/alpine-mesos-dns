#!/usr/bin/env bash

function log {
        echo `date` $ME - $@
}

function serviceLog {
    log "[ Redirecting ${SERVICE_NAME} log... ]"
    if [ -e ${SERVICE_HOME}/nohup.out ]; then
        ${SERVICE_HOME}/nohup.out
    fi
    ln -sf /proc/1/fd/1 ${SERVICE_HOME}/nohup.out
}


function serviceCheck {
    log "[ Generating ${SERVICE_NAME} configuration... ]"
    ${SERVICE_HOME}/bin/config.json.sh
}

function serviceStart {
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

