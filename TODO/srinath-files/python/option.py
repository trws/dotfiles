import xml.dom.minidom
import string
import re

import vimxml

xmlFile = open('latex-suite.xml', 'r')
xmlString = string.join(xmlFile.readlines(), "")

xmlString = re.sub("<\+", "&lt;+", xmlString)
xmlString = re.sub("\+>", "+&gt;", xmlString)
dom = xml.dom.minidom.parseString(xmlString) 
print re.sub(r"(^|\n)( *)&codeend;", "\g<1><\g<2>", vimxml.handleElement(dom.documentElement))
