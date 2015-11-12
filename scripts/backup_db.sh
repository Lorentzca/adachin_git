
# /bin/sh

BASE_FILE_NAME=mysql
FILE=${BASE_FILE_NAME}.`date +\%Y-\%m-\%d`.gz
OUTPUT=~/db_back/${FILE}

for x in mysql; do
mysqldump -h localhost -u root -B $x | gzip > ${OUTPUT}
done

OLD_FILE=${BASE_FILE_NAME}.`date +\%Y-\%m-\%d --date "-30 days"`.gz
OLD_OUTPUT=~/db_back/${OLD_FILE}

rm -f ${OLD_OUTPUT}

