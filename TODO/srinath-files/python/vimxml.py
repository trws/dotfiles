import textutils,string
import numarray
from textutils import GetTextFromElementNode

def handleOptions(fileDom):
	# for each child node of the document root...
	for child in fileDom.documentElement.childNodes:
		# if the child is an "element" and it has some handler function in
		# handlerMaps, then use that handler function to further process
		# it.
		if child.nodeType == child.ELEMENT_NODE:
			tagName = child.tagName
			if handlerMaps.has_key(tagName):
				handlerMaps[tagName](child)

def handleOption(option):
	names = GetTextFromElementNode(option, "name")

	for name in names:
		print string.rjust("*"+name+"*", 70)

	for name in names:
		print "\n" + name,

	print "\n",
	desc = GetTextFromElementNode(option, "desc")[0]
	print textutils.IndentParagraphs(desc, 50, 20)

def handleOptionDefault(default):
	type = string.join(GetTextFromElementNode(default, "type"), "\n")
	extra = string.join(GetTextFromElementNode(default, "extra"), "\n")
	print type + "\t(" + extra + ")"


handlerMaps = {
	'options': handleOptions,
	'option': handleOption,
	'optionDefault': handleOptionDefault
}
