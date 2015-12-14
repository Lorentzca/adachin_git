#!/bin/sh

while getopts c:r:s: opt
do
   case ${opt} in
    c)
        REWITECOND=${OPTARG};;
    r)
        REWITERULE=${OPTARG};;
    s)
        SERVERALIAS=${OPTARG};;
    *)
  exit 1;;
  esac
done

cp /etc/httpd/conf.d/httpd.conf /var/tmp
sed -i "83a \  \RewriteCond %{HTTP_HOST} $REWITECOND\\\.jp$ [NV]" httpd-40.conf
sed -i "84a \  \RewriteRule ^/js/(.*) /hoge/js/$REWITERULE/\$1\ [L]" httpd-40.conf
sed -i "24a \  \ServerAlias *.$SERVERALIAS" httpd-40.conf
mkdir -p /hoge/js/$REWITERULE
chown -R adachin.wheel /hoge/js/$REWITERULE
diff -u /etc/httpd/conf.d/httpd.conf /var/tmp/httpd-40.conf

