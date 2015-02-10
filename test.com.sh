#!/bin/sh
###入力情報

 COMMON="test.com"
     ORG="会社名"
	 ORGUNIT="部署名"
	    CITY="市名"
		  STATE="都名"
		  COUNTRY="JP"
		   LENGTH=2048

###変数
FILENAME=$COMMON.`date +%Y`

###実行部
echo =================
echo creating ssl key.
echo =================
openssl genrsa -rand /var/log/messages -des3 -out /root/$FILENAME.key -passout pass:test $LENGTH
openssl rsa -in /root/$FILENAME.key -out /root/$FILENAME.key -passin pass:test
echo done
echo ""

echo ==================
echo printing key info.
echo ==================
cat /root/$FILENAME.key
echo done
echo ""

echo =================
echo creating ssl csr.
echo =================
cat <<@EOD > request.conf
[ req ]
distinguished_name = req_distinguished_name
prompt = no

[ req_distinguished_name ]
countryName = $COUNTRY
stateOrProvinceName = $STATE
localityName = $CITY
0.organizationName = $ORG
organizationalUnitName = $ORGUNIT
commonName = $COMMON
@EOD
openssl req -new -key /root/$FILENAME.key -out /root/$FILENAME.csr -config request.conf
rm -f request.conf
echo done
echo ""

echo ==================
echo printing csr info.
echo ==================
cat /root/$FILENAME.csr
echo done
echo ""
