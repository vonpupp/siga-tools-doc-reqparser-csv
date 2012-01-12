#!/usr/bin/env python

"""
reqea-preformat02.py
=======

ODT2TXT convers files in Open Document Text format (ODT) into
Markdown-formatted plain text.

Writteby by [Yuri Takhteyev](http://www.freewisdom.org).

Project website: http://www.freewisdom.org/projects/python-markdown/odt2txt
Contact: yuri [at] freewisdom.org

License: GPL 2 (http://www.gnu.org/copyleft/gpl.html) or BSD

Version: 0.1 (April 7, 2006)

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