from textutils import FormatTable,IndentParagraphs
from domutils import GetTextFromElementNode
import string

def handleFile(fileDom):
	text = ""
	# for each child node of the document root...
	for child in fileDom.documentElement.childNodes:
		# if the child is an "element" and it has some handler function in
		# handlerMaps, then use that handler function to further process
		# it.
		if child.nodeType == child.ELEMENT_NODE:
			tagName = child.tagName
			if handlerMaps.has_key(tagName):
				text += handlerMaps[tagName](child)

		# if its a text node, then simply append.
		elif child.nodeType == child.TEXT_NODE:
			text += child.data


def handleOptions(optionsNode):
	options = optionsNode.getElementsByTagName("option")
	
	retText = ""
	for option in options:
		retText += handleOption(option)
		retText += "\n" * vimformat.PAR_SPACE

	return retText


def handleOption(option):
	retText = ""
	names = GetTextFromElementNode(option, "name")

	for name in names:
		retText += string.rjust("*"+name+"*", 70)

	for name in names:
		retText += "\n" + name,

	retText += "\n"
	desc = GetTextFromElementNode(option, "desc")[0]
	return IndentParagraphs(desc, 50, 20)


def handleOptionDefault(default):
	type = string.join(GetTextFromElementNode(default, "type"), "\n")
	extra = string.join(GetTextFromElementNode(default, "extra"), "\n")
	return type + "\t(" + extra + ")"


def handleTable(root):
	"""
	dom_HandleTable(root)

	Given a Element instance, handles the table inside of it.

	NOTE: The document instance will be treated as a single table.
		  Therefore, if a document contains multiple tables, then this
		  function needs to be iterated over it.

	      Also, nested tables are not handled.
	"""
	text = []
	rows = root.getElementsByTagName("row")
	for row in rows:
		colTexts = GetTextFromElementNode(row, "col")
		text.append(colTexts)

	return FormatTable(text, COL_SPACE = 5)


handlerMaps = {
	'file': handleFile,
	'options': handleOptions,
	'option': handleOption,
	'optionDefault': handleOptionDefault
	'table': handleTable
}
if __name__ == '__main__':
	xmlFile = open('text.xml', 'r')
	xmlString = string.join(xmlFile.readlines(), "")
