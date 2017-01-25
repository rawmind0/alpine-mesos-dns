[![](https://images.microbadger.com/badges/image/rawmind/alpine-mesos-dns.svg)](https://microbadger.com/images/rawmind/alpine-mesos-dns "Get your own image badge on microbadger.com")

alpine-mesos-dns 
==============

This image is the mesos-dns base. It comes from [alpine-monit][alpine-monit].

## Build

```
docker build -t rawmind/alpine-mesos-dns :<version> .
```

## Versions

- `0.6.0-2` [(Dockerfile)](https://github.com/rawmind0/alpine-mesos-dns/blob/0.6.0-2/Dockerfile)


## Configuration

This image runs [mesos-dns][mesos-dns] with monit. It is started with mesos-dns user/group with 10010 uid/gid.

Besides, you can customize the configuration in several ways:

### Default Configuration

Mesos-dns is installed with the default configuration and some parameters can be overrided with env variables:

- MESOS_ZK=${MESOS_ZK:-zk://127.0.0.1:2181/mesos}
- MESOS_MASTER=${MESOS_MASTER:-"\"127.0.0.1:5050\""}
- MESOS_DNS_DOMAIN=${MESOS_DNS_DOMAIN:-"mesos"}
- MESOS_DNS_NS=${MESOS_DNS_NS:-"ns1"}
- MESOS_DNS_PORT=${MESOS_DNS_PORT:-"53"}
- MESOS_DNS_HTTPPORT=${MESOS_DNS_HTTPPORT:-"8123"}
- MESOS_DNS_RESOLVERS=${MESOS_DNS_RESOLVERS:-"\"8.8.8.8\""}
- MESOS_DNS_DNSON=${MESOS_DNS_DNSON:-true}
- MESOS_DNS_HTTPON=${MESOS_DNS_HTTPON:-true}
- MESOS_DNS_EXTERNALON=${MESOS_DNS_EXTERNALON:-true}
- MESOS_DNS_RECURSEON=${MESOS_DNS_RECURSEON:-true}
- MESOS_DNS_LISTENER=${MESOS_DNS_LISTENER:-"0.0.0.0"}
- LINK_LOCAL_IP=${LINK_LOCAL_IP:-""}

### Custom Configuration

Mesos-dns is installed under /opt/mesos-dns and make use of /opt/mesos-dns/etc/config.json.

You can edit or overwrite this files in order to customize your own configuration or certificates.

You could also include FROM rawmind/alpine-mesos-dns at the top of your Dockerfile, and add your custom config.



[alpine-monit]: https://github.com/rawmind0/alpine-monit/
[mesos-dns]: https://github.com/mesosphere/mesos-dns

