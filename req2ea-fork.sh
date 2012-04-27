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
#   Description:		This is the main script that does the invocation
#	of the other scripts with the appropriate parameters
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

FINPUT=$1

#FINPUT="req-jur-v2"
#./catdoc -s ../charsets/8859-1.txt -d ../charsets/8859-1.txt REQ_CTB-v5.doc 

#catdoc -s8859-1 -d8859-1 $FINPUT.doc > $FINPUT.cat
cp $FINPUT $FINPUT.010
source req2ea-02preformat.sh $FINPUT.010 $FINPUT.020
python req2ea-03quote.py $FINPUT.020 $FINPUT.021 "RFI. ,"
python req2ea-03quote.py $FINPUT.021 $FINPUT.022 "RFN. ,"
python req2ea-03quote.py $FINPUT.022 $FINPUT.023 "RNF. ,"
python req2ea-03quote.py $FINPUT.023 $FINPUT.024 "RN. ,"
cp $FINPUT.024 $FINPUT.030
source req2ea-04index.sh $FINPUT.030 $FINPUT.040 0 0 0 0
source req2ea-05posformat.sh $FINPUT.040 $FINPUT.050

