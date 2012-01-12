#!/bin/bash

# Result file
cp $1 $2
FOUT=$2

# CRLF Handling
dos2unix $FOUT

# Count
TAG="RFN"
NTAG=`grep "$TAG\." $FOUT | wc -l`

echo "To replace $NTAG $TAG's"
let NTAG=$NTAG
for (( I=1; I<=$NTAG; I++ ))
do
  IDX=`printf "%03d" $I`
  echo "Replacing first $TAG on data block $IDX out of $NTAG total blocks"

  # Insane cool part...
  # Parsing the first tag
  awk '/RFN\. /{\
    if (FIRST==""){\
      sub("RFN\. ","'"RFN${IDX}."'");
      FIRST=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

  echo "Replacing second $TAG on data block $IDX out of $NTAG total blocks"

  # Parsing the second tag
  awk '/RFN\. /{\
    if (SECOND==""){\
      sub("RFN\. ","'"RFN${IDX}., Requirement"'");
      SECOND=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
done

# This part of the code is not elegant at all, I had to copy and paste it since I don't know
# how to pass variables to awk in the first section (/first/second), so it sucks!
TAG="RNF"
NTAG=`grep "$TAG\." $FOUT | wc -l`

echo "To replace $NTAG $TAG's"
let NTAG=$NTAG
for (( I=1; I<=$NTAG; I++ ))
do
  IDX=`printf "%03d" $I`
  echo "Replacing first $TAG on data block $IDX out of $NTAG total blocks"

  # Insane cool part...
  # Parsing the first tag
  awk '/RNF\. /{\
    if (FIRST==""){\
      sub("RNF\. ","'"RNF${IDX}."'");
      FIRST=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

  echo "Replacing second $TAG on data block $IDX out of $NTAG total blocks"

  # Parsing the second tag
  awk '/RNF\. /{\
    if (SECOND==""){\
      sub("RNF\. ","'"RNF${IDX}., Requirement"'");
      SECOND=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
done

# Again copying =S: Me no like it
TAG="RFI"
NTAG=`grep "$TAG\." $FOUT | wc -l`

echo "To replace $NTAG $TAG's"
let NTAG=$NTAG
for (( I=1; I<=$NTAG; I++ ))
do
  IDX=`printf "%03d" $I`
  echo "Replacing first $TAG on data block $IDX out of $NTAG total blocks"

  # Insane cool part...
  # Parsing the first tag
  awk '/RFI\. /{\
    if (FIRST==""){\
      sub("RFI\. ","'"RFI${IDX}."'");
      FIRST=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

  echo "Replacing second $TAG on data block $IDX out of $NTAG total blocks"

  # Parsing the second tag
  awk '/RFI\. /{\
    if (SECOND==""){\
      sub("RFI\. ","'"RFI${IDX}., Requirement"'");
      SECOND=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
done

# # This time for RN tags
TAG="RN"
NTAG=`grep "$TAG\." $FOUT | wc -l`
echo $NTAG

echo "To replace $NTAG $TAG's"
let NTAG=$NTAG
for (( I=1; I<=NTAG; I++ ))
do
  IDX=`printf "%03d" $I`
  echo "Replacing first $TAG on data block $IDX out of $NTAG total blocks"

  # Insane cool part...
  # Parsing the first tag
  awk '/RN\. /{\
    if (FIRST==""){\
      sub("RN\. ","'"RN${IDX}. "'");
      FIRST=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

  echo "Replacing second $TAG on data block $IDX out of $NTAG total blocks"

  # Parsing the second tag
  awk '/RN\. /{\
    if (SECOND==""){\
      sub("RN\. ","'"RN${IDX}., Requirement"'");
      SECOND=1}
    }
    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
done

# Adding a quote on the fourth param (close)
#sed -i 's/^Media/, Medium;/g' $FOUT
#sed -i 's/^Media/\", Medium;/g' $FOUT

# Join of the third parameter
#awk '/Requirement/ {getline t; print $0 t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

# Join of the fourth parameter
# There is an ERROR here with multiple lines REQ's, I'll need to add an CRLF manually
#awk '/Requirement/ {getline t; print $0 t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

# First quote (open)
#sed -i 's/Requirement/Requirement, /g' $FOUT
#sed -i 's/Requirement/Requirement, "/g' $FOUT

echo "input: $FIN"
echo "output: $FOUT"