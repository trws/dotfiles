from domutils import GetTextFromElementNode
from textutils import FormatTable
from xml.dom.minidom import parseString
import string
import operator

def dom_HandleTable(root):
	"""
	dom_HandleTable(root)

	Given a Document instance, handles the table inside of it.

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

	print FormatTable(text, COL_SPACE = 5)

if __name__ == '__main__':
	xmlFile = open('table.xml', 'r')
	xmlString = string.join(xmlFile.readlines(), "")
	root = parseString(xmlString).documentElement
	dom_HandleTable(root)
