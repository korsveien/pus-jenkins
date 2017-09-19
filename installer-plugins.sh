#!/bin/bash
set -x
set -e

PLUGIN_URL="http://maven.adeo.no/nexus/service/local/artifact/maven/redirect?r=m2snapshot&g=no.nav.bekkci&a=bekkci-jenkins-plugin&v=1-SNAPSHOT&e=hpi"

mkdir /usr/share/jenkins/ref/plugins/
wget ${PLUGIN_URL} \
 -O /usr/share/jenkins/ref/plugins/bekkci-plugin.hpi


# ok siden vi uansett er bak webproxy
echo insecure >> ~/.curlrc

install-plugins.sh \
 git:3.5.1 \
 job-dsl:1.65 \
 simple-theme-plugin:0.3 \
 workflow-aggregator:2.5 \
 workflow-cps:2.40 \
 view-job-filters:1.27 \
 parameterized-trigger:2.35.2 \
 global-variable-string-parameter:1.2


echo "provision ok!"