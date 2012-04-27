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
#   Description:		This script allows to preformat the text by
#	removing Heading1..Heading4, trimming whitespaces, etc.
#	Read the code, it's pretty much straight forward and self explainatory 
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

# LC_ALL=en_US.utf8

# Trim whitespaces
sed -i 's/^[ \t]*//' $FOUT
sed -i 's/[ \t]*$//' $FOUT
sed -i 's/^[ \t]*//;s/[ \t]*$//' $FOUT

# Clean the index and document header
#sed -i '/^HISTÓRICO DE TRABALHO:/,/^FUNCIONALIDADE/d' $FOUT

# Clean the document structure and footer
sed -i '/^ESTRUTURA DO DOCUMENTO/,$d' $FOUT
#sed -i '/^ESTRUTURA DO DOCUMENTO:/,/$/d' $FOUT

# Clean from Heading1 to Heading3
# Delete from MACROPROCESSO to FUNCIONALIDADE (both included)
sed -i '/^MACROPROCESSO:/,/^FUNCIONALIDADE/d' $FOUT
# Delete from PROCESSO to FUNCIONALIDADE (both included)
sed -i '/^PROCESSO:/,/^FUNCIONALIDADE/d' $FOUT
# Delete FUNCIONALIDADE
sed -i '/^FUNCIONALIDADE/d' $FOUT
#sed -i '/^PROCESSO:/,/^$/d' $FOUT
sed -i '/^Descrição:/d' $FOUT
#sed -i '/^Descrição:/,/^Nome/d' $FOUT

# Clean Heading4
sed -i '/^REQUISITOS/d' $FOUT
#sed -i '/^REQUISITOS FUNCIONAIS/d' $FOUT
sed -i '/^REGRAS DE NEGOCIO/d' $FOUT

# Clean columns headers
sed -i '/^Nome/d' $FOUT
sed -i '/^Alias/d' $FOUT
#sed -i '/^Descrição/d' $FOUT
sed -i '/^Descri/d' $FOUT
sed -i '/^Criticidade/d' $FOUT

#sed -i 's/^[[:space:]]*\(.*\)[[:space:]]*$/\1/' $FOUT

# Trim CRLF
dos2unix $FOUT
sed -i '/^$/d' $FOUT
sed -i 's/^Media/"	Medium;\n/g' $FOUT
#sed -i 's/^Media/Media\n/' $FOUT

# sed -i s//./g $FOUT

# Pre-processing
# sed -i s/á/a/g $FOUT
# sed -i s/á/a/g $FOUT
# sed -i s/â/a/g $FOUT
# sed -i s/ã/a/g $FOUT
# sed -i s/é/e/g $FOUT
# sed -i s/ê/e/g $FOUT
# sed -i s/ç/c/g $FOUT
# sed -i s/í/i/g $FOUT
# sed -i s/ó/o/g $FOUT
# sed -i s/ô/o/g $FOUT
# sed -i s/õ/o/g $FOUT
# sed -i s/ú/u/g $FOUT
# 
# sed -i s//"'"/g $FOUT # Ex: ...histórico padrão 11 - CHEQUE N°' para preenchimento do número do cheque.
# sed -i s//"'"/g $FOUT # Ex: ...histórico padrão '11 - CHEQUE N° para preenchimento do número do cheque.
# sed -i s//"-"/g $FOUT # Ex: * Total Bancos  conta movimento

sed -i 's/\x96/-/' $FOUT # Replace MS Words large hyphen (HEX 0x96) with the ascii one
sed -i 's/\x95/*/' $FOUT # Replace MS Words bullet (HEX 0x95) with the asterisk
sed -i "s/\x93/'/" $FOUT # Replace MS Words single quote (open HEX 0x93) with the ascii one
sed -i "s/\x94/'/" $FOUT # Replace MS Words single quote (close HEX 0x93) with the ascii one

# Ensure there is a space after each tag
sed -i 's/^RFI\./RFI. /' $FOUT
sed -i 's/^RFN\./RFN. /' $FOUT
sed -i 's/^RNF\./RNF. /' $FOUT
sed -i 's/^RN\./RN. /' $FOUT

# Bring the second parameter to the prior line
awk '/^RFI\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RFN\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RNF\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RN\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

# Bring the third parameter (first lie) to the prior line
awk '/^RFI\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RFN\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RNF\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
awk '/^RN\. / {getline t; print $0"	"t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp

#awk '/^, Medium/ {getline t; print $0", "t; next}; 1' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp
#sed -i ':a; $!N;s/\n, Medium;/ /;ta;P;D'
#sed -i ':a; $!N;s/Medium/ /;ta;P;D' $FOUT
#sed -i ':a; /, Medium;\$/N; s/, Medium;\n//; ta' $FOUT

# Bring the fourth parameter to the prior line [<ironic on> sed is very intuitive <ironic off>]
sed -i 'N;/\n,/s/"\? *\n//;P;D' $FOUT
# sed -i -e :a -e '$!N;s/\n<<=/ /;ta' -e 'P;D' $FOUT

#BEGIN { FS="|"; OFS="," }
## Append 'short' lines into one longer line
#NF<5 { if(S){ $0="\\n" $0; } S=S $0; $0=S }
## When it fially ends in "NEWLINE", we know we have an entire record
#$NF == "NEWLINE" {
#        for(N=1; N<=NF; N++)
#        # Add single quotes to things lacking double quotes
#        if(substr($N,1,1) != "\"")
#                $N = "'" $N "'";
#
#        print "insert into MyTBI values("$1,$2,$3,$4,$5");";
#        S="";
#}
#awk -f myawk.txt < data

#   awk 'BEGIN { FS=","; OFS=";" }
#     NF<5 { if(S){ $0="\\n" $0; } S=S $0; $0=S }
#     # When it fially ends in "NEWLINE", we know we have an entire record
#     $NF == "NEWLINE" {
# 	for(N=1; N<=NF; N++)
#         # Add single quotes to things lacking double quotes
#         if(substr($N,1,1) != "\"")
#                 $N = "'" $N "'";
# 
#         print "insert into MyTBI values("$1,$2,$3,$4,$5");";
#         S="";
#     }' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp


#    {print}' $FOUT > $FOUT.tmp;cp $FOUT.tmp $FOUT;\rm $FOUT.tmp


# TODO: DELETE CRAP BY HAND

echo "input: $FIN"
echo "output: $FOUT"
echo "NOTE: DID YOU REMOVE THE HEADERS & FOOTERS???"