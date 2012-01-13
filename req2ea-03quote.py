#!/usr/bin/env python

"""
###############################################################################
#   Project:			SIGA-CCB
#   Component Name:		req2ea (MS Word requirements to Sparx EA)
#   Language:			python
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
#   E-Mail: 			vonpupp [at] gm@il.com
#
#   Description:		This script allows to quote multiline requirements
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
""" 


# I've learn python in less than half an hour (literaly)... look at the code with that optic =P
import fileinput, sys, codecs
fileencoding = "iso-8859-1"

def reverseReplace(s, old, new, occurrence):
  li = s.rsplit(old, occurrence)
  return new.join(li)

def parseMultiTag(inputfilename, outputfilename, searchExp):
  fin = fileinput.input(inputfilename, inplace = 0, openhook = fileinput.hook_encoded(fileencoding))
  fout = codecs.open(outputfilename, "w", fileencoding)
  isblock = 0
  for line in fin:
    newline = line
    isfirst = searchExp in line
    islast = ", Medium;" in line
    if isfirst and not islast:
      newline = reverseReplace(line, searchExp, searchExp + ' "', 1)
      isblock = 1
    if not isfirst and islast and isblock:
      newline = reverseReplace(line, ", Medium;", '"' + ", Medium;", 1)
      isblock = 0
    #TODO: Fix the single line comma bug
    fout.write(newline)
#    print "%d: %s" % (fileinput.filelineno(), newline)
  fout.close()

# MAIN
if len(sys.argv) != 4:  # the program name and the two arguments
  # stop the program and print an error message
  sys.exit("Must provide three parameters: <input file> <output file> <TAG>")
  
fin=sys.argv[1]
fout=sys.argv[2]
parseMultiTag(fin, fout, sys.argv[3]);

print "input: " + fin
print "output: " + fout