FROM jenkins/jenkins:2.60.3
USER root
ARG jenkins_home=/var/jenkins_home/

# setup http proxy
ARG http_proxy=http://webproxy-utvikler.nav.no:8088
ENV http_proxy ${http_proxy}
ENV https_proxy ${http_proxy}
ENV no_proxy 155.55.,192.168.,10.,local,rtv.gov,adeo.no,nav.no,aetat.no,devillo.no,oera.no
# [ Verify-* ] ok siden vi uansett går gjennom webproxy
#RUN echo "Acquire::http::Proxy \"${http_proxy}\";Acquire::https::Verify-Peer \"false\";Acquire::https::Verify-Host \"false\";" > /etc/apt/apt.conf.d/proxy.conf


## disable wizard - merk at versjoner må korrespondere ##
RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.60.3 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

ARG domenebrukernavn=srvPortaler
ARG domenepassord=
ARG STASH_USERNAME=srvDial
ARG STASH_PASSWORD=

## installer custom theme ##
ADD material-indigo.css ${jenkins_home}/userContent/material-indigo.css
ADD org.codefirst.SimpleThemeDecorator.xml ${jenkins_home}org.codefirst.SimpleThemeDecorator.xml


## installer plugins ##
ADD installer-plugins.sh /tmp/installer-plugins.sh
RUN chmod +x /tmp/installer-plugins.sh && /tmp/installer-plugins.sh


## opprett seed-jobb ##
ADD seed-job-config.xml ${jenkins_home}/jobs/seed/config.xml


## TODO: ldap-oppsett for sikkerhet! ##

