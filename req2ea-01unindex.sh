#!/bin/bash

# Backup
cp $1 $2
FIN=$1
FOUT=$2

sed -i 's/^RFI [[:digit:]][[:digit:]][[:digit:]]/RFI/g' $FOUT
sed -i 's/^RFI [[:digit:]][[:digit:]]/RFI/g' $FOUT
sed -i 's/^RFI [[:digit:]]/RFI/g' $FOUT

sed -i 's/^RFN [[:digit:]][[:digit:]][[:digit:]]/RFN/g' $FOUT
sed -i 's/^RFN [[:digit:]][[:digit:]]/RFN/g' $FOUT
sed -i 's/^RFN [[:digit:]]/RFN/g' $FOUT

sed -i 's/^RNF [[:digit:]][[:digit:]][[:digit:]]/RNF/g' $FOUT
sed -i 's/^RNF [[:digit:]][[:digit:]]/RNF/g' $FOUT
sed -i 's/^RNF [[:digit:]]/RNF/g' $FOUT

sed -i 's/^RN [[:digit:]][[:digit:]][[:digit:]]/RN/g' $FOUT
sed -i 's/^RN [[:digit:]][[:digit:]]/RN/g' $FOUT
sed -i 's/^RN [[:digit:]]/RN/g' $FOUT

sed -i 's/RFI. , RFI. , /RFI. ,/g' $FOUT
sed -i 's/RFN. , RFN. , /RFN. ,/g' $FOUT
sed -i 's/RNF. , RNF. , /RNF. ,/g' $FOUT
sed -i 's/RN. , RN. , /RN. ,/g' $FOUT
#sed -i 's/. , /. ,/g' $1

# Output file
echo "input $FIN"
echo "output: $FOUT"