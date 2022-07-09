## fetch newer image from s3
```
ssh root@tl5 -p 22

aws s3 ls --recursive s3://streambox-comedyshot | sort | tail -5

# decide this is the one i want to try for example:
# 2022-07-16T03:47:58.0000000Z/00e6d5b9a0b19be2874778f6f8f6d588ebceda2954513b0d39708612f7c46fe7.tar.gz

# slurp this tar into local lxc image repository with alias 'isls'
aws s3 --region us-west-2 sync s3://streambox-comedyshot . --exclude="*" --include="*2022-07-16T03:47:58*"
lxc image --alias isls import 2022-07-16T03:47:58.0000000Z/00e6d5b9a0b19be2874778f6f8f6d588ebceda2954513b0d39708612f7c46fe7.tar.gz
```

## start clean with new image
```
ssh root@tl5 -p 22

# delete container
# create new container with name csls from image isls
# and list running containers:
lxc delete --force csls
lxc launch isls csls
lxc ls

# forward ports to container
lxc config device add csls myport22 proxy listen=tcp:0.0.0.0:2222 connect=tcp:127.0.0.1:22
lxc config device add csls myport80 proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc config device add csls myport443 proxy listen=tcp:0.0.0.0:443 connect=tcp:127.0.0.1:443
lxc config device add csls myport1770 proxy listen=udp:0.0.0.0:1770 connect=udp:127.0.0.1:1770
lxc config device add csls myport1771 proxy listen=udp:0.0.0.0:1771 connect=udp:127.0.0.1:1771
lxc config device add csls myport1772 proxy listen=udp:0.0.0.0:1772 connect=udp:127.0.0.1:1772
lxc config device add csls myport1773 proxy listen=udp:0.0.0.0:1773 connect=udp:127.0.0.1:1773
lxc config device add csls myport1774 proxy listen=udp:0.0.0.0:1774 connect=udp:127.0.0.1:1774
lxc config device add csls myport1775 proxy listen=udp:0.0.0.0:1775 connect=udp:127.0.0.1:1775
lxc config device add csls myport1776 proxy listen=udp:0.0.0.0:1776 connect=udp:127.0.0.1:1776
lxc config device add csls myport1777 proxy listen=udp:0.0.0.0:1777 connect=udp:127.0.0.1:1777
lxc config device add csls myport1778 proxy listen=udp:0.0.0.0:1778 connect=udp:127.0.0.1:1778
lxc config device add csls myport1779 proxy listen=udp:0.0.0.0:1779 connect=udp:127.0.0.1:1779
lxc config device add csls myport1900 proxy listen=udp:0.0.0.0:1900 connect=udp:127.0.0.1:1900
```

## ssh to contianer and fiddle around
```
ssh -o UserKnownHostsFile=/dev/null root@tl5 -p 2222

# test that sls, mysql, apache services are running:
pytest --verbose --tb=short /usr/local/bin/test.py
```
