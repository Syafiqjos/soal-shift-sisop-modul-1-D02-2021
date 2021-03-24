#!/bin/bash

#INISIALISASI
logFilename="syslog.log"


#NOMOR A
ERROR=`grep -E "ERROR" "$logFilename"`
INFO=`grep -E "INFO" "$logFilename"`

errorCount=`printf "$ERROR" | wc -l`
infoCount=`printf "$INFO" | wc -l`


#NOMOR B
errorList=`printf "$ERROR" | grep -Po "(?<=ERROR )(.*)(?=\()" | sort | uniq -c | sort -nr`


#NOMOR C
userList=`grep -Po "(?<=\()(.*)(?=\))" "$logFilename" | sort | uniq`


#NOMOR D
errorFilename="error_message.csv"

echo "Error,Count" > "$errorFilename"

printf "$errorList" | while read errorLine
do
	currentErrorType=`echo $errorLine | cut -d ' ' -f 2-`
	currentCount=`echo $errorLine | cut -d ' ' -f 1`
	echo "$currentErrorType,$currentCount" >> "$errorFilename"
done

echo ">> Reading.. ($errorFilename)"
cat "$errorFilename"
echo


#NOMOR E
userFilename="user_statistic.csv"

echo "Username,INFO,ERROR" > "$userFilename"

printf "$userList" | while read username
do
	currentInfoCount=`printf "$INFO" | grep -E "(INFO).*(\($username\))" | wc -l`
	currentErrorCount=`printf "$ERROR" | grep -E "(ERROR).*(\($username\))" | wc -l`
	echo "$username,$currentInfoCount,$currentErrorCount" >> "$userFilename"
done

echo ">> Reading.. ($userFilename)"
cat "$userFilename"
echo
