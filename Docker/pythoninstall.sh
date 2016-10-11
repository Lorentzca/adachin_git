#!/bin/bash
VERSIONS=${VERSIONS:-"2.7.8.10"}

# make directory
mkdir -p /bin
cd /bin

wget http://downloads.activestate.com/ActivePython/releases/${VERSIONS}/ActivePython-${VERSIONS}-linux-x86_64.tar.gz
tar -xzvf ActivePython-${VERSIONS}-linux-x86_64.tar.gz

mv ActivePython-${VERSIONS}-linux-x86_64 apy && cd apy && ./install.sh -I /bin/python/

ln -s /opt/python/bin/easy_install /bin/easy_install
ln -s /opt/python/bin/pip /bin/pip
ln -s /opt/python/bin/python /bin/python
ln -s /opt/python/bin/virtualenv /bin/virtualenv
ln -s /opt/python/bin/python /usr/bin/python
