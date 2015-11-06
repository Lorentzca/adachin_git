# /bin/sh                                                                                                                                                                                                                                                                     
BASE_FILE_NAME=mysql
FILE=${BASE_FILE_NAME}.`date +\%Y-\%m-\%d`.gz
OUTPUT=~/backup/mysql/${FILE}
sudo mysqldump -h localhost -u root adachin_test | gzip > ${OUTPUT}

OLD_FILE=${BASE_FILE_NAME}.`date +\%Y-\%m-\%d --date "-30 days"`.gz
OLD_OUTPUT=~/backup/mysql/${OLD_FILE}

rm -f ${OLD_OUTPUT}
