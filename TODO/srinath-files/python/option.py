
import xml.dom.minidom
import string
import re

import vimxml

handlerMaps = {
	'options': vimxml.handleOptions,
	'option': vimxml.handleOption
}

xmlFile = open('opt.txt', 'r')
xmlString = string.join(xmlFile.readlines(), "")

xmlString = re.sub("<\+", "&lt;+", xmlString)
xmlString = re.sub("\+>", "+&gt;", xmlString)
dom = xml.dom.minidom.parseString(xmlString)
vimxml.handleOptions(dom)
