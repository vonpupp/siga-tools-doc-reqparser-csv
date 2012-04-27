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
  li = s.rsplit(old, occurrence) # Reverse split by the las ocurrence
  return new.join(li)
  
def extractThirdField(s):
  a, b, c = s.partition("\t") # Remove the first parameter
  a, b, c = c.partition("\t") # Remove the second parameter
  a, b, c = c.rpartition("\t") # Remove the last parameter
  li = a
  return li
  
def leftQuoteThirdField(s):
  a, b, rest = s.partition("\t") # Remove the first parameter
  c, d, rest = rest.partition("\t") # Remove the second parameter
  li = a + b + c + d + '"' + rest
  #print "a=" + a
  #print "b=" + b
  #print "c=" + c
  #print "d=" + d
  #print "e=" + e
  #print "f=" + f
  return li

def rightQuoteThirdField(s):
  a, b, c = s.rpartition(",") # Remove the last parameter
  li = a + '"' + b + c
  return li

def parseTag(inputfilename, outputfilename, searchExp):
  fin = fileinput.input(inputfilename, inplace = 0, openhook = fileinput.hook_encoded(fileencoding))
  fout = codecs.open(outputfilename, "w", fileencoding)
  isblock = 0
  for line in fin:
    newline = line
    isfirst = searchExp in line
    islast = "\tMedium;" in line
    issingleline = isfirst and islast # and "," in line
    fixquotes = 0

    if issingleline:
      fixquotes = "\t" in extractThirdField(line) # If there is a comma on the third fild, quote it!
      if fixquotes:
	newline = leftQuoteThirdField(line)
	newline = rightQuoteThirdField(newline)
	print "%d: %s" % (fileinput.filelineno(), newline)
#	print "%d:(issingle):%s" % (fileinput.filelineno(), newline)

    if (not issingleline) and (isfirst and not islast):
      #newline = reverseReplace(line, searchExp, searchExp + '"', 1)
      newline = leftQuoteThirdField(line)
      print "quoting left"
      isblock = 1
    if (not issingleline) and (not isfirst and islast and isblock):
      newline = reverseReplace(line, "\tMedium;", '"' + "\tMedium;", 1)
      print "quoting right"
      isblock = 0
    #TODO: Fix the single line comma bug
    fout.write(newline)
    if issingleline:
      print "%d: %s" % (fileinput.filelineno(), newline)
  fout.close()

# MAIN
if len(sys.argv) != 4:  # the program name and the two arguments
  # stop the program and print an error message
  sys.exit("Must provide three parameters: <input file> <output file> <TAG>")
  
fin=sys.argv[1]
fout=sys.argv[2]
parseTag(fin, fout, sys.argv[3]);

print "input: " + fin
print "output: " + fout