def GetTextFromElementNode(element, childNamePattern):
	children = element.getElementsByTagName(childNamePattern)
	texts = []
	for child in children:
		texts.append(getText(child.childNodes))

	return texts

def getText(nodelist):
    rc = ""
    for node in nodelist:
        if node.nodeType == node.TEXT_NODE:
            rc = rc + node.data
    return rc
