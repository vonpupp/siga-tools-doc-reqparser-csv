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
#   Author: 			Albert De La Fuente (www.albertdelafuente.com)
#   E-Mail: 			vonpupp@gmail.com
#
#   Description:		This does final formating, minor stuff
#
#   Limitations:		Error handling is not implemented, time constraints
#	The code is not clean and elegant as it should, again, time constraints
#   Database tables used:	None 
#   Thread Safe:		No
#   Extendable:			No
#   Platform Dependencies:	Linux (openSUSE used)
#   Compiler Options:		
#   Parameters:			$0 file-input file-output	
###############################################################################

# Result file
cp $1 $2
FIN=$1
FOUT=$2

sed -i '/^$/d' $FOUT
sed -i 's/Requirement	/Requirement	"\n/g' $FOUT
sed -i 's/TAGRFI/RFI/g' $FOUT
sed -i 's/TAGRFN/RFN/g' $FOUT
sed -i 's/TAGRNF/RNF/g' $FOUT
sed -i 's/TAGRGN/RGN/g' $FOUT
#sed -i 's/^RFI[[:digit:]][[:digit:]][[:digit:]]. //g' $FOUT
#sed -i 's/^RFN[[:digit:]][[:digit:]][[:digit:]]. //g' $FOUT

# Prepend the header "Name, Alias, Type, Notes, Priority"
cp $FOUT $FOUT.tmp
echo "Name	Alias	Type	Notes	Priority	Author" > $FOUT
cat $FOUT.tmp >> $FOUT
rm $FOUT.tmp

cp $FOUT $FOUT.csv

echo "input: $1"
echo "output: $FOUT"
echo "NOTE: DO NOT FORGET TO REMOVE THE HEADERS & FOOTERS!!!"
