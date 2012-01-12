#!/bin/bash

# Backup
FINPUT=$1

FINPUT="REQ_CTB-v6"
#./catdoc -s ../charsets/8859-1.txt -d ../charsets/8859-1.txt REQ_CTB-v5.doc 

catdoc -s8859-1 -d8859-1 req-jur-v2.doc > $FINPUT.cat
source req2ea-01unindex-v2.sh $FINPUT $FINPUT.00
source req2ea-02preformat-v4.sh $FINPUT.00 $FINPUT.01
python req2ea-03multiline-v1.py $FINPUT.01 $FINPUT.02a "RFI. ,"
python req2ea-03multiline-v1.py $FINPUT.02a $FINPUT.02b "RFN. ,"
python req2ea-03multiline-v1.py $FINPUT.02b $FINPUT.02c "RNF. ,"
python req2ea-03multiline-v1.py $FINPUT.02c $FINPUT.02d "RN. ,"
cp $FINPUT.02d $FINPUT.03
source req2ea-04index-v7.sh $FINPUT.03 $FINPUT.04
source req2ea-05posformat-v2.sh $FINPUT.04 $FINPUT.05

