import vimformat
import xml.dom.minidom
import string
import re

from textutils import *
from domutils import *

def getElementsByTagName(self, name):
    nodeList = []

    child = self.firstChild
    while not child.nextSibling is None:
        print child.nodeName
        if child.nodeType == child.ELEMENT_NODE and child.nodeName == name:
            nodeList.append(child)

        child = child.nextSibling

    return nodeList

xml.dom.minidom.Element.getElementsByTagName = getElementsByTagName

def handleElement(rootElement, width=vimformat.TEXT_WIDTH):
    retText = ""
    child = rootElement.firstChild
    while not child is None:

        # if the child is an Element and if a handler exists, then call it.
        if child.nodeType == child.ELEMENT_NODE:
            tagName = child.tagName
            if handlerMaps.has_key(tagName):
                # offset the child text by the current indentation value
                retText += handlerMaps[tagName](child, width)

            child = child.nextSibling

        # if its a text node, collect consecutive text nodes into a single
        # paragraph and indent it.
        elif child.nodeType == child.TEXT_NODE:
            text = ""
            while not child is None and child.nodeType == child.TEXT_NODE:
                text += child.data
                child = child.nextSibling

            retText += IndentParagraphs(text, width)

    return retText

def handleOption(option, width):
    retText = ""
    names = GetTextFromElementNode(option, "name")

    for name in names:
        retText += string.rjust("*"+name+"*", width) + "\n"

    nameTexts = ""
    maxNameLen = -1
    for name in names:
        maxNameLen = max(maxNameLen, len(name + "    "))
        nameTexts += name + "    \n"

    desc = option.getElementsByTagName("desc")[0]
    descText = handleElement(desc, width=width-maxNameLen)

    retText += VertCatString(nameTexts + "    ", None, descText)

    return retText + "\n"


def handleOptionDefault(default, width):
    type = string.join(GetTextFromElementNode(default, "type"), "\n")
    extra = string.join(GetTextFromElementNode(default, "extra"), "\n")
    return type + "\t(" + extra + ")"


def handleTable(root, width):
    """
    dom_HandleTable(root)

    Given a Element instance, handles the table inside of it.

    NOTE: The document instance will be treated as a single table.
          Therefore, if a document contains multiple tables, then this
          function needs to be iterated over it.

          Also, nested tables are not handled.
    """

    # First calculate how many columns are large... i.e occupy more than
    # width/cols wide space.
    maxwidths = {}
    rows = root.getElementsByTagName("row")
    for row in rows:
        cols = row.getElementsByTagName("col")

        rowtext = []
        colwidths = []
        for col in cols:
            coltext = handleElement(col, width)

            # This is the 'width' of the current cell including the
            # whitespace padding.
            colwidths.append(max(map(len, coltext.split("\n"))) \
                                + vimformat.COL_SPACE)

        # update the widths of the columns by finding the maximum
        # width of all cells in this column.
        for i in range(len(colwidths)):
            maxwidths[i] = max(colwidths[i], maxwidths.get(i, -1))

    # now find out how many columns exceed the maximum permitted width.
    # nlarge: number of columns which are too wide.
    # remainingWidth: width which these large columns can share.
    nlarge = 0
    remainingWidth = width
    for colwidth in maxwidths.values():
        if colwidth > width/len(maxwidths):
            nlarge += 1
        else:
            remainingWidth += -colwidth

    # newmaxwidth: width which each of the large columns is allowed.
    newmaxwidth = remainingWidth/max(nlarge, 1)

    # make another run and this time ask each cell to restrict itself to
    # newmaxwidth as calculated above.
    text = []
    rows = root.getElementsByTagName("row")
    for row in rows:
        cols = row.getElementsByTagName("col")
        print "finding %d columns" % len(cols)

        rowtext = []
        for col in cols:
            coltext = handleElement(col, newmaxwidth)

            rowtext.append(coltext)
            print "rowtext = [%s]" % rowtext

        text.append(rowtext)

    # finally, generate the table.
    retText = FormatTable(text, ROW_SPACE = 1, COL_SPACE = 5, justify=0)
    return retText


def handleCode(code, width):
    retText =  GetText(code.childNodes)
    return ">\n" + retText + "\n&codeend;"


def handleList(list, width, marker=0):
    retText = ""
    items = list.getElementsByTagName("item")
    for item in items:
        itemText = handleElement(item, width - len("- "))
        itemText = VertCatString("- ", None, itemText)

        retText += itemText + "\n"

    return retText

def handleNote(note, width):
    noteText = handleElement(note, width-len("NOTE: "))
    noteText = VertCatString("NOTE: ", None, noteText)

    return noteText

def handleLineBreak(lbr, width):
    return "\n"


def handleParBreak(parbrk, width):
    return "\n\n"


def handleBlockQuote(block, width):
    text = handleElement(block, width - len(vimformat.BLOCK_QUOTE))
    text = VertCatString(vimformat.BLOCK_QUOTE,  \
                         len(vimformat.BLOCK_QUOTE), text)

    return text


handlerMaps = {
    'file': handleElement,
    'option': handleOption,
    'optionDefault': handleOptionDefault,
    'table': handleTable,
    'code': handleCode,
    'list': handleList,
    'linebreak': handleLineBreak,
    'par': handleParBreak,
    'br': handleLineBreak,
    'note': handleNote,
    'blockquote': handleBlockQuote,
}
if __name__ == '__main__':
    xmlFile = open('text.xml', 'r')
    xmlString = string.join(xmlFile.readlines(), "")

# vim:et:sts=4
