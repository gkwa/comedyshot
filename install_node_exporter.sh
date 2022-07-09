#!/bin/bash

# https://github.com/prometheus/node_exporter/releases

# get latest release
version=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep tag_name | cut -d '"' -f 4 | tr -d v)
echo $version
mkdir -p /usr/local/{bin,src}
curl -sSL -o /usr/local/src/node_exporter-${version}.linux-amd64.tar.gz https://github.com/prometheus/node_exporter/releases/download/v${version}/node_exporter-${version}.linux-amd64.tar.gz
tar xvf /usr/local/src/node_exporter-${version}.linux-amd64.tar.gz -C /usr/local/src
useradd --no-create-home --shell /bin/false node_exporter
mkdir -p /var/lib/node_exporter/textfile_collector
chown node_exporter:node_exporter /usr/local/src/node_exporter-${version}.linux-amd64/node_exporter /var/lib/node_exporter/textfile_collector
ln -fs /usr/local/src/node_exporter-${version}.linux-amd64/node_exporter /usr/local/bin/node_exporter
/usr/local/bin/node_exporter --version
mkdir -p /var/lib/node_exporter/textfile_collector
chown node_exporter:node_exporter /var/lib/node_exporter/textfile_collector
# install node_exporter service
cat <<'__eot__' >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=node_exporter
Restart=on-failure
ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/var/lib/node_exporter/textfile_collector

[Install]
WantedBy=default.target
__eot__
chmod 664 /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
