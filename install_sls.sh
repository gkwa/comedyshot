#!/bin/bash

cd /opt/data/lsweb
git checkout --force -t origin/al/vm-light-poc0
mkdir -p /usr/streambox/sls/

cp /opt/data/lsweb/usr/streambox/sls/sls.exe /usr/streambox/sls/sls.exe
chmod +rwx /usr/streambox/sls/sls.exe

cp /opt/data/lsweb/usr/streambox/sls/SLSserver.xml /usr/streambox/sls/SLSserver.xml
chmod +rwx /usr/streambox/sls/SLSserver.xml

cat <<'__eot__' >/etc/systemd/system/sls.service
#+begin_example
[Unit]
Description=Streambox Live Service

# After networking because we need that
After=network.target

[Service]
Type=simple
User=root

# Any setup we need to do, specifying the shell because otherwise who knows what's up
ExecStartPre=/bin/bash -c 'echo "hello world"'

# Set the working directory for the application
WorkingDirectory=/usr/streambox/sls

# Command to run the application
ExecStart=/usr/streambox/sls/sls.exe

# Restart policy, only on failure
Restart=on-failure

[Install]
# Start the service before we get to multi-user mode
WantedBy=multi-user.target
#+end_example
__eot__

chmod 664 /etc/systemd/system/sls.service
systemctl daemon-reload
systemctl enable sls
systemctl start sls
# journalctl --follow --unit=sls
