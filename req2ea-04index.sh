#!/bin/bash

###############################################################################
#   Project:			SIGA-CCB
#   Component Name:		req2ea (MS Word requirements to Sparx EA)
#   Language:			bash
#
#   License: 			GNU Public License
#	This file is part of req2ea.
#	Foobar is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	(at your option) any later version.
#
#	Foobar is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
#	You should have received a copy of the GNU General Public License
#	along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
# 
#   Author:			Albert De La Fuente (www.albertdelafuente.com)
#   E-Mail: 			vonpupp@gmail.com
#
#   Description:		This script allows to index the tags per block
#
#   Limitations:		Error handling is not implemented, time constraints
#	The code is not clean and elegant as it should, again, time constraints
#   Database tables used:	None 
#   Thread Safe:		No
#   Extendable:			No
#   Platform Dependencies:	Linux (openSUSE used)
#   Compiler Options:		
#   Parameters:			$0 file-input file-output RFIidx RFNidx RNFidx RNidx
###############################################################################

# Result file
cp $1 $2
FOUT=$2

# CRLF Handling
dos2unix $FOUT

tagindex() {
  TAG=$1
  OFFSET=$2
  NTAG=`grep "$TAG\." $FOUT | wc -l`

  echo "To replace $NTAG $TAG's"
#  let NTAG=$NTAG
  for (( I=1; I<=$NTAG; I++ ))
  do
    let IDX=$OFFSET+$I
    IDX=`printf "%03d" $IDX`
    echo "Replacing first $TAG on data block $IDX out of $NTAG total blocks"

    # Insane cool part...
    # Parsing the first tag
#'/'$SearchString'/ {print}' "$@"
    awk '/'$TAG'\. /{\
      if (FIRST==""){\
	sub("'$TAG'\. ","'$TAG${IDX}.'");
	FIRST=1}
      }
      {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

    echo "Replacing second $TAG on data block $IDX out of $NTAG total blocks"

    # Parsing the second tag
    awk '/'$TAG'\. /{\
      if (SECOND==""){\
	sub("'$TAG'\. ","'$TAG${IDX}'.	Requirement");
	SECOND=1}
      }
      {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
  done
}

NTAG=0
IDX=0
tagindex "RFI" $3
let NRFI=$3 + 1
NRFIT=$NTAG
OFFNRFI=$IDX

NTAG=0
IDX=0
tagindex "RFN" $4
let NRFN=$4 + 1
NRFNT=$NTAG
OFFNRFN=$IDX

NTAG=0
IDX=0
tagindex "RNF" $5
let NRNF=$5 + 1
NRNFT=$NTAG
OFFNRNF=$IDX

NTAG=0
IDX=0
tagindex "RN" $6
let NRN=$6 + 1
NRNT=$NTAG
OFFNRN=$IDX

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
echo "Number or RFI's: $NRFIT / From: $NRFI to $OFFNRFI"
echo "Number or RFN's: $NRFNT / From: $NRFN to $OFFNRFN"
echo "Number or RNF's: $NRNFT / From: $NRNF to $OFFNRNF"
echo "Number or RN's: $NRNT / From: $NRN to $OFFNRN"