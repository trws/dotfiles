from textutils import FormatTable
import xml.dom.minidom
import string
import operator

def getElementsByTagName(self, name):
	nodeList = []

	child = self.firstChild
	while not child.nextSibling is None:
		if child.nodeType == child.ELEMENT_NODE and child.nodeName == name:
			nodeList.append(child)

		child = child.nextSibling

	return nodeList

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

	rows = root.getElementsByTagName('row')
	print 'found %d rows' % len(rows)

	child = root.firstChild
	while not child.nextSibling is None:
		if child.nodeType == child.ELEMENT_NODE and child.nodeName == "row":
			print "2: getting row"

		child = child.nextSibling


if __name__ == '__main__':
	xml.dom.minidom.Element.getElementsByTagName = getElementsByTagName

	xmlFile = open('table.xml', 'r')
	xmlString = string.join(xmlFile.readlines(), "")
	root = xml.dom.minidom.parseString(xmlString).documentElement
	table = root.getElementsByTagName('table')[0]

	dom_HandleTable(table)
