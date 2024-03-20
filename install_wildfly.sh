#!/bin/bash

sudo apt install openjdk-8-jdk

sudo groupadd -r wildfly
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly

WILDFLY_VERSION="14.0.1.Final"

if [ ! -f wildfly-$WILDFLY_VERSION.tar.gz ]; then
    wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz

    if [ $? -ne 0 ]; then
     exit 1;
    fi
fi


sudo tar xf wildfly-${WILDFLY_VERSION}.tar.gz -C /opt/
sudo ln -s /opt/wildfly-${WILDFLY_VERSION} /opt/wildfly
sudo chown -RH wildfly: /opt/wildfly
sudo mkdir -p /etc/wildfly
sudo cp -i /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/

sudo cp -i /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'
sudo cp -i /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable wildfly
