#!/bin/bash

# BACKUP
cp $1 $2
FIN=$1
FOUT=$2

sed -i '/^$/d' $FOUT

# Prepend the header "Name, Alias, Type, Notes, Priority"
cp $FOUT $FOUT.tmp
echo "Name, Alias, Type, Notes, Priority" > $FOUT
cat $FOUT.tmp >> $FOUT
rm $FOUT.tmp

cp $FOUT $FOUT.csv

echo "input: $1"
echo "output: $FOUT"
echo "NOTE: DO NOT FORGET TO REMOVE THE HEADERS & FOOTERS!!!"